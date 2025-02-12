getgenv().DeposibleOnTop = {
    ["Auto Farm"] = false,
    ["Claim Rewards"] = false,
    ["Auto Distance"] = false,
    ["Hoop"] = "Hoop1",
    ["Buy Power"] = false,
    ["Buy Speed"] = false,
    ["Buy Areas"] = false
}

local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end

newtask(2.5, "Auto Farm", function()
    game:GetService('ReplicatedStorage').RF:InvokeServer('Shoot', 'Green')
    task.wait(0.50)
    game:GetService('ReplicatedStorage').RE:FireServer('Made')
end)
newtask(1, "Claim Rewards", function()
    for i = 1, 4 do
        game:GetService('ReplicatedStorage').RF:InvokeServer('Reward', i)
    end
end)
newtask(1, "Auto Distance", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace[DeposibleOnTop["Hoop"]].Target.CFrame * CFrame.new(0, -10, game.Players.LocalPlayer.Data.Stats.Power.Value * 10)
end)
newtask(1, "Buy Power", function()
    game:GetService('ReplicatedStorage').RE:FireServer('Upgrade', 'Power')
end)
newtask(1, "Buy Speed", function()
    game:GetService('ReplicatedStorage').RE:FireServer('Upgrade', 'Speed')
end)
newtask(1, "Buy Areas", function()
    game:GetService('ReplicatedStorage').RE:FireServer('Area')
end)
