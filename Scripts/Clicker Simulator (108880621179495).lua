
getgenv().Settings = {
  ["Auto Rebirth"] = true,
  ["Auto Click"] = true,
  ["Auto Upgrade Mastery"] = true,
  ["Best World Boost"] = true,
  ["Craft All Pets"] = true, --
  ["Auto Rebirth Upgrader"] = true,
  ["Auto Gem Shop Upgrades"] = true,
  ["Gem Shop Upgrades"] = {
    ["Tap Multiplier"] = {
      ["On"] = true,
      ["Name"] = "ClickMulti"
    },
    ["Gem Multiplier"] = {
      ["On"] = true,
      ["Name"] = "GemMulti"
    },
    ["Gem Chance"] = {
      ["On"] = true,
      ["Name"] = "GemChance"
    },
    ["Rebirth Buttons"] = {
      ["On"] = true,
      ["Name"] = "RebirthButtons"
    },
    ["More Walkspeed"] = {
      ["On"] = true,
      ["Name"] = "WalkSpeed"
    },
    ["Inventory Storage"] = {
      ["On"] = true,
      ["Name"] = "MoreStorage"
    },
    ["Pet Equip"] = {
      ["On"] = true,
      ["Name"] = "PetEquip"
    },
    ["Luck Multiplier"] = {
      ["On"] = true,
      ["Name"] = "LuckMulti"
    },
    ["Faster Hatch"] = {
      ["On"] = true,
      ["Name"] = "HatchSpeed"
    },
    ["Critical Hit"] = {
      ["On"] = true,
      ["Name"] = "CriticalChance"
    }
  },
  ["Auto Tech Shop Upgrades"] = true,
  ["Tech Shop Upgrades"] = {
    ["Tech Coins Multi"] = {
      ["On"] = true,
      ["Name"] = "GalaxyCoinsMulti"
    },
    ["Tap Multiplier"] = {
      ["On"] = true,
      ["Name"] = "ClickMulti"
    },
    ["Gem Multiplier"] = {
      ["On"] = true,
      ["Name"] = "GemMulti"
    },
    ["Inventory Storage"] = {
      ["On"] = true,
      ["Name"] = "MoreStorage"
    },
    ["Pet Equip"] = {
      ["On"] = true,
      ["Name"] = "PetEquip"
    },
    ["Shiny Pet Chance"] = {
      ["On"] = true,
      ["Name"] = "GoldenMulti"
    },
    ["Rainbow Pet Chance"] = {
      ["On"] = true,
      ["Name"] = "RainbowMulti"
    }
  },
  ["Auto Buy Potions"] = true,
  ["Potions"] = {
    ["2x Taps"] = {
      ["On"] = true,
      ["Name"] = "Click"
    },
    ["2x Gems"] = {
      ["On"] = true,
      ["Name"] = "Gem"
    },
    ["2x Rebirths"] = {
      ["On"] = true,
      ["Name"] = "Rebirth"
    },
    ["2x Luck"] = {
      ["On"] = true,
      ["Name"] = "Luck"
    },
    ["2x Galaxy Coins"] = {
      ["On"] = true,
      ["Name"] = "FreeGalaxyCoins"
    },
    ["2x Pet XP"] = {
      ["On"] = true,
      ["Name"] = "FreeExperience"
    },
  },
  ["Auto Open Eggs"] = true,
  ["Eggs Multiplier"] = "Triple", -- Other Option: "Single"
  ["Selected Egg"] = nil -- Options will print in console (F9 or /console in chat) just re-execute with changes!
}

if ReExecute then
  return
else
  getgenv().ReExecute = true
end

local LocalPlayer = game.Players.LocalPlayer

local HighestRebirth = function()
    local HighestRound = 0

    for _, a in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Rebirth.Holder.Holder.ScrollHolder.ScrollingFrame:GetChildren()) do
        if a:IsA('Frame') and a.Visible and tonumber(a.Name) and tonumber(a.Name) > HighestRound then
            HighestRound = tonumber(a.Name)
        end
    end

    return HighestRound
end
local BuyTechRoadmap = function() -- Not Used. To use use "BuyTechRoadmap()" you can untag below just delete the "--"
    for i = 1, 25 do
        game.ReplicatedStorage.Events.PurchaseGemTier:FireServer(i, "Galaxy")
    end
end
local BuySpawnRoadmap = function() -- Not Used. To use use "BuySpawnRoadmap()" you can untag below just delete the "--"
    for i = 1, 50 do
        game.ReplicatedStorage.Events.PurchaseGemTier:FireServer(i)
    end
end

for _, a in pairs(workspace.Scripted.EggHolders:GetChildren()) do
    print(a.Name)
end

task.spawn(function()
    while task.wait(0.1) do
        if Settings["Auto Open Eggs"] then
            Tabs.Eggs:CreateToggle({name = "Auto Open Eggs", delay = 0.1, callback = function()
                game.ReplicatedStorage.Functions.Hatch:InvokeServer(Settings["Selected Egg"], Settings["Eggs Multiplier"])
            end})
        end
    end
end
task.spawn(function()
    while task.wait(0.01) do
      if Settings["Auto Click"] then
        game.ReplicatedStorage.Events.Click:FireServer()
      end
    end
end)

--BuySpawnRoadmap()
--BuyTechRoadmap()

while task.wait(1) do
  if Settings["Auto Rebirth"] then
      game.ReplicatedStorage.Events.Rebirth:FireServer(HighestRebirth())
  end
  if Settings["Auto Upgrade Mastery"] then
      game.ReplicatedStorage.Functions.IncreaseMastery:InvokeServer()
  end
  if Settings["Best World Boost"] then
    game.ReplicatedStorage.Events.SetWorldBoost:FireServer("Wild West")
  end
  if Settings["Craft All Pets"] then
    firesignal(LocalPlayer.PlayerGui.PetCrafting.Holder.Holder.CraftAll.Click.MouseButton1Up)
  end
  if Settings["Auto Rebirth Upgrader"] then
    game.ReplicatedStorage.Functions.PurchaseCrypticLuckUpgrader:InvokeServer()
  end
  if Settings["Auto Gem Shop Upgrades"] then
      for _, a in pairs(Settings["Gem Shop Upgrades"]) do
        if a["On"] then
          game.ReplicatedStorage.Functions.PurchaseUpgrade:InvokeServer('Spawn', a["Name"])
        end
    end
  end
  if Settings["Auto Tech Shop Upgrades"] then
      for _, a in pairs(Settings["Tech Shop Upgrades"]) do
        if a["On"] then
          game.ReplicatedStorage.Functions.PurchaseUpgrade:InvokeServer('Galaxy', a["Name"])
        end
    end
  end
  if Settings["Auto Buy Potions"] then
    for _, a in pairs(Settings["Potions"]) do
        if a["On"] then
          game.ReplicatedStorage.Functions.BuyPotion:InvokeServer(a["Name"], 1)
        end
    end
  end
end
