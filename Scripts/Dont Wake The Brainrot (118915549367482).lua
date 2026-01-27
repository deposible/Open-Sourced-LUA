getgenv().Settings = {
    Delay = 0.25,
    AutoGrabBrainrots = false,
    GrabByRarity = false,
    RequiredRarities = {"Common","Uncommon","Rare","Epic","Legendary","Mythic","Secret","Brainrot God"},
    MinBrainrotValue = 100,
    AutoGrabCash = true,
    AutoRebirth = true,
    AutoUpgradeBrainrots = true,
    AutoPlaceBrainrots = false,
    StealAllBrainrots = false,
    AutoFillWishingWell = false,
    MinWishingWellValue = 50,
    SpectateMap = false
}

if Settings then return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local parseCash = function(str)
    local num, suffix = str:match("([$%d%.]+)([kKmMbB]?)")
    num = tonumber(num and num:match("%d+%.?%d*"))
    if not num then return 0 end
    suffix = suffix:lower()
    if suffix == "k" then
        num *= 1000
    elseif suffix == "m" then
        num *= 1000000
    elseif suffix == "b" then
        num *= 1000000000
    end
    return num
end

local GrabFarm = function()
    for _, a in pairs(workspace.Bases:GetChildren()) do
        if a.Sign.Display.SurfaceGui.PlayerName.Text == LocalPlayer.DisplayName then
            return a
        end
    end
end

local HighestCash = function()
    local Highest = 0
    local Pet
    for _, a in pairs(workspace.Brainrots:GetChildren()) do
        pcall(function()
            local part = a:FindFirstChild("RootPart") or a:FindFirstChildWhichIsA("MeshPart")
            if not part or not part:FindFirstChild("InfoGui") then return end
            if Settings.GrabByRarity then
                local rarity = part.InfoGui.Frame.CharRarity.Text
                if table.find(Settings.RequiredRarities, rarity) then
                    Highest = rarity
                    Pet = part
                end
            else
                local cash = parseCash(part.InfoGui.Frame.CharCash.Text:match("$(.*)/"))
                if cash > Highest then
                    Highest = cash
                    Pet = part
                end
            end
        end)
    end
    return Highest, Pet
end

local GrabHighestPet = function()
    local _, Pet = HighestCash()
    if not Pet then return end
    LocalPlayer.Character.HumanoidRootPart.CFrame = Pet:GetPivot()
    task.wait(0.1)
    fireproximityprompt(Pet:FindFirstChildWhichIsA("ProximityPrompt"))
    task.wait(0.1)
    LocalPlayer.Character.HumanoidRootPart.CFrame = GrabFarm().Sign.Display.CFrame
end

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AutoGrabCash then
            local Farm = GrabFarm()
            if Farm then
                for _, a in pairs(Farm.Platforms:GetChildren()) do
                    WIRE.firetouchinterest(LocalPlayer.Character.HumanoidRootPart, a.Collect)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoRebirth then
            sgame.ReplicatedStorage.Remotes.AttemptRebirthRemote:InvokeServer()
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoUpgradeBrainrots then
            local Farm = GrabFarm()
            if Farm then
                for _, a in pairs(Farm.Platforms:GetChildren()) do
                    if a.Platform:FindFirstChildWhichIsA("Model") then
                        sgame.ReplicatedStorage.Remotes.UpgradeEvent:FireServer(tonumber(a.Name))
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AutoGrabBrainrots or Settings.AutoFillWishingWell then
            LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.DiscoFloor["96"].CFrame
            task.wait(0.15)
            local Cost, _ = HighestCash()
            if Settings.GrabByRarity and table.find(Settings.RequiredRarities, Cost) then
                GrabHighestPet()
            elseif Settings.AutoGrabBrainrots and Cost > Settings.MinBrainrotValue then
                GrabHighestPet()
            elseif Settings.AutoFillWishingWell and Cost > Settings.MinWishingWellValue then
                local Farm = GrabFarm()
                GrabHighestPet()
                LocalPlayer.Character.HumanoidRootPart.CFrame = Farm.WishingWells.Gold:GetPivot()
                task.wait(0.25)
                fireproximityprompt(Farm.WishingWells.Gold.PromptPart.ProximityPrompt)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AutoPlaceBrainrots then
            local Farm = GrabFarm()
            if Farm then
                for _, a in pairs(Farm.Platforms:GetChildren()) do
                    if a.Platform.Transparency < 1 and not a.Platform:FindFirstChildWhichIsA("Model") and LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = a:FindFirstChildWhichIsA("BasePart").CFrame
                        task.wait(0.25)
                        sgame.ReplicatedStorage.Remotes.PlaceBrainrotEvent:InvokeServer(tonumber(a.Name))
                        break
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Settings.StealAllBrainrots then
            repeat
                task.wait()
                GrabHighestPet()
            until #workspace.Brainrots:GetChildren() == 0
        end
    end
end)

task.spawn(function()
    while task.wait() do
        if Settings.SpectateMap then
            workspace.CurrentCamera.CameraSubject = workspace.Map
            workspace.CurrentCamera.FieldOfView = 120
        else
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
            workspace.CurrentCamera.FieldOfView = 70
        end
    end
end)
