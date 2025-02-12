local Players = game.Players
local ReplicatedStorage = game.ReplicatedStorage

getgenv().deposibleontop = {
  GrabStars = false,
  Rebirth = false,
  BuyHalo = false
}

newtask = function(delay, val, callback)
  task.spawn(function()
    while task.wait(delay) and deposibleontop[val] do
      callback()
    end
  end)
end

newtask(0.01, "GrabStars", function()
  pcall(function()
      firetouchinterest(Workspace.Stage["1000"].CheckPoint, Players.LocalPlayer.Character.HumanoidRootPart, 0)
      firetouchinterest(Workspace.Stage["1000"].CheckPoint, Players.LocalPlayer.Character.HumanoidRootPart, 1)

      ReplicatedStorage.Restart:FireServer()
  end)
end)
newtask(0.25, "Rebirth", function()
  ReplicatedStorage.Rebirth:FireServer()
end)
newtask(0.25, "BuyHalo", function()
  ReplicatedStorage.BuyHalo:FireServer(Players.LocalPlayer.stats.Halos + 1, 0)
end)
