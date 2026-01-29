getgenv().Settings = {
    Wins = false,
    WinsV2 = false,
    Money = false,
    GrabItems = false,

    ShowRealParts = false,
    RecolorRealParts = false,

    CrateBasic = false,
    CrateLucky = false,

    NoBreaking = false
}

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild('HumanoidRootPart')

local function touch(a, b)
    firetouchinterest(a, b, 0)
    firetouchinterest(a, b, 1)
end

task.spawn(function()
    while task.wait(2) do
        if not Settings.Wins then continue end

        for i = 1, 2 do
            HRP.CFrame = workspace.Finish.Chest.CFrame
            task.wait(0.1)

            HRP.CFrame = CFrame.new( -746.499268, -3.10197663, 722.364136, 0.999833643, -2.1163201e-08, 0.0182383228, 1.93501677e-08, 1, 9.95843834e-08, -0.0182383228, -9.92149083e-08, 0.999833643 )

            ReplicatedStorage.Remotes.ClaimReward:FireServer()
        end
    end
end)
RunService.Heartbeat:Connect(function()
    if not Settings.WinsV2 then return end

    apcall(function()
        touch(HRP, workspace.Finish.Chest)
        ReplicatedStorage.Remotes.ClaimReward:FireServer()
    end)
end)
task.spawn(function()
    while task.wait(0.1) do
        if not Settings.Money then continue end

        apcall(function()
            for _, a in pairs(workspace.Obbies:GetChildren()) do
                if a:FindFirstChild('EndPortal') then
                    touch(HRP, a.EndPortal)
                    task.wait(0.05)
                end
            end
        end)

        for i = 1, 2 do
            touch(HRP, workspace.Finish.Chest)
        end
    end
end)
task.spawn(function()
    while task.wait(0.1) do
        if not Settings.GrabItems then continue end
        ReplicatedStorage.RemoteEvents.blockRemote:FireServer('processClaim')
    end
end)
task.spawn(function()
    while task.wait(0.25) do
        if Settings.CrateBasic then
            ReplicatedStorage.RemoteEvents.crateRemote:FireServer('processCrate', 1)
            ReplicatedStorage.RemoteEvents.crateRemote:FireServer('processReward', 1)
        end

        if Settings.CrateLucky then
            ReplicatedStorage.RemoteEvents.crateRemote:FireServer('processCrate', 2)
            ReplicatedStorage.RemoteEvents.crateRemote:FireServer('processReward', 2)
        end
    end
end)
task.spawn(function()
    while task.wait(1) do
        for _, part in pairs(workspace.segmentSystem.Segments:GetDescendants()) do
            if part.Name == 'breakable' and part.Parent and part.Parent.Name == 'Part' and Settings.ShowRealParts then
                part.Parent.Transparency = 1
            end

            if Settings.RecolorRealParts and part.Name == 'Part' then
                if part:FindFirstChild('breakable') then
                    part.Color = Color3.fromRGB(255, 0, 0)
                else
                    part.Color = Color3.fromRGB(0, 255, 0)
                end
            end
        end
    end
end)
task.spawn(function()
    local applied
    while task.wait(1) do
        if Settings.NoBreaking and not applied then
            applied = true

            for _, part in pairs(workspace.segmentSystem.Segments:GetDescendants()) do
                if part.Name == 'Part' and part:FindFirstChild('breakable') then
                    part.CanCollide = true
            
                    for _, c in pairs(part:GetChildren()) do
                        c:Destroy()
                    end
                end
            end
        end

        if not Settings.NoBreaking then
            applied = false
        end
    end
end)
