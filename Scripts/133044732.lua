local Players = game.Players
local ReplicatedStorage = game.ReplicatedStorage

getgenv().deposibleontop = {
  AutoShit = false,
  AutoFart = false
}

newtask = function(delay, val, callback)
  task.spawn(function()
    while task.wait(delay) and deposibleontop[val] do
      callback()
    end
  end)
end

newtask(0, "AutoShit", function()
  workspace:WaitForChild("RemoteEvent"):FireServer("poop")
end)
newtask(0, "AutoFart", function()
  workspace:WaitForChild("RemoteEvent"):FireServer("fart")
end)
