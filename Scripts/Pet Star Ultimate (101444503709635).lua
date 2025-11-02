--[[
	Only Use second string value 
	Upgrade List: {{"Egg Luck", "EGG_LUCK"}, {"More Diamonds", "MORE_DIAMONDS"}, {"Magnet Range", "MAGNET_RADIUS"}, {"More Stars", "MORE_STARS"}, {"Item Drop Luck", "DROP_LUCK"}, {"Huge/Secret Luck", "UNIQUE_LUCK"}, {"Walk Speed", "WALK_SPEED"}}

	Blend List:	{{"Gravity Fruit", "Gravity Fruit"}, {"Heavenly Smoothie", "Heavenly Smoothie"}, {"XP Smoothie", "XP Smoothie"}, {"Star Smoothie", "Star Smoothie"}, {"Luck Smoothie", "Luck Smoothie"}, {"Diamond Smoothie", "Diamond Smoothie"}}
]]

getgenv().Settings = {
	["Grab Stars"] = true,
	["Grab Drops"] = true,
	["Auto Rank Up"] = true,
	["Auto do Match Game"] = true,
	["Auto Star Rush"] = true,
	["Auto Buy Zones"] = true,
	["Go To Best Zone"] = true,
	["Claim Level Road"] = true,
	["Auto Claim Chests"] = true,
	["Claim Time Rewards"] = true,
	["Claim Quests"] = true,
	["Auto Craft Gold"] = true,
	["Auto Craft Rainbow"] = true,
	["Auto Use Items"] = false, -- Will print in console (F9 or /console in chat)
	["Items To Use"] = {},
	["Auto Upgrade"] = false,
	["What To Upgrade"] = {}, -- List Above
	["Auto Blend"] = false,
	["What To Blend"] = {}, -- List Above
}

if ReExecute then return else getgenv().ReExecute = true end

local Items = {}
local Modules = {}

local LocalPlayer = game.Players.LocalPlayer
local replicatedstorage = game.ReplicatedStorage

