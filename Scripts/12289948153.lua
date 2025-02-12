getgenv().DeposibleOnTop = {
  ["Auto Stages"] = false
}

local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end

newtask(0, "Auto Stages", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace.Stages:FindFirstChild(game.Players.LocalPlayer.leaderstats.Stage.Value + 1).CheckpointZone.CFrame
end)
