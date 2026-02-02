getgenv().Settings = {
    AutoFarmMinigame = true, -- These 2 work together with eachother ONLY 1 ON AT A TIME
    GrabMoneyInBox = true,
    GrabMoney = false, -- These 2 work together with eachother ONLY 1 ON AT A TIME
    AutoUpgrade = true,
    UpgradeTable = {"Beg Power", "Income", "Box Tier", "Alley Tier"} -- Just remove what you dont want upgraded or already have upgraded
}

if Settings["AutoFarmMinigame"] then Settings["GrabMoney"] = false end
if AlreadyRan then return end getgenv().AlreadyRan = true end

local LocalPlayer = game.Players.LocalPlayer

local GrabSpot = function()
    for _, a in pairs(workspace.Bases:GetChildren()) do
        if tostring(a.Owner.Value) == LocalPlayer.Name then
            return a
        end
    end
end
local Loop = function(Delay, func)
    task.spawn(function()
        while task.wait(Delay) do
            pcall(func)
        end
    end)
end

Loop(0.1, function()
    if Settings["AutoFarmMinigame"] then
        for _, a in pairs(LocalPlayer.PlayerGui.Main.Minigame:GetChildren()) do
            pcall(function()
                if a.Name == "Green" then
                    firesignal(a.MouseButton1Click)
                end
            end)
        end
    elseif Settings["GrabMoney"] then
        for _, a in pairs(workspace.Money:GetChildren()) do
            if a.Name == "Money" then
                LocalPlayer.Character.HumanoidRootPart.CFrame = a.CFrame
                task.wait(0.05)
                fireproximityprompt(a:FindFirstChildWhichIsA("ProximityPrompt"))
                task.wait(0.05)
            end
        end
    end
end)
Loop(1, function()
    if Settings["GrabMoneyInBox"] then
        local Base = GrabSpot()

        fireproximityprompt(Base.DonateParts.LookAt.ProximityPrompt)
    end
end)
Loop(0.5, function()
    if Settings["AutoUpgrade"] then
        for _, a in pairs(Settings["UpgradeTable"]) do
            game.ReplicatedStorage.Remotes.Upgrade:FireServer(a)
        end
    end
end)
