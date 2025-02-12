
local Players = game.Players
local ReplicatedStorage = game.ReplicatedStorage

getgenv().deposibleontop = {
  InfXP = false,
  InfWins = false,
  InfGems = false,
  InfPower = false,
  InfWins2 = false
}

newtask = function(delay, val, callback)
  task.spawn(function()
    while task.wait(delay) and deposibleontop[val] do
      callback()
    end
  end)
end
repetitive = function(times, func)
  for i = 1, times do
    func()
    task.wait()
  end
end)


newtask(0.1, "InfXp", function()
    repetitive(100, function()
      ReplicatedStorage.RemotesMain.UpdExp:FireServer(34354, "p33")
    end)
end)
newtask(0.1, "InfWins", function()
    repetitive(100, function()
      ReplicatedStorage.RemotesMain.GiveDailyReward:FireServer("Medium Wins Pack", 1)
    end)
end)
newtask(0.1, "InfGems", function()
    repetitive(100, function()
      ReplicatedStorage.RemotesMain.UpdateGemStat:FireServer(1687.2, "p16")
    end)
end)
newtask(0.1, "InfPower", function()
    repetitive(100, function()
      ReplicatedStorage.RemotesMain.ClaimFreeGift:FireServer("Power 4", 1028, 0)
    end)
end)
newtask(0.1, "InfWins2", function()
    repetitive(100, function()
       ReplicatedStorage.RemotesMain.ClaimFreeGift:FireServer("Wins 3", 255, 0)
    end)
end)
