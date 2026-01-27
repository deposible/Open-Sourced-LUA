getgenv().Settings = {
    AutoSteal = false,
    AutoSell = false,
    StealAura = false,

    AutoUpgrade = false,
    Upgrades = {"CoinsMultiplier","SpeedBoost","CrateCapacity","GrabbingSpeed","Greenhouse","Boost"},

    AntiFarmer = false,
    AntiDebris = false
}

if AlreadyHas then return end
getgenv().AlreadyHas = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local replicatedstorage = game:GetService("ReplicatedStorage")

task.spawn(function()
    while task.wait(0.25) do
        if Settings.AutoSteal then
            for _, a in pairs(workspace.Plants:GetChildren()) do
                for _, b in pairs(a:GetDescendants()) do
                    if b:IsA("ProximityPrompt") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = a:GetPivot()
                        task.wait(0.3)
                        fireproximityprompt(b)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Settings.AutoSell then
            WIRE.firetouchinterest(
                LocalPlayer.Character.HumanoidRootPart,
                workspace.Interactions.Sell
            )
        end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if Settings.StealAura then
            for _, a in pairs(workspace.Plants:GetChildren()) do
                for _, b in pairs(a:GetDescendants()) do
                    if b:IsA("ProximityPrompt") then
                        if (LocalPlayer.Character.HumanoidRootPart.Position - a:GetPivot().Position).Magnitude <= 10 then
                            fireproximityprompt(b)
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoUpgrade then
            for _, a in pairs(Settings.Upgrades) do
                replicatedstorage.Remotes.UpgradeEvent:FireServer(a)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AntiFarmer then
            if workspace:FindFirstChild("Farmer") then
                workspace.Farmer:Destroy()
            end
        end
    end
end)

task.spawn(function()
    local conn
    while task.wait() do
        if Settings.AntiDebris and not conn then
            for _, a in pairs(workspace:GetChildren()) do
                if a.Name == "Coin" then
                    a:Destroy()
                end
            end
            conn = workspace.ChildAdded:Connect(function(a)
                if a.Name == "Coin" then
                    a:Destroy()
                end
            end)
        elseif not Settings.AntiDebris and conn then
            conn:Disconnect()
            conn = nil
        end
    end
end)

workspace.Plants.ChildAdded:Connect(function(a)
    if not Settings.StealAura then return end
    for _, b in pairs(a:GetDescendants()) do
        if b:IsA("ProximityPrompt") then
            task.spawn(function()
                while Settings.StealAura and a and a.Parent do
                    task.wait(0.05)
                    if (LocalPlayer.Character.HumanoidRootPart.Position - a:GetPivot().Position).Magnitude <= 10 then
                        fireproximityprompt(b)
                    end
                end
            end)
        end
    end
end)
