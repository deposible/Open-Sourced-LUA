getgenv().DeposibleOnTop = {
    ["Obtain All Trails"] = false,
    ["Auto Sit"] = false,
    ["Infinite Points"] = false,
    ["Infinite Points v2"] = false,
    ["Points Increase"] = 10000
}

local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end

if DeposibleOnTop["Obtain All Trails"] then
    game:GetService('ReplicatedStorage').GiveAllTrails:FireServer()
end

newtask(0.10, 'Auto Sit', function()
    pcall(function()
        for _, chair in pairs(Workspace:WaitForChild("Chairs"):GetChildren()) do
            if chair:IsA("Model") and chair:FindFirstChild("Seat") and chair.Seat.Occupant == nil then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chair:GetPrimaryPartCFrame() * CFrame.new(0, 3, 0)

                task.wait(2)

                break
            end
        end
    end)
end)

game:GetService('RunService').Heartbeat:Connect(function()
    if DeposibleOnTop["Infinite Points"] then
        Workspace.EasyObby.Folder.CompleteObbyPart.RemoteEvent:FireServer()
    end
    if DeposibleOnTop["Infinite Points v2"] then
        game:GetService('ReplicatedStorage').EggHatchingRemotes.HatchServer:InvokeServer("Mythic Egg", -DeposibleOnTop["Points Increase"])
    end
end)
