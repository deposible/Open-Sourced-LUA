-- Main Game Only (Like actually playing it)

getgenv().Settings = {
    DelayKill = 0.25,
    DelayStore = 0.2,
    DelayCollect = 0.1,
    DelayBuy = 1,

    AutoKillEnemies = false,
    AutoKillCivilians = false,
    AutoStore = false,
    AutoCollectMoney = false,

    AutoBuyBullets = false,
    MinBullets = 5,
    MaxBullets = 100
}

if AlreadyRan then return end 
getgenv().AlreadyRan = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local replicatedstorage = game:GetService("ReplicatedStorage")

task.spawn(function()
    while task.wait(Settings.DelayKill) do
        if Settings.AutoKillEnemies then
            Settings.AutoKillCivilians = false
            for _, loc in pairs({
                workspace.Runners.Skinwalkers:GetChildren(),
                workspace.Nightwalkers:GetChildren(),
                workspace.Runners.Boss:GetChildren()
            }) do
                for _, a in pairs(loc) do
                    pcall(function()
                        if a.Humanoid.Health > 0 then
                            replicatedstorage.Remotes.SniperShot:FireServer(
                                a.HumanoidRootPart.Position,
                                a.HumanoidRootPart.Position,
                                a.HumanoidRootPart
                            )
                            task.wait(0.05)
                        end
                    end)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.DelayKill) do
        if Settings.AutoKillCivilians then
            Settings.AutoKillEnemies = false
            for _, a in pairs(workspace.Runners.Civilians:GetChildren()) do
                pcall(function()
                    if a.Humanoid.Health > 0 then
                        replicatedstorage.Remotes.SniperShot:FireServer(
                            a.HumanoidRootPart.Position,
                            a.HumanoidRootPart.Position,
                            a.HumanoidRootPart
                        )
                        task.wait(0.05)
                    end
                end)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.DelayStore) do
        if Settings.AutoStore then
            for _, loc in pairs({
                workspace.Runners.Skinwalkers:GetChildren(),
                workspace.Nightwalkers:GetChildren()
            }) do
                for _, a in pairs(loc) do
                    pcall(function()
                        if a.Humanoid.Health > 0 then
                            replicatedstorage.Remotes.Store:FireServer(a)
                            task.wait(0.05)
                        end
                    end)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.DelayCollect) do
        if Settings.AutoCollectMoney then
            for _, a in pairs(workspace.GameObjects:GetChildren()) do
                if a.Name == "MoneyBag" and a:FindFirstChild("ProximityPrompt") then
                    fireproximityprompt(a.ProximityPrompt)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.DelayBuy) do
        if Settings.AutoBuyBullets then
            if LocalPlayer.NoSaveData.Cash.Value >= 100
            and LocalPlayer.NoSaveData.Ammo.Value <= Settings.MinBullets then
                local oldcf = LocalPlayer.Character.HumanoidRootPart.CFrame
                repeat
                    LocalPlayer.Character.HumanoidRootPart.CFrame =
                        workspace["NEW MAP"].Village.Gears["x50 Bullets"].Ammo:GetPivot()
                    task.wait(0.1)
                    fireproximityprompt(
                        workspace["NEW MAP"].Village.Gears["x50 Bullets"].Ammo.BuyPrompt
                    )
                until LocalPlayer.NoSaveData.Ammo.Value >= Settings.MaxBullets
                   or LocalPlayer.NoSaveData.Cash.Value <= 100
                task.wait(0.1)
                LocalPlayer.Character.HumanoidRootPart.CFrame = oldcf
            end
        end
    end
end)
