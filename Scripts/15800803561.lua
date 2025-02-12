getgenv().DeposibleOnTop = {
    ["Spawn Chicken"] = false,
    ["Grab Eggs"] = false,
    ["Drop Eggs Off"] = false,
    ["Kill Rats"] = false,
    ["Self Mine"] = false,
    ["Auto Complete Obbys"] = false,
    ["Upgrades"] = false,
    ["Buy Workers"] = false,
    ["Buy Housing"] = false,
    ["Buy Vehicles"] = false,
    ["Claim Gifts"] = false,
    ["Claim Quests"] = false,
    ["Claim Rewards"] = false
}
local Players = game.Players

local NextUG = {
    ["Noob"] = "Zombie",
    ["Zombie"] = "Peasant", 
    ["Peasant"] = "Pirate",
    ["Pirate"] = "Lumberjack", 
    ["Lumberjack"] = "Farmer",
    ["Farmer"] = "Builderman", 
    ["Builderman"] = "Agent",
    ["Agent"] = "Cowboy", 
    ["Cowboy"] = "Drew",
    ["Drew"] = "Robot", 
    ["Robot"] = "Astronaut",
    ["Astronaut"] = "Alien",
    ["Alient"] = "Buff Noob",
    ["Buff Noob"] = "David",

    ["Shack"] = "Super Shack",
    ["Super Shack"] = "Long House",
    ["Long House"] = "Barn",
    ["Barn"] = "The Standard",
    ["The Standard"] = "Deluxe Barn",
    ["Deluxe Barn"] = "Military Base",
    ["Military Base"] = "Happy Home",
    ["Happy Home"] = "Power Plant",
    ["Power Plant"] = "RFC",
    ["RFC"] = "Castle",
    ["Castle"] = "Skyscraper",
    ["Skyscraper"] = "Monolith",
    ["Monolith"] = "The Tower",
    ["The Tower"] = "Chicken Universe",
    ["Chicken Universe"] = "Chicken Teleporter",
    ["Chicken Teleporter"] = "World Portal",

    ["Pickup Truck"] = "Trike", 
    ["Trike"] = "Transit Van",
    ["Transit Van"] = "Box Truck", 
    ["Box Truck"] = "Heavy Truck", 
    ["Heavy Truck"] = "Semi Truck", 
    ["Semi Truck"] = "Double Semi", 
    ["Double Semi"] = "Future Semi", 
    ["Future Semi"] = "Mega Semi", 
    ["Mega Semi"] = "Quantum Semi"
}

local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end

newtask(0.5, "Kill Rats", function()
    for _, rat in pairs(Workspace.playerPlots[Players.LocalPlayer.Name].foxes:GetChildren()) do
        if rat.Name == "Fox" then
            fireclickdetector(rat.pet:FindFirstChild('ClickDetector'))

            task.wait(0.10)
        end
    end
end)
newtask(0.05, "Auto Complete Obbys", function()
    game:GetService('ReplicatedStorage').functions.remotes.obbyCompleted:InvokeServer('easy')
    game:GetService('ReplicatedStorage').functions.remotes.obbyCompleted:InvokeServer('hard')
end)
newtask(2, "Upgrades", function()
    for a = 1, 8 do
        for b = 1, 4 do
            game:GetService('ReplicatedStorage').events.remotes.buyUpgrade:FireServer(tostring(a), tostring(b))
            task.wait()
        end

        task.wait()
    end
end)
newtask(1, "Buy Workers", function()
    pcall(function()
        for i = 1, 4 do
            if Players.LocalPlayer.workers[i].Value == "" then
                game:GetService('ReplicatedStorage').events.remotes.buyWorker:FireServer("Noob", tostring(i))
            else
                game:GetService('ReplicatedStorage').events.remotes.buyWorker:FireServer(NextUG[Players.LocalPlayer.workers[i].Value], tostring(i))
            end
        end
    end)
end)
newtask(1, "Buy Housing", function()
    pcall(function()
        for i = 1, 4 do
            if Players.LocalPlayer.housing[i].houseName.Value == "" then
                game:GetService('ReplicatedStorage').events.remotes.buyHouse:FireServer("Shack", tostring(i))
            else
                game:GetService('ReplicatedStorage').events.remotes.buyHouse:FireServer(NextUG[Players.LocalPlayer.housing[i].houseName.Value], tostring(i))
            end
        end
    end)
end)
newtask(1, "Buy Vehicles", function()
    pcall(function()
        for i = 1, 12 do
            if Players.LocalPlayer.vehicles[i].Value == "" then
                game:GetService('ReplicatedStorage').events.remotes.buyVehicle:FireServer("Pickup Truck", tostring(i))
            else
                game:GetService('ReplicatedStorage').events.remotes.buyVehicle:FireServer(NextUG[Players.LocalPlayer.vehicles[i].Value], tostring(i))
            end
        end
    end)
end)
newtask(1, "Claim Gifts", function()
    for i = 1, 12 do
        game:GetService('ReplicatedStorage').events.remotes.giftClaimed:FireServer(tostring(i))
    end
end)
newtask(1, "Claim Quests", function()
    for i = 1, 3 do
        game:GetService('ReplicatedStorage').events.remotes.claimQuest:FireServer(tostring(i))
    end
end)
newtask(1, "Claim Rewards", function()
    for _, reward in pairs({ "cash1", "cash2", "earnings3" }) do
        game:GetService('ReplicatedStorage').events.remotes.claimRandomReward:FireServer(reward)
    end
end)


task.spawn(function()
    while task.wait(0.05) do
        if DeposibleOnTop["Grab Eggs"] then
            firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, Workspace.playerPlots[Players.LocalPlayer.Name].touchPads.collectEggs, 0 )
            firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, Workspace.playerPlots[Players.LocalPlayer.Name].touchPads.collectEggs, 1 )
        end
        task.wait(4.25)
        if DeposibleOnTop["Drop Eggs Off"] then
            firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, Workspace.playerPlots[Players.LocalPlayer.Name].touchPads.depositEggs, 0 )
            firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, Workspace.playerPlots[Players.LocalPlayer.Name].touchPads.depositEggs, 1 )
        end
        task.wait(4.25)
    end
end)

game:GetService('RunService').Heartbeat:Connect(function()
    if DeposibleOntop["Spawn Chicken"] then
        game:GetService('ReplicatedStorage').events.remotes.addChickens:FireServer(1, 0)
    end
    if DeposibleOntop["Self Mine"] then
        game:GetService('ReplicatedStorage').events.remotes.chickenSpawned:FireServer(Players.LocalPlayer)
    end
end)
