getgenv().DeposibleOnTop = {
    ["Grab Candy Corn"] = false,
    ["Farm Stages"] = false,
    ["Skip Stage"] = "B"
}

local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end
local NextStage = function()
    pcall(function()
        if game.Players.LocalPlayer.leaderstats.Stage.Value ~= 51 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace.Checkpoints:FindFirstChild(game.Players.LocalPlayer.leaderstats.Stage.Value + 1).CFrame
        else
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, Workspace.StartOver.Triggger, 0)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, Workspace.StartOver.Triggger, 1)
            task.wait(0.10)
            replicatedstorage.Events.RestartEvent:FireServer('Restart')
        end
    end)
end

newtask(0, "Grab Candy Corn", function()
    pcall(function()
        for _, candycorn in pairs(Workspace.Spawnable.Spawners:GetDescendants()) do
            if candycorn.Name == "CandyCorn" then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, candycorn, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, candycorn, 1)
            end
        end
    end)
end)
newtask(0, "Farm Stages", function()
    NextStage()
end)

game:GetService('UserInputService').InputBegan:Connect(function(k)
    if k.KeyCode ~= Enum.KeyCode.Unkown and k.KeyCode == Enum.KeyCode.[DeposibleOnTop["Skip Stage"]] then
        NextStage()
    end
end)
