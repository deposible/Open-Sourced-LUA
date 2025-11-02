getgenv().Settings = {
  ["Farm Cash"] = true,
  ["RGB Skin"] = true,
  ["RGB Speed"] = 0 -- 0 == Fastest (Only do 0 -> 1 [ETC. 0.193])
}
local loop = function(del, func)
    task.spawn(function()
        while task.wait(del) do
          pcall(func)
        end
    end)
end

local replicatedstorage = game.ReplicatedStorage
local LocalPlayer = game.Players.LocalPlayer

loop(0, function()
  replicatedstorage["Dress Up"].RemoteEvent:FireServer("Change Skintone", Color3.new(math.random(), math.random(), math.random()))
  task.wait(Settings["RGB Speed"])
end)
loop(0.1, function()
    for _, a in pairs(workspace.CollectibleMoney:GetChildren()) do
        for _, b in pairs(a:GetChildren()) do
            if b:FindFirstChild('DecalFront').Transparency ~= 1 then
                LocalPlayer.Character.HumanoidRootPart.CFrame = b.CFrame

                firetouchinterest(b, LocalPlayer.Character.HumanoidRootPart, 0)
                firetouchinterest(b, LocalPlayer.Character.HumanoidRootPart, 1)
                task.wait()
            end
        end
    end
end)
