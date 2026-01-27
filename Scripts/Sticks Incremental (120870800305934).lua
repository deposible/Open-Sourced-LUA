getgenv().Settings = {
    DelayFast = 0.05,
    DelaySlow = 2,
    AutoGrabOPSticks = false,
    AutoClick = false,
    AutoRebirth = false,
    AutoUpgrades = false,
    Upgrades = {"CollectAmount","StickCooldown","MaxCapacity"},
    AutoRebirthUpgrades = false,
    RebirthUpgrades = {"CollectAmountReb","RadiusReb","StickCooldownReb"},
    AutoWoodPumpUpgrades = false,
    WoodPumpUpgrades = {"CollectAmountWood","MoreRebWood","MoreWood"},
    AutoClickUpgrades = false,
    ClickUpgrades = {"CollectAmountClicks","MoreRebirthsClicks","AutoclickerClicks"}
}

if Settings then return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    while task.wait(Settings.DelayFast) do
        if Settings.AutoGrabOPSticks then
            game.ReplicatedStorage.Events.PickUp:FireServer("ShadowStick")
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.DelayFast) do
        if Settings.AutoClick then
            game.ReplicatedStorage.Events.Click:FireServer()
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoRebirth then
            game.ReplicatedStorage.Events.Rebirth:FireServer()
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.DelaySlow) do
        if Settings.AutoUpgrades then
            for _, a in pairs(Settings.Upgrades) do
                game.ReplicatedStorage.Events.BuyMaxUpgrade:FireServer(a, LocalPlayer.Values.Sticks)
                task.wait(0.5)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.DelaySlow) do
        if Settings.AutoRebirthUpgrades then
            for _, a in pairs(Settings.RebirthUpgrades) do
                game.ReplicatedStorage.Events.BuyMaxUpgrade:FireServer(a, LocalPlayer.Values.Rebirths)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.DelaySlow) do
        if Settings.AutoWoodPumpUpgrades then
            for _, a in pairs(Settings.WoodPumpUpgrades) do
                game.ReplicatedStorage.Events.BuyMaxUpgrade:FireServer(a, LocalPlayer.Values.Wood)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.DelaySlow) do
        if Settings.AutoClickUpgrades then
            for _, a in pairs(Settings.ClickUpgrades) do
                game.ReplicatedStorage.Events.BuyMaxUpgrade:FireServer(a, LocalPlayer.Values.Clicks)
            end
        end
    end
end)
