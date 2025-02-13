getgenv().DeposibleOnTop = {
    ["Grab Coins"] = false,
    ["Auto Hide"] = false,
    ["Find Players"] = false,
    ["Claim Achievements"] = false,
    ["Auto Unlock Jail"] = false,
    ["Claim Free Stuff"] = false,
}



local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end

newtask(0, "Grab Coins", function()
    pcall(function()
        for _, coins in pairs(Workspace.MapHolder:GetChildren()) do
            if coins.Name == "Coin" then
                firetouchinterest(coins, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
                firetouchinterest(coins, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
            end
        end
    end)
end)
newtask(1, "Claim Achievements", function()
    pcall(function()
        for _, a in pairs(game.Players.LocalPlayer.PlayerGui.Achievements.Main.DisplayArea.Badges:GetChildren()) do
            if a:IsA('Frame') then
                game.ReplicatedStorage.Event.serverRf:InvokeServer( 'ClaimBadgeReward', a.Name )
            end
        end
    end)
end)
newtask(1, "Claim Free Stuff", function()
    game:GetService('ReplicatedStorage').Event.serverRf:InvokeServer("PurchaseBundle", game:GetService('ReplicatedStorage').Bundles.HalloweenBundleFree)
end)

task.spawn(function()
    while task.wait(0.20) do
        if game.Players.LocalPlayer.Character:FindFirstChild('KillScript') and DeposibleOnTop["Find Players"] then
            for _, plrs in pairs(game.Players:GetPlayers()) do
                pcall(function()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plrs.Character.HumanoidRootPart.CFrame
                    task.wait(0.75)
                end)
            end
        end
        if DeposibleOnTop["Auto Unlock Jail"] then
            for _, jail in pairs(Workspace.MapHolder:GetDescendants()) do
                if jail.Name == "Jail" and jail:IsA('Model') and jail:FindFirstChild('Unlock') then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = jail.Unlock.CFrame

                    task.wait(0.75)
                end
            end
        end
        if DeposibleOnTop["Auto Hide"] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace.LobbyArea.Spawn.CFrame * CFrame.new(0, 50, 0)
        end
    end
end)
