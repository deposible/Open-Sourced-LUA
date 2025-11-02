--[[
 Seeds List!
	local Seeds = {{"Coal", "Coal"}, {"Tin", "Tin"}, {"Copper", "Copper"}, {"Iron", "Iron"}, {"Silver", "Silver"}, {"Gold", "Gold"}, {"Platinum", "Platinum"}, {"Ruby", "Ruby"}, {"Amethyst", "Amethyst"}, {"Emerald", "Emerald"}, {"Topaz", "Topaz"}, {"Sapphire", "Sapphire"}, {"Diamond", "Diamond"}, {"Obsidian", "Obsidian"}}
]]
getgenv().Settings = {
	["Auto Grab Drops"] = true,
  	["Auto Mine"] = true,
	["Auto Sell"] = true,
	["Auto Buy Ores"] = false,
	["Ores To Buy"] = {}, -- Place seeds inside of here view uptop for codes. Only insert Second String Option
	["Auto Place Ores"] = false,
	["Ores To Place"] = {} -- Place seeds inside of here view uptop for codes. Only insert Second String Option
	["2x Walkspeed Gamepass"] = true,
}

if ReExecute then
  return
end

getgenv().ReExecute = true

local LocalPlayer = game.Players.LocalPlayer
local replicatedstorage = game.ReplicatedStorage

local GrabPlot = function()
    for _, a in pairs(workspace.Plots:GetChildren()) do
        if Attribute(a, "OwnerUserId") == LocalPlayer.UserId then
            return a
        end
    end
end
local loop = function(del, func)
  task.spawn(function()
    while task.wait(del) do
      pcall(func)
    end
  end)
end
local Attribute = function(Part, Attribute)
    local success, atr = pcall(function()
        return Part:GetAttribute(Attribute)
    end)

    return success and atr or false
end


loop(0.5, function()
    if Settings["Auto Grab Drops"] then
		local Plot = GrabPlot()

		for _, a in pairs(Plot.OreDrops:GetChildren()) do
			a.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
		end
    end
	if Settings["Auto Sell"] then
		replicatedstorage.Remotes.SellAllOresEvent:InvokeServer()
	end
	if Settings["2x Walkspeed Gamepass"] then
		LocalPlayer.Character.Humanoid.WalkSpeed = 50
	end
end)
loop(1, function()
	local Plot = GrabPlot()

	if Settings["Auto Mine"] then
		for i, a in pairs(Plot.CurrentRockOres:GetChildren()) do
			if not Attribute(a, "Pct") or a:FindFirstChild('ReadyToMineGui') then
				repeat
					if not LocalPlayer.Character:FindFirstChildWhichIsA('Tool') or not LocalPlayer.Character:FindFirstChildWhichIsA('Tool').Name:match('Pickaxe') then
						for _, b in pairs(LocalPlayer.Backpack:GetChildren()) do
							if b.Name:match('Pickaxe') then
								b.Parent = LocalPlayer.Character

								break
							end
						end
					end

					task.wait(0.05)

					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(a.PrimaryPart.Position.X, 4.5, a.PrimaryPart.Position.Z + 4))

					task.wait(0.05)

					replicatedstorage.Remotes.PickaxeSwingEvent:FireServer()
				until not a or not Settings["Auto Mine"]
			end
		end
	end   
	if Settings["Auto Buy Ores"] then
		for _, a in pairs(Settings["Ores To Buy"]) do
			for _, b in pairs(LocalPlayer.PlayerGui.MainGui.SeedOreShop.StockHolderFrame:GetChildren()) do
				pcall(function()
					if b.Name:match(a) and b.ItemInfoFrame.OreStockLabel.Text:match("×(.*) Stock") ~= "0" then
						for i = 1, tonumber(b.ItemInfoFrame.OreStockLabel.Text:match("×(.*) Stock")) do
							replicatedstorage.Remotes.BuySeedRequest:InvokeServer(a)
						end
					end
				end)
			end
		end
	end
	if Settings["Auto Place Ores"] then
		for _, a in pairs(Settings["Ores To Place"]) do
			for _, b in pairs(LocalPlayer.Backpack:GetChildren()) do
				if b.Name:match(a) and b.Name:match("Seed") then
					b.Parent = LocalPlayer.Character

					task.wait(0.5)

					for i = 1, tonumber(Attribute(b, 'StackCount')) do
						replicatedstorage.Remotes.PlaceOreRequestEvent:FireServer(
							Plot.Land.Position,
							a,
							LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
						)

						task.wait(0.15)
					end
				end
			end
		end
	end
end)
loop(2, function()
	local Plot = GrabPlot()

	for i, a in pairs(Plot:GetDescendants()) do
		if a:IsA('Part') then
			a.CanCollide = false
		end
	end
end)
