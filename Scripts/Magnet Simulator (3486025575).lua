getgenv().Settings = {
    AutoCollectCash = true,
    AutoSell = true,
    GrabClovers = true,
    AutoGrab = true,
    AutoRebirth = true,
    RebirthAmount = 1000
}

if ReExecute then
  return
else
  getgenv().ReExecute = true
end

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local rs = game:GetService("ReplicatedStorage")
local wrk = workspace

local function CollectCash()
    for _, a in pairs(wrk.Cubes:GetChildren()) do
        firetouchinterest(char.HumanoidRootPart, a, 0)
        firetouchinterest(char.HumanoidRootPart, a, 1)
    end
end

local function AutoSell()
    local sell = wrk.Rings:FindFirstChild("Sellx2")
    if sell then
        firetouchinterest(char.HumanoidRootPart, sell, 0)
        firetouchinterest(char.HumanoidRootPart, sell, 1)
    end
end

local function GrabClovers()
    for _, a in pairs(wrk.PumpkinSpawns.Pumpkins:GetChildren()) do
        firetouchinterest(char.HumanoidRootPart, a, 0)
        firetouchinterest(char.HumanoidRootPart, a, 1)
    end
end

local function AutoGrab()
    if not char:FindFirstChildWhichIsA("Tool") then
        local tool = plr.Backpack:FindFirstChildWhichIsA("Tool")
        if tool then
            tool.Parent = char
        end
    end
    rs.Events.MagnetEvents.requestGrab:FireServer("3", char:FindFirstChildWhichIsA("Tool"))
end

local function AutoRebirth()
    rs.RebirthsEvents.requestRebirth:InvokeServer(getgenv().Settings.RebirthAmount)
end

task.spawn(function()
    while task.wait(0.25) do
        pcall(function()
            if getgenv().Settings.AutoCollectCash then
                CollectCash()
            end
            if getgenv().Settings.AutoSell then
                AutoSell()
            end
            if getgenv().Settings.GrabClovers then
                GrabClovers()
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(0.02) do
        pcall(function()
            if getgenv().Settings.AutoGrab then
                AutoGrab()
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if getgenv().Settings.AutoRebirth then
                AutoRebirth()
            end
        end)
    end
end)
