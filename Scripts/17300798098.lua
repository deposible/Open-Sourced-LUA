local Players = game.Players
local ReplicatedStorage = game.ReplicatedStorage

getgenv().deposibleontop = {
  ["Spin Obbys"] = false,
  ["Spin Wheel"] = false,
  ["Flood Global Chat"] = false,
  ["Alot Of Credits"] = false,
  ["Alot Of Spins"] = false
} -- I recoded this entire thing so you can steal it! even tho the game got removed here is the old source so you can learn. (Not Straight source but just a watered down version so its easy to comprehend

local newtask = function(delay, val, callback) 
  task.spawn(function()
    while task.wait(delay) and deposibleontop[val] do
      callback()
    end
  end)
end

newtask(0.1, "Spin Obbys", function()
  for i, a in pairs(Workspace.WinParts:GetChildren()) do
        if not a:IsA('Script') then
            firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, a, 0)
            firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, a, 1)

            task.wait(0.5)
        end
    end
end)
newtask(0.1, "Spin Wheel", function()
  ReplicatedStorage.Events.Spin:FireServer('spin')
end)
newtask(0.1, "Flood Global Chat", function()
  ReplicatedStorage.Events.PlayTimeGifts:FireServer("Credits", 25000000)
  ReplicatedStorage.Events.Withdraw:FireServer('10000')
end)
newtask(0.1, "Alot Of Credits", function()
  ReplicatedStorage.Events.PlayTimeGifts:FireServer("Credits", 1000000)
end)
newtask(0.1, "Alot Of Spins", function()
  ReplicatedStorage.Events.PlayTimeGifts:FireServer("Spins", 1000000)
end)
