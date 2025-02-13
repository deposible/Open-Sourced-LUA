getgenv().DeposibleOnTop = {
    ["Auto Hide"] = false,
    ["Find Players"] = false,
    ["Spin Wheel"] = false,
    ["Inf Free Common Crates"] = false,
    ["Inf Free Uncommon Crates"] = false,
    ["Inf Free Rare Crates"] = false,
    ["Inf Free Anime Crates"] = false,
    ["Inf Free Spooky Crates"] = false,
    ["Inf Coins"] = false,
    ["Disable Notifications"] = false,
    ["Seeker ESP"] = false, -- didnt use drawing lib cause it aint worth it for this shit game :skull
    ["Hider ESP"] = false -- Same thing as above
}

local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end
local EspObj = function(Type, Name, Parent)
    if not Parent then return end

    if Parent and Parent:FindFirstChild(Name) then
        Parent:FindFirstChild(Name).TextLabel.Text = Type

        return
    end
    
    local BillGUI = Instance.new('BillboardGui', Parent)
    local TextLabel = Instance.new('TextLabel', BillGUI)

    BillGUI.Name = Name
    BillGUI.AlwaysOnTop = true
    BillGUI.Size = UDim2.new(0, 100, 0, 20)

    TextLabel.Text = Type
    TextLabel.Size = UDim2.new(1,0,1,0)
end

newtask(5, "Spin Wheel", function()
    game:GetService('ReplicatedStorage').Network.rewards.claim_spin:InvokeServer()
end)

newtask(0.05, "Inf Free Common Crates", function()
    game:GetService('ReplicatedStorage').Network.inventory.buy_crate:FireServer('Case1', 0)
end)
newtask(0.05, "Inf Free Uncommon Crates", function()
    game:GetService('ReplicatedStorage').Network.inventory.buy_crate:FireServer('Case2', 0)
end)
newtask(0.05, "Inf Free Rare Crates", function()
    game:GetService('ReplicatedStorage').Network.inventory.buy_crate:FireServer('Case3', 0)
end)
newtask(0.05, "Inf Free Anime Crates", function()
    game:GetService('ReplicatedStorage').Network.inventory.buy_crate:FireServer('Anime', 0)
end)
newtask(0.05, "Inf Free Spooky Crates", function()
    game:GetService('ReplicatedStorage').Network.rewards.claim_pass:FireServer('base', 2)
end)

newtask(0, "Inf Coins", function()
    game:GetService('ReplicatedStorage').Network.rewards.claim_pass:FireServer('base', 1)
end)
newtask(1, "Disable Notifications", function()
    game.Players.LocalPlayer.PlayerGui.Notifs.Enabled = false
end)

task.spawn(function()
    while task.wait(1) do
        if DeposibleOnTop["Auto Hide"] and Attribute(game.Players.LocalPlayer, 'CurrentTeam') and game.Players.LocalPlayer:GetAttribute('CurrentTeam') == "Hider" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace.Maps.Lobby.SpawnLocation.CFrame
        end
        if DeposibleOnTop["Find Players"] and Attribute(game.Players.LocalPlayer, 'CurrentTeam') and game.Players.LocalPlayer:GetAttribute('CurrentTeam') == "Seeker" then

            task.wait(2)

            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= game.Players.LocalPlayer and Attribute(plr, 'CurrentTeam') and plr:GetAttribute('CurrentTeam') == "Hider" then
                    EquipTool('Knife')
                    
                    repeat
                        task.wait()

                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)

                        --SimulateClickPress() -- this was a custom function i wont give code to :) sorry skids i still use it. Here is a alternative tho
                        mouse1click() -- This simulates a left mouse button press only works when your tabbed in tho (according to docs)

                        Workspace.Camera.CFrame = CFrame.new(Workspace.Camera.CFrame.Position, plr.Character.HumanoidRootPart.Position)
                    until plr.Character.Humanoid.Health < 2 or not DeposibleOnTop["Find Players"]
                end 
            end
        end
    end
end)
task.spawn(function()
    for _, Plr in pairs(game.Players:GetPlayers()) do
        if Plr ~= game.Players.LocalPlayer then
            local A = Plr.Character:FindFirstChild('EFINDER')
            local B = Plr.Character:FindFirstChild('EHIDER')

            if not A and DeposibleOnTop["Seeker ESP"] and Attribute(Plr, 'CurrentTeam') and Plr:GetAttribute('CurrentTeam') == "Seeker" then
                EspObj('Finder', 'EFINDER', Plr.Character)
            end
            if A and (not DeposibleOnTop["Seeker ESP"] or Attribute(Plr, 'CurrentTeam') and Plr:GetAttribute('CurrentTeam') ~= "Seeker") then
                A:Destroy()
            end


            if not B and DeposibleOnTop["Hider ESP"] and Attribute(Plr, 'CurrentTeam') and Plr:GetAttribute('CurrentTeam') == "Hider" then
                EspObj('Hider', 'EHIDER', Plr.Character)
            end
            if B and (not DeposibleOnTop["Hider ESP"] or Attribute(Plr, 'CurrentTeam') and Plr:GetAttribute('CurrentTeam') ~= "Hider") then
                B:Destroy()
            end
        end
    end
end)
