local Players = game.Players
local ReplicatedStorage = game.ReplicatedStorage

getgenv().deposibleontop = {
  AutoFart = false,
  InstantWin = false,
  AutoRebirth = false,
  ClaimGifts = false
}

newtask = function(delay, val, callback)
  task.spawn(function()
    while task.wait(delay) and deposibleontop[val] do
      callback()
    end
  end)
end

newtask(0, "AutoFart", function()
  ReplicatedStorage.Events.Click:FireServer()
end)
newtask(0.1, "InstantWin", function()
  ReplicatedStorage.Events.Fight:FireServer(true)
end)
newtask(1, "AutoRebirth", function()
  ReplicatedStorage.Events.Rebirth:FireServer()
end)
newtask(1, "ClaimGifts", function()
  for i = 1, 12 do
    ReplicatedStorage.Events.FreeGift:FireServer("Gift1", tostring(i))
  end
end)
