getgenv().Settings = {
    Delay = 0.25,
    InstaWin = false,
    FarmWins = false,
    KillAllPlayers = false,
    KillPlayer = false,
    TargetPlayerName = ""
}

if Settings then return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    while task.wait(1) do
        if Settings.InstaWin then
            WIRE.firetouchinterest(LocalPlayer.Character.HumanoidRootPart, workspace.World.FinalCheckpoint)
            Settings.InstaWin = false
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.FarmWins then
            WIRE.firetouchinterest(LocalPlayer.Character.HumanoidRootPart, workspace.World.FinalCheckpoint)
            task.wait(0.25)
            LocalPlayer.Character:BreakJoints()
            LocalPlayer.CharacterAdded:Wait()
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.KillAllPlayers then
            for _, a in pairs(Players:GetPlayers()) do
                if a ~= LocalPlayer then
                    game.ReplicatedStorage.GiveBomb:FireServer(a)
                    task.wait(0.25)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.KillPlayer then
            local target = Players:FindFirstChild(Settings.TargetPlayerName)
            if target and target ~= LocalPlayer then
                game.ReplicatedStorage.GiveBomb:FireServer(target)
                task.wait(0.25)
            end
        end
    end
end)
