--[[ Added The ESP Down Bellow but you gotta code your own functions i aint sharing my custom. ]]

getgenv().Settings = {
  ["Auto Grab Coins"] = true,
  ["Auto Queue"] = true,
  ["Fake Death"] = true
}

if ReExecute then return else getgenv().ReExecute = true end

local Modules = {}
local Roles = {}
local RoleColors = {}

local players = game.Players
local LocalPlayer = game.Players.LocalPlayer
local replicatedstorage = game.ReplicatedStorage

local loop = function(del, func)
    task.spawn(function()
        while task.wait(del) do
          pcall(func)
        end
    end)
end

for _, a in pairs(game.ReplicatedStorage:GetChildren()) do
  if a.Name == "RoleDictionary" then
    Modules[a.Name] = require(a)
  end
end
for i, a in pairs(Modules.RoleDictionary.getDictionary()) do
    RoleColors[i] = {a.Visual.RoleColor.R * 255, a.Visual.RoleColor.G * 255, a.Visual.RoleColor.B * 255}
    table.insert(Roles, {i, i})
end

loop(1, function()
	if Settings["Auto Grab Coins"] then
		 if workspace:FindFirstChild('Coins') then
			for _, a in pairs(workspace.Coins:GetChildren()) do
				firetouchinterest(LocalPlayer.Character.HumanoidRootPart, a, 0)
				firetouchinterest(LocalPlayer.Character.HumanoidRootPart, a, 1)
			end
		end
	end
	if Settings["Auto Queue"] then
		if replicatedstorage.Remotes:FindFirstChild("Queue") then
			replicatedstorage.Remotes.Queue:FireServer("Classic")          
		end  
	end
		
	LocalPlayer.Character.RagdollTrigger.Value = Settings["Fake Death"]
end)

--[[
	ESP SECTION

	loop(1, function()
		for data, role in pairs(getrenv()._G.PlayersRoles) do
			for _, a in pairs(players:GetPlayers()) do
				if a.Character and LocalPlayer ~= a and a.UserId == data then
					esp(role, a.Character, RoleColors[role], NamesTextLabel and 1 or Highlight and 2, ON)
				end
			end
		end
	end)
]]
