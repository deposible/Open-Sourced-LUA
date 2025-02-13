getgenv().DeposibleOnTop = {
    ["Infinite Stats"] = false,
    ["Auto Rebirth"] = false,
    ["Claim Free Gifts"] = false
}

local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end

newtask(0.01, "Infinite Stats", function()
    game.ReplicatedStorage.Swim.Remote.ApplyPVEMatch:InvokeServer(i)
    task.wait(0.10)
    game.ReplicatedStorage.Swim.Remote.SubmitPVEMatchResult:InvokeServer({["rank"] = 1, ["avgManification"] = 1.00, ["maxManification"] = 1.00})
end)
newtask(0.1, "Auto Rebirth", function()
    game:GetService('ReplicatedStorage').Rebirth.Remote.TryRebirth:InvokeServer()
end)
newtask(0.5, "CLaim Free Gifts", function()
    for i = 1, 12 do
        game:GetService('ReplicatedStorage').OnlineRewardFolder.Remote.ApplyActiveReward:InvokeServer(i)
    end
end)
