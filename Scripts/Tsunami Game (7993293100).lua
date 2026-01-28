getgenv().Settings = getgenv().Settings or {
    AutoGrabCoins = false,

    AutoWin = false,
    SilentAutoWin = false,

    AntiTsunamis = false,
    AutoTsunamiSpawner = false,

    TeleportBobsRoom = false,
    TeleportBobsCarts = false,
    TeleportAlienArea = false,
    TeleportFreeCrowbar = false,
    TeleportParkingLot = false,
    TeleportBackRooms = false
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if Settings.TeleportBobsRoom then
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(156.955154,121.698021,-544.274353,0.996804357,0,0.0798815936,0,1,0,-0.0798815936,0,0.996804357)
end
if Settings.TeleportBobsCarts then
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1175.66101,200.590164,-1077.63782,-0.424850792,0,-0.905263364,0,1,0,0.905263364,0,-0.424850792)
end
if Settings.TeleportAlienArea then
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1203.37244,229.998001,-1105.63342,0.875975728,0,0.482355177,0,1,0,-0.482355177,0,0.875975728)
end
if Settings.TeleportFreeCrowbar then
    LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.ActiveGearDebris.CrowbarSpawn.CFrame
end
if Settings.TeleportParkingLot then
    LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.ScriptImportance.ResearcherTeleports.TeleportParkinglot.CFrame
end
if Settings.TeleportBackRooms then
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-35.6268082,121.998024,1058.25598,-0.0459560715,0,0.998943448,0,1,0,-0.998943448,0,-0.0459560715)
end

if getgenv().AlreadyHas then
    return
end
getgenv().AlreadyHas = true

task.spawn(function()
    while task.wait(0.25) do
        if Settings.AutoGrabCoins then
            for _, a in pairs(workspace.CurrentPointCoins:GetChildren()) do
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local hum = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")

                WIRE.Tween(
                    (hrp.Position - a.CoinCollision.Position).Magnitude / hum.WalkSpeed,
                    a.CoinCollision.Position
                )
                break
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if Settings.AutoWin then
            Settings.SilentAutoWin = false
            WIRE.Tween(45, Vector3.new(-9.30471611,120.39801,-965.790466))
            WIRE.Tween(6, Vector3.new(-10.5651646,39.9954338,-1051.88477))
        end

        if Settings.SilentAutoWin then
            Settings.AutoWin = false
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 30, hrp.Position.Z)

            WIRE.Tween(45, Vector3.new(-9.30471611,110.39801,-965.790466))
            WIRE.Tween(6, Vector3.new(-10.5651646,39.9954338,-1051.88477))
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if Settings.AntiTsunamis then
            for _, a in pairs(workspace.ActiveTsunamis:GetChildren()) do
                a:Destroy()
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoTsunamiSpawner then
            WIRE.firetouchinterest(
                LocalPlayer.Character.HumanoidRootPart,
                workspace.ScriptImportance.ButtonModel.Button
            )
        end
    end
end)
