-- both 128120317905952 & 116530775830497
getgenv().Settings = {
    Delay = 0.1,
    AutoRaceFinish = false,
    AutoClaimGifts = false,
    BuyPaddleTillRarity = false,
    PaddleRarities = {"Epic","Legendary","Secret"},
    BuyBoatTillRarity = false,
    BoatRarities = {"Epic","Legendary","Secret"}
}

if AlreadyLoaded then return end
getgenv().AlreadyLoaded = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AutoRaceFinish then
            local gui = LocalPlayer.PlayerGui
            if gui
            and gui:FindFirstChild("ProgressBar")
            and gui.ProgressBar.TopHUD.ProgressBar.Timer.Visible then
                game.ReplicatedStorage.src.Packages.Knit.Services.GameService.RE.HandleClick:FireServer(3)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AutoClaimGifts then
            for i = 1, 9 do
                game.ReplicatedStorage.src.Packages.Knit.Services.RewardService.RF.ClaimTimeReward:InvokeServer(i)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.BuyPaddleTillRarity then
            local r = game.ReplicatedStorage.src.Packages.Knit.Services.SpinAuraService.RF.Spin:InvokeServer("Paddle","Normal")
            if table.find(Settings.PaddleRarities, r) then
                Settings.BuyPaddleTillRarity = false
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.BuyBoatTillRarity then
            local r = game.ReplicatedStorage.src.Packages.Knit.Services.SpinAuraService.RF.Spin:InvokeServer("Boat","Normal")
            if table.find(Settings.BoatRarities, r) then
                Settings.BuyBoatTillRarity = false
            end
        end
    end
end)
