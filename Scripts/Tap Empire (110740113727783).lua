getgenv().Settings = {
    ["Pro Clicker Bypass"] = true,
    ["Pro Rebirth Bypass"] = true,
    ["Auto Craft"] = true,
    ["Equip Best Pets"] = true,
    ["Auto Click"] = true,
    ["Auto Playtime Rewards"] = true,
    ["Auto Upgrade Shop"] = true,
    ["What To Upgrade"] = {} -- [[ ONLY paste the second string.]] {{"WalkSpeed", "Walk"}, {"JumpPower", "Jump"}, {"Rebirths", "Rebirths"}, {"Click Upgrade", "Click"}, {"Auto Click Speed", "AutoClick"}, {"Equip Upgrade", "Equip"}, {"Storage Upgrade", "Storage"}, {"Luck Upgrade", "Luck"}, {"Hatch Upgrade", "Faster"}}
}

if ReExecute then return else getgenv().ReExecute end

local LocalPlayer = game.Players.LocalPlayer

local loop = function(del, func)
    task.spawn(function()
        while task.wait(del) do
            pcall(func)
        end
    end)
end

loop(0.01, function()
    if Settings["Auto Click"] then
        game.ReplicatedStorage.AddClick:FireServer()
    end
end)
loop(1, function()
    LocalPlayer.Gamepasses.Clicker.Value = Settings["Pro Clicker Bypass"]
    LocalPlayer.Gamepasses.Rebirth.Value = Settings["Pro Rebirth Bypass"]

    if Settings["Auto Craft"] then
        firesignal(LocalPlayer.PlayerGui.Main.MainFrame.PetInventory.CraftAll.MouseButton1Click)
    end
    if Settings["Equip Best Pets"] then
        firesignal(LocalPlayer.PlayerGui.Main.MainFrame.PetInventory.Unequipall.MouseButton1Click)
        task.wait(4)
        firesignal(LocalPlayer.PlayerGui.Main.MainFrame.PetInventory.Best.MouseButton1Click)
    end
    if Settings["Auto Playtime Rewards"] then
        for i = 1, 9 do
            game.ReplicatedStorage.GiftFolder.ClaimGift:InvokeServer(i)
        end
    end
    if Settings["Upgrade Shop"] then
        for i, a in pairs(Settings["What To Upgrade"]) do
            game.ReplicatedStorage.GemShop[a]:FireServer()
        end
    end
end)
