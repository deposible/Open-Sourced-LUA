getgenv().Settings = {
  ["Blow Bubbles"] = true,
  ["Sell"] = true,
  ["Rewards"] = true,
  ["Spin Wheel"] = true,
  ["Grab Drops"] = true
}

if ReExecute then
  return
end

getgenv().ReExecute = true

task.spawn(function()
  while task.wait(0.01) do
      if Settings["Blow Bubbles"] then
        game.ReplicatedStorage.RemoteEvent:FireServer('BlowBubble')
      end
  end
end)

while task.wait(1) do
  if Settings["Sell"] then
    game.ReplicatedStorage.RemoteEvent:FireServer('SellBubble', 'Sell')
  end
  if Settings["Rewards"] then
    for i = 1, 100 do
        game.ReplicatedStorage.RemoteEvent:FireServer('CollectReward', 'Overworld1', i)
        task.wait(0.1)
    end
  end
  if Settings["Spin Wheel"] then
    game.ReplicatedStorage.RemoteEvent:InvokeServer('Spin')
  end
  if Settings["Grab Drops"] then
    for _, a in pairs(workspace.PickupSpawns:GetDescendants()) do
        if a:IsA('TouchTransmitter') then
           firetouchinterest(a.Parent, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
            firetouchinterest(a.Parent, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
        end
    end
  end
end

workspace.PickupSpawns.DescendantAdded:Connect(function(a)
    if a:IsA('TouchTransmitter') and Settings["Grab Drops"] then
        firetouchinterest(a.Parent, game.Players.LocalPlayer.Character.HumanoidRootPart, 0)
        firetouchinterest(a.Parent, game.Players.LocalPlayer.Character.HumanoidRootPart, 1)
    end
end)