local GrabClosestLocation = function()
	local closest, closestdis = nil, math.huge

	for _, a in pairs(workspace.SpawnZones:GetChildren()) do
		if (LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude < closestdis then
			closest = a
			closestdis = (LocalPlayer.Character.HumanoidRootPart.Position - a.Position).Magnitude
		end
	end

	return closest
end
local loop = function(del, func)
	task.spawn(function()
		while task.wait(del) do
			pcall(func)
		end
	end)
end

task.spawn(function()
    if LocalPlayer.PlayerGui.InfoHover:FindFirstChild("Pet Select") and LocalPlayer.PlayerGui.InfoHover["Pet Select"].Visible then
        replicatedstorage.Game.Pet.Remote.selectStarterPet:InvokeServer('Dog')

        task.wait(2)

        replicatedstorage.Game.Pet.Remote.equipPet:InvokeServer("*all", true)            
    end
end)

for _, a in pairs(game.ReplicatedStorage:GetDescendants()) do
	if a:IsA('ModuleScript') then
		task.spawn(function()
			pcall(function()
				Modules[a.Name] = require(a)
			end)
		end)
	end
end

for _, a in pairs(Modules["Items"]) do
	print(_)
end

loop(0.1, function()
	if Settings["Grab Stars"] then
		local Zone = GrabClosestLocation()
		local Stars = {}

		for _, a in pairs(workspace.LocalStars[Zone.Name]:GetChildren()) do
			table.insert(Stars, a.Name)
		end

		replicatedstorage.Game.Remote.collectStars:FireServer(Zone.Name, Stars)
	end
	if Settings["Grab Drops"] then
		for _, a in pairs(workspace.LocalDrops:GetChildren()) do
			firetouchinterest(LocalPlayer.Character.HumanoidRootPart, a, 0)
			firetouchinterest(LocalPlayer.Character.HumanoidRootPart, a, 1)
		end
	end
end)
loop(1, function()
	if Settings["Claim Level Road"] then
		replicatedstorage.Game.Remote.ClaimRoad:InvokeServer()
	end
	if Settings["Auto Claim Chests"] then
		for _, a in pairs(workspace.ChestPOI:GetChildren()) do
			replicatedstorage.Game.Remote.ClaimChest:InvokeServer(a.Name) 
		end
	end
	if Settings["Claim Quests"] then
		for _, a in pairs(LocalPlayer.Profile.Quests:GetChildren()) do
			for _, b in pairs(a:GetChildren()) do
				replicatedstorage.Game.Remote.finishQuest:InvokeServer(a.Name, b.Name)                    
			end
		end
	end
	if Settings["Auto Craft Gold"] then
		replicatedstorage.Game.Pet.Remote.craftPet:InvokeServer("*all", nil, 1)  
	end
	if Settings["Auto Craft Rainbow"] then
		replicatedstorage.Game.Pet.Remote.craftPet:InvokeServer("*all", nil, 2)    
	end
	if Settings["Auto Use Items"] then
		for _, a in pairs(Settings["Items To Use"]) do
			replicatedstorage.Game.Remote.useItem:InvokeServer(a, "USE_1")
		end
	end
	if Settings["Auto Upgrade"] then
		for _, a in pairs(Settings["What To Upgrade"]) do
			replicatedstorage.Game.Remote.buyUpgrade:InvokeServer(a)
		end
	end
	if Settings["Auto Blend"] then
		for _, a in pairs(Settings["What To Blend"]) do
			replicatedstorage.Game.Remote.craftItem:InvokeServer("Blender", a, "BLEND")
		end
	end
end)
loop(10, function()
	if Settings["Auto Rank Up"] then
		replicatedstorage.Game.Remote.rankUp:InvokeServer()
	end
	if Settings["Equip Best"] then
		replicatedstorage.Game.Pet.Remote.equipPet:InvokeServer("*all", true)
	end
	if Settings["Auto Star Rush"] then
		replicatedstorage.Game.Remote.playStarRush:InvokeServer()
		task.wait(10)
		repeat task.wait(1) until GrabClosestLocation() ~= "STAR_RUSH"
	end
	if Settings["Auto Buy Zones"] then
		local LowestAre = math.huge

		for _, a in pairs(workspace.AreaGates:GetChildren()) do
			if a.Name:match('MAIN_(.*)') and LowestAre > tonumber(a.Name:match('MAIN_(.*)')) then
				LowestAre = tonumber(a.Name:match('MAIN_(.*)'))
			end
		end

		replicatedstorage.Game.Remote.buyArea:InvokeServer("MAIN_"..tostring(LowestAre))
	end
	if Settings["Go To Best Zone"] then
		local BestUnlocked = 0

		for _, a in pairs(LocalPlayer.Profile.AreaUnlocks:GetChildren()) do
			if a.Name:match('MAIN_(.*)') and tonumber(a.Name:match('MAIN_(.*)')) > BestUnlocked then
				BestUnlocked = tonumber(a.Name:match('MAIN_(.*)'))
			end
		end

		if not workspace.SpawnZones:FindFirstChild("MAIN_"..BestUnlocked) or  (LocalPlayer.Character.HumanoidRootPart.CFrame.Position - workspace.SpawnZones["MAIN_"..BestUnlocked].CFrame.Position).Magnitude >= 10 then
			replicatedstorage.Game.Remote.Teleport:InvokeServer("MAIN_"..BestUnlocked)  
			
			task.wait(2)

			LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.SpawnZones["MAIN_"..BestUnlocked].CFrame
		end 
	end
end)
loop(30, function()
	if Settings["Auto do Match Game"] then
		firetouchinterest(LocalPlayer.Character.HumanoidRootPart, workspace.POI.MemoryMatch.Touch, 0)
		firetouchinterest(LocalPlayer.Character.HumanoidRootPart, workspace.POI.MemoryMatch.Touch, 1)

		local R = replicatedstorage.Game.Remote.MemoryMatch.enter:InvokeServer()

		if R and LocalPlayer.PlayerGui.Frames.MemoryMatch.Visible then
			local AlreadyUsed = {}
				
			for _, a in pairs(LocalPlayer.PlayerGui.Frames.MemoryMatch.Container:GetChildren()) do
				if a:IsA('Frame') and not table.find(AlreadyUsed, a.Name) then
					replicatedstorage.Game.Remote.MemoryMatch.flip:InvokeServer(tonumber(a.Name))

					local Memory = a.Main.Back.ICON.Image

					table.insert(AlreadyUsed, a.Name)

					for _, b in pairs(LocalPlayer.PlayerGui.Frames.MemoryMatch.Container:GetChildren()) do
						if b:IsA('Frame') and b.Main.Back.ICON.Image == Memory and a~=b then
							replicatedstorage.Game.Remote.MemoryMatch.flip:InvokeServer(tonumber(b.Name))

							break
						end
					end
				end
			end
		end
	end
	if Settings["Claim Time Rewards"] then
		for i = 1, 12 do
			replicatedstorage.Game.Remote.ClaimTimeReward:InvokeServer(i)                
		end
	end
end)
