getgenv().Settings = {
    AutoClick = false,
    AutoRebirth = false,
    CraftAll = false,
    SpinWheel = false,
    ClaimChests = false,
    BestWorldBoost = false,

    AutoUpgradeAura = false,
    AutoUpgradeTapSkin = false,
    AutoSpawnUpgrades = false,
    AutoSpaceUpgrades = false,
    AutoAquaUpgrades = false,
    AutoFantasyUpgrades = false,
    AutoTimeUpgrades = false,
    AutoFireUpgrades = false,
    AutoFunUpgrades = false,
    AutoElementalUpgrades = false,
    AutoCelestialUpgrades = false,

    AutoBuyPotions = false,
    Potions = {"x2Clicks","x2Gems","x2Luck","x2Rebirths","x2PetXP","x2HatchSpeed"},
    AutoBuyAquaPotions = false,
    AquaPotions = {"x3Clicks","x3Gems","x2Luck","x3Rebirths","x2PetLevel"},

    GrabAllAmulets = false,
    FreeBoost = false
}

if AlreadyLoaded then return end
getgenv().AlreadyLoaded = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    while task.wait(0.01) do
        if Settings.AutoClick then
            game.ReplicatedStorage.Events.Click4:FireServer()
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Settings.AutoRebirth then
            local Max = 0
            for _, a in pairs(LocalPlayer.PlayerGui.MainUI.RebirthFrame.Top.Holder.ScrollingFrame:GetChildren()) do
                if a:IsA("ImageLabel") and a.Visible and tonumber(a.Name) and tonumber(a.Name) > Max then
                    Max = tonumber(a.Name)
                end
            end
            game.ReplicatedStorage.Events.Rebirth:FireServer(Max)
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if Settings.CraftAll then
            game.ReplicatedStorage.Functions.Request:InvokeServer("CraftAll", {})
        end
    end
end)

task.spawn(function()
    while task.wait(30) do
        if Settings.SpinWheel then
            game.ReplicatedStorage.Functions.Spin:InvokeServer()
        end
    end
end)

task.spawn(function()
    while task.wait(60) do
        if Settings.ClaimChests then
            for _, a in pairs({"Beach","Winter","Cyber","Nuclear","Hell","Space","Galaxy Forest","Shadow","Hacker","Aqua","Pirate","Fantasy","Haunted Castle","Time","Viking World","Fire","Magma Temple","Fire Maze","Celestial"}) do
                game.ReplicatedStorage.Events.Chest:FireServer(a)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Settings.BestWorldBoost then
            game.ReplicatedStorage.Events.WorldBoost:FireServer("Solar System")
            game.ReplicatedStorage.Events.StoreWorldBoost:FireServer("Solar System")
        end
    end
end)

task.spawn(function()
    while task.wait(60) do
        if Settings.AutoUpgradeAura then
            game.ReplicatedStorage.Functions.Aura:InvokeServer()
        end
        if Settings.AutoUpgradeTapSkin then
            game.ReplicatedStorage.Functions.TapSkin:InvokeServer()
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoSpawnUpgrades then
            for _, a in pairs({"ClickMultiplier","FreeAutoClicker","RebirthButtons","WalkSpeed","GemsMultiplier","PetEquip","PetStorage","LuckMultiplier","FasterFreeAutoClicker"}) do
                game.ReplicatedStorage.Functions.Upgrade:InvokeServer(a)
                task.wait(0.25)
            end
        end
        if Settings.AutoSpaceUpgrades then
            for _, a in pairs({"ClickMultiplier","ChestCountdown","BankSpace","MaxCombo","PetEquip","LuckMultiplier","Teleport","GoldenChance","ToxicChance"}) do
                game.ReplicatedStorage.Functions.Upgrade:InvokeServer(a,"space")
            end
        end
        if Settings.AutoAquaUpgrades then
            for _, a in pairs({"ClickMultiplier","GemsMultiplier","PetEquip","HatchSpeed","LuckMultiplier","PetStorage","EvoltionSlot","EvolutionTime","DarkEvolutionChance"}) do
                game.ReplicatedStorage.Functions.Upgrade:InvokeServer(a,"aqua")
            end
        end
        if Settings.AutoFantasyUpgrades then
            for _, a in pairs({"ClickMultiplier","GemsMultiplier","PetEquip","HatchSpeed","LuckMultiplier","PetStorage"}) do
                game.ReplicatedStorage.Functions.Upgrade:FireServer(a,"fantasy")
            end
        end
        if Settings.AutoTimeUpgrades then
            for _, a in pairs({"ClickMultiplier","PetEquip","BankSlots","LuckMultiplier","PetStorage","GalaxyPetsChance"}) do
                game.ReplicatedStorage.Functions.Upgrade:FireServer(a,"time")
            end
        end
        if Settings.AutoFireUpgrades then
            for _, a in pairs({"ClickMultiplier","BankSlots","PetEquip","MaxClicksCombo","LuckMultiplier","Rebirths"}) do
                game.ReplicatedStorage.Functions.Upgrade:FireServer(a,"fire")
            end
        end
        if Settings.AutoFunUpgrades then
            for _, a in pairs({"ClickMultiplier","LuckMultiplier","PetEquip","PetUpgraderTier","PetMachineTier","BetterTierChance"}) do
                game.ReplicatedStorage.Functions.Upgrade:FireServer(a,"fun")
            end
        end
        if Settings.AutoElementalUpgrades then
            for _, a in pairs({"ClickMultiplier","LuckMultiplier","PetEquip","MaxClicksCombo","GemsMultiplier","GalaxyPetsChance"}) do
                game.ReplicatedStorage.Functions.Upgrade:FireServer(a,"elemental")
            end
        end
        if Settings.AutoCelestialUpgrades then
            for _, a in pairs({"ClickMultiplier","LuckMultiplier","PetEquip","ShinyChance","PetUpgraderTier","PetMachineTier"}) do
                game.ReplicatedStorage.Functions.Upgrade:FireServer(a,"celestial")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoBuyPotions then
            for _, a in pairs(Settings.Potions) do
                game.ReplicatedStorage.Events.Potion:FireServer(a,1)
            end
        end
        if Settings.AutoBuyAquaPotions then
            for _, a in pairs(Settings.AquaPotions) do
                game.ReplicatedStorage.Events.Potion:FireServer(a,1,"aqua")
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.GrabAllAmulets then
            for _, loc in pairs(workspace.Scripts.Amulets.Collect:GetChildren()) do
                for _, a in pairs(loc:GetChildren()) do
                    for _ = 1, 5 do
                        LocalPlayer.Character.HumanoidRootPart.CFrame = a:GetPivot()
                        task.wait(0.05)
                        fireproximityprompt(a:FindFirstChildWhichIsA("ProximityPrompt"))
                        task.wait(0.1)
                    end
                end
            end
        end
        if Settings.FreeBoost then
            game.ReplicatedStorage.Events.DestructionMachine:FireServer()
        end
    end
end)
