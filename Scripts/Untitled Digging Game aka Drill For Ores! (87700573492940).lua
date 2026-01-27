getgenv().Settings = {
    AutoDrill = false,
    AutoSell = false,
    AutoCollectStorage = false,
    AutoCollectDrills = false,
    AutoRebirth = false
}

if AlreadyHas then return end
getgenv().AlreadyHas = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local replicatedstorage = game:GetService("ReplicatedStorage")

local FireNetwork = function(network, data)
    replicatedstorage.Packages.Knit.Services.OreService.RE[network]:FireServer(unpack(data))
end

local GrabPlot = function()
    for _, a in pairs(workspace.Plots:GetChildren()) do
        if a:FindFirstChild("Owner") and tostring(a.Owner.Value) == LocalPlayer.Name then
            return a
        end
    end
end

task.spawn(function()
    local hb
    while task.wait() do
        if Settings.AutoDrill and not hb then
            hb = RunService.Heartbeat:Connect(function()
                pcall(function()
                    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
                    if not tool or not tool.Name:match("Hand Drill") then
                        for _, a in pairs(LocalPlayer.Backpack:GetChildren()) do
                            if a.Name:match("Hand Drill") then
                                EquipTool(a)
                                break
                            end
                        end
                    end
                end)
                pcall(function()
                    FireNetwork("RequestRandomOre", {})
                end)
            end)
        elseif not Settings.AutoDrill and hb then
            hb:Disconnect()
            hb = nil
        end
    end
end)

task.spawn(function()
    while task.wait(60) do
        if Settings.AutoSell then
            local old = LocalPlayer.Character.HumanoidRootPart.CFrame
            LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Sell Shop"].WorldPivot
            task.wait(0.25)
            FireNetwork("SellAll", {})
            task.wait(0.25)
            LocalPlayer.Character.HumanoidRootPart.CFrame = old
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoCollectStorage then
            local plot = GrabPlot()
            if plot then
                for _, a in pairs(plot.Drills:GetChildren()) do
                    replicatedstorage.Packages.Knit.Services.PlotService.RE.CollectDrill:FireServer(a)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoCollectDrills then
            local plot = GrabPlot()
            if plot then
                for _, a in pairs(plot.Storage:GetChildren()) do
                    replicatedstorage.Packages.Knit.Services.PlotService.RE.CollectDrill:FireServer(a)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(5) do
        if Settings.AutoRebirth then
            FireNetwork("RebirthRequest", {})
        end
    end
end)
