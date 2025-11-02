--[[
	Fish List

	ONLY use the second string in the options bellow yw

	local Fish = {{"Baby Tropical Fish", "Baby Tropical Fish"}, {"Baby Bluegill", "Baby Bluegill"}, {"Baby Perch", "Baby Perch"}, {"Baby Arowana", "Baby Arowana"}, {"Baby Salmon", "Baby Salmon"}, {"Baby Piranha", "Baby Piranha"}, {"Baby Pike", "Baby Pike"}, {"Baby Pufferfish", "Baby Pufferfish"}, {"Baby Clownfish", "Baby Clownfish"}, {"Baby Bass", "Baby Bass"}, {"Baby Frostfin", "Baby Frostfin"}, {"Baby Koi", "Baby Koi"}, {"Baby Axolotl", "Baby Axolotl"}, {"Baby Seahorse", "Baby Seahorse"}, {"Baby Blobfish", "Baby Blobfish"}, {"Baby Mako Shark", "Baby Mako Shark"}}
]]
getgenv().Settings = {
	["Grab Fish"] = true,
	["Auto Sell"] = true,
	["Place Fish Anywhere"] = true,
	["Buy Fish"] = false,
	["Fish To Buy"] = {},
	["Auto Place Fish"] = false,
	["Fish To Place"] = {}
}

if ReExecute then return else getgenv().ReExecute = true end

local LocalPlayer = game.Players.LocalPlayer
local replicatedstorage = game.ReplicatedStorage

local loop = function(del, func)
	task.spawn(function()
		while task.wait(del) do
			pcall(func)
		end
	end)
end
local GrabPlot = function()
	for _, a in pairs(workspace.Plots:GetChildren()) do
		if a.Sign.UI.SurfaceGui.PlayerPlot.Text:match(LocalPlayer.Name) then
			return a
		end
	end
end

loop(1, function()
	if Settings["Grab Fish"] then
		for _, a in pairs(GrabPlot().Scripted.Fishes:GetChildren()) do
			pcall(function()
				if a:FindFirstChildWhichIsA("ProximityPrompt").ObjectText ~= "Rod" then
					LocalPlayer.Character.HumanoidRootPart.CFrame = a:GetPivot() * CFrame.new(0, 3, 0)
					task.wait(0.2)
					fireproximityprompt(a:FindFirstChildWhichIsA('ProximityPrompt'))
					task.wait(0.1)
				end
			end)
		end
	end
	if Settings["Auto Sell"] then
		replicatedstorage.Shared.RBXUtil.Net["RE/Sell Fish"]:FireServer("ALL")
	end
	if Settings["Place Fish Anywhere"] then
		GrabPlot().Scripted.WaterRegion.Water.Size = Vector3.new(1000, 10, 1000)
	else
		GrabPlot().Scripted.WaterRegion.Water.Size = Vector3.new(52.827999114990234, 11.862299919128418, 67.4198989868164)
	end
	if Settings["Buy Fish"] then
		 for _, a in pairs(LocalPlayer.PlayerGui.ScreenGui.Frames["Fish Store"].Main.Scroll:GetChildren()) do
			for _, b in pairs(Settings["Fish To Buy"]) do
				if b == a.Name and a.Stock.Text ~= "x0 stock" then
					for i = 1, tonumber(a.Stock.Text:match("x(.*) stock")) do
						replicatedstorage.Shared.RBXUtil.Net["RE/BuyItem"]:FireServer('Fish', b)
					end
				end
			end
		end
	end
	if Settings["Auto Place Fish"] then
		for _, a in pairs(Settings["Fish To Place"]) do
			for _, b in pairs(LocalPlayer.PlayerGui.ScreenGui.HUD.Hotbar.Hotbar:GetChildren()) do
				if Attribute(b, 'Item') and b.Item.Text:match(a) then
					replicatedstorage.Shared.RBXUtil.Net["RE/EquipItem"]:FireServer(Attribute(b, 'Item'))                       

					for i = 1, tonumber(b.Item.Text:match('x(.*)%]')) do
						replicatedstorage.Shared.RBXUtil.Net["URE/Drop Fish"]:FireServer()
						task.wait(0.4)
					end
				end
			end
			for _, c in pairs(LocalPlayer.PlayerGui.ScreenGui.HUD.Inventory.Scroll:GetChildren()) do
				if c.Name ~= "Template" and c:IsA('Frame') and c.Template.Item.Text:match(a) then
					replicatedstorage.Shared.RBXUtil.Net["RE/EquipItem"]:FireServer(Attribute(c.Template, "Item"))

					for i = 1, tonumber(c.Template.Item.Text:match('x(.*)%]')) do
						replicatedstorage.Shared.RBXUtil.Net["URE/Drop Fish"]:FireServer()
						task.wait(0.4)
					end
				end
			end

			task.wait(0.5)
		end
	end
end)
