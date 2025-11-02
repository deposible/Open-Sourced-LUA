getgenv().Settings = {
	["Auto Open Eggs"] = false,
	["Egg To Open"] = nil, -- press F9 or "/console" in chat for Eggs
	["Grab Stars"] = true,
	["Claim Achievements"] = true,
	["Claim Road Rewards"] = true,
	["Claim Rewards"] = true,
	["Claim Quests"] = true,
	["Use Potions"] = true,
	["Upgrade Potions"] = true,
	["Potions To Use"] = {}, -- press F9 or "/console" in chat for Potions
	["Potions To Upgrade"] = {}, -- press F9 or "/console" in chat for Potions
	["Auto Gold Pets"] = true,
	["Auto Rainbow Pets"] = true,
	["Auto Ascend Pets"] = true,
	["Auto Upgrade"] = true,
	["What To Upgrade"] = {}, -- Use the second string and insert it here {{"Egg Luck", "EGG_LUCK"}, {"More Gems", "MORE_GEMS"}, {"Inventory Slots", "PET_SLOTS"}, {"Star Spawning Luck", "STAR_SPAWN_LUCK"}, {"Walk Speed", "WALK_SPEED"}, {"Potion Duration", "POTION_DURATION"}, {"Secret Luck", "SECRET_LUCK"}, {"Huge Luck", "HUGE_LUCK"}}
	["Auto Grab Chests"] = true,
	["Unlock Chests"] = true -- literally dumbest checks they coulda done for this ngl. literal dogshit devs
}

if ReExecute then
	return
else
	getgenv().ReExecute = true
end

local Eggs = {}
local Potions = {}
local Modules = {}

local LocalPlayer = game.Players.LocalPlayer
local replicatedstorage = game.ReplicatedStorage

local GrabClosestLocation = function()
  local closest, closestdis = nil, math.huge

  for _, a in pairs(workspace.StarSpawnZones:GetChildren()) do
      if (LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude < closestdis then
          closest = a
          closestdis = (LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
      end
  end

  return closest
end
local loop = function(del, func)
  while task.wait(del) do
      pcall(func)
  end
end

for _, a in pairs(LocalPlayer.Data.Eggs:GetChildren()) do
    print("Egg: "..a.Name)
end
for _, a in pairs(LocalPlayer.Data.Potions:GetChildren()) do
    print("Potion: "..a.Name)
end
for _, a in pairs(replicatedstorage:GetDescendants()) do
    if a:IsA('ModuleScript') then
        task.spawn(function() pcall(function() Modules[a.Name] = require(a) end) end)
    end
end

loop(0.01, function()
    if Settings["Grab Stars"] then
      local Zone = GrabClosestLocation()
    
      for _, a in pairs(workspace.LocalStars[Zone.Name]:GetChildren()) do
          replicatedstorage.Core.Remote.collectStar:FireServer(Zone.Name, a.Name)
          task.wait()
      end
    end
    if Settings["Upgrade Potions"] then
      for _, a in pairs(Settings["Potions To Upgrade"]) do
          replicatedstorage.Core.Remote.craftPotion:InvokeServer(a)
      end
    end
end)
loop(1, function()
	if Settings["Auto Gold Pets"] then
		replicatedstorage.PetSystem.Remote.CraftPets:InvokeServer('*all', 0)
	end
	if Settings["Auto Rainbow Pets"] then
		replicatedstorage.PetSystem.Remote.CraftPets:InvokeServer('*all', 1)
	end
	if Settings["Auto Ascend Pets"] then
		for _, a in pairs(LocalPlayer.Data.Pets:GetChildren()) do
			replicatedstorage.PetSystem.Remote.AscendPets:InvokeServer(a.Name)
		end
	end
    if Settings["Claim Achievements"] then
      for _, a in pairs(LocalPlayer.Data.Achievements:GetChildren()) do
          replicatedstorage.Core.Remote.finishQuest:InvokeServer(a.Name)
      end
    end
    if Settings["Claim Road Rewards"] then
      replicatedstorage.Core.Remote.claimLevelRoad:InvokeServer()
    end
    if Settings["Auto Open Eggs"] then
       replicatedstorage.PetSystem.Remote.Hatch(Settings["Egg To Open"], "Open x3")
    end
    if Settings["Use Potions"] then
      for i, a in pairs(Settings["Potions To Use"]) do
            replicatedstorage.Core.Remote.usePotion:InvokeServer(a)    
        end
    end
	if Settings["Auto Upgrade"] then
		for _, a in pairs(Settings["What To Upgrade"]) do
			replicatedstorage.Core.Remote.buyUpgrade:InvokeServer(a)
		end
	end
	if Settings["Auto Grab Chests"] then
		for i, a in pairs(Modules.Chests) do
			replicatedstorage.Core.Remote.claimChest:InvokeServer(i)
		end
	end
	if Settings["Unlock Chests"] then
		for i, a in pairs(Modules.Chests) do
			Modules.Chests[i].canUse = function() return true end
		end
	end
end)
loop(30, function()
  if Settings["Claim Rewards"] then
    for i = 1, 16 do
        replicatedstorage.Core.Remote.claimGift:InvokeServer(i)                
    end
  end
  if Settings["Claim Quests"] then
    for i, a in pairs(LocalPlayer.Data.Daily_Quests:GetChildren()) do
        replicatedstorage.Core.Remote.finishQuest:InvokeServer(a.Name)
    end
    for i, a in pairs(LocalPlayer.Data.Weekly_Quests:GetChildren()) do
        replicatedstorage.Core.Remote.finishQuest:InvokeServer(a.Name)
    end
  end
end)
