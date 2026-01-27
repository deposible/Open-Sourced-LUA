getgenv().Settings = {
    AutoFarmPower = false,
    AutoFarmWin = false,
    AutoRebirth = false,
    AutoSpinWheel = false,
    ClaimFreeGifts = false,
    BuyNextArea = false,
    AutoUpgrade = false,
    Upgrades = {"PlaneSpeed","BalloonAmount","PlaneSize","BonusMultiplier"}
}

if AlreadyRan then return end
getgenv().AlreadyRan = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local replicatedstorage = game:GetService("ReplicatedStorage")

local BestArea = function()
    local HighestZone = 0
    for i = 1, 14 do
        if not workspace.Zones["Zone"..i]:FindFirstChild("Lock") and HighestZone < i then
            HighestZone = i
        end
    end
    return HighestZone == 0 and 1 or HighestZone + 1
end

task.spawn(function()
    while task.wait(0.025) do
        if Settings.AutoFarmPower then
            for _ = 1, 10 do
                replicatedstorage.Events.RewardAction:FireServer("Train",{1,"Zone"..BestArea()})
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Settings.AutoFarmWin then
            for _ = 1, 10 do
                replicatedstorage.Events.RewardAction:FireServer("Win",{"Zone"..BestArea(),{"Yellow","Orange"},{},0})
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.25) do
        if Settings.AutoSpinWheel then
            replicatedstorage.Events.RewardActionFunction:InvokeServer("Spin")
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if Settings.ClaimFreeGifts then
            for i = 1, 12 do
                replicatedstorage.Events.RewardAction:FireServer("Playtime", i)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.BuyNextArea then
            local preWins = LocalPlayer.leaderstats.Wins.Value
            replicatedstorage.Events.RewardAction:FireServer("ZonePurchase")
            task.wait(2)
            if preWins > LocalPlayer.leaderstats.Wins.Value then
                local zone = workspace.Zones["Zone"..BestArea()]
                if zone:FindFirstChild("Buy Wall") then
                    zone["Buy Wall"]:Destroy()
                end
                if zone:FindFirstChild("Lock") then
                    zone["Lock"]:Destroy()
                end
            end
        end
        if Settings.AutoRebirth then
            replicatedstorage.Events.RewardAction:FireServer("Rebirth")
        end
        if Settings.AutoUpgrade then
            for _, a in pairs(Settings.Upgrades) do
                replicatedstorage.Events.RewardAction:FireServer("Upgrade", a)
            end
        end
    end
end)
