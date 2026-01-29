getgenv().Settings = {
    -- FARM
    RobAllTycoons = false,
    GrabRareThings = false,
    GrabHiddenThings = false,
    AutoClaimCash = false,
    AutoBuyButtons = false,
    AutoConfirmPurchases = false,
    KillAllBots = false,
    KillAllPlayers = false,

    -- ROB
    Museum = false,
    JewelryStore = false,
    Beach = false,
    AppleStore = false,
    CoffeeShop = false,
    CrystalFactory = false,
    CreepyShop = false,
    Mansion = false,

    Delay = 0.5
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function fireTouch(p1, p2)
    if p1 and p2 then
        firetouchinterest(p1, p2, 0)
        task.wait()
        firetouchinterest(p1, p2, 1)
    end
end
local function getTool()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Tool")
end
local function getTycoon()
    for _, a in pairs(workspace:GetChildren()) do
        if a:IsA("Folder") and a:FindFirstChild("OwnerName") and tostring(a.OwnerName.Value) == LocalPlayer.Name then
            return a
        end
    end
end

local function claimCash()
    local tycoon = getTycoon()
    if tycoon and tycoon:FindFirstChild("RobberySucces") then
        fireTouch(tycoon.RobberySucces.Shop, LocalPlayer.Character.HumanoidRootPart)
    end
end
local function grabAppleCash(a)
    if a:FindFirstChildWhichIsA("TouchInterest") then
        fireTouch(a, LocalPlayer.Character.HumanoidRootPart)
    end
    if a:FindFirstChild("Screen") then
        fireTouch(a.Screen, LocalPlayer.Character.HumanoidRootPart)
    end
end

task.spawn(function()
    while task.wait(Settings.Delay) do
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            continue
        end

        if Settings.RobAllTycoons then
            for _, a in pairs(workspace:GetChildren()) do
                if string.find(a.Name, "Tycoon") and a:FindFirstChild("One") and a.One:FindFirstChild("CashColloector") then
                    fireTouch( a.One.CashColloector.Collector.TakeMoney, LocalPlayer.Character.HumanoidRootPart )
                end
            end
        end

        if Settings.GrabRareThings then
            for _, a in pairs(workspace.Forest.RareThings:GetChildren()) do
                if a.Name == "SmallChest" and a:FindFirstChild("Target") then
                    fireTouch(a.Target.TouchingPart, LocalPlayer.Character.HumanoidRootPart)
                end
            end
        end

        if Settings.GrabHiddenThings then
            fireTouch( workspace.Landscape.Floatingisland.TreasureChests.HitBox, LocalPlayer.Character.HumanoidRootPart )
        end

        if Settings.AutoClaimCash then
            claimCash()
        end

        if Settings.AutoBuyButtons then
            local tycoon = getTycoon()
            if tycoon then
                for _, a in pairs(tycoon:GetDescendants()) do
                    if a:IsA("Model") and a.Name == "Button" and a:FindFirstChild("Head") and not a:FindFirstChild("Robux") and not a:FindFirstChild("DestroyIfPastStage") then
                        fireTouch( LocalPlayer.Character.HumanoidRootPart, a.Head )
                    end
                end
            end
        end

        if Settings.AutoConfirmPurchases then
            local gui = LocalPlayer.PlayerGui:FindFirstChild("Confirm")
            if gui then
                firesignal(gui.Confirm.MouseButton1Click)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        local tool = getTool()
        if not tool then continue end

        if Settings.KillAllBots then
            for _, a in pairs(workspace:GetDescendants()) do
                if (a.Name == "RealBot" or a.Name == "Private Guard") and a:FindFirstChild("HumanoidRootPart") and a:FindFirstChildWhichIsA("Humanoid") then
                    tool:Activate()
                    fireTouch(tool.Handle, a.HumanoidRootPart)
                end
            end
        end

        if Settings.KillAllPlayers then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildWhichIsA("Humanoid") then
                    tool:Activate()
                    fireTouch(tool.Handle, p.Character.HumanoidRootPart)
                end
            end
        end
    end
end)
task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AppleStore then
            for _, a in pairs(workspace.City.AppleStore.RobableItems:GetChildren()) do
                grabAppleCash(a)
            end
            for _, a in pairs(workspace.City.AppleStore.RobableItems.Floor2:GetChildren()) do
                grabAppleCash(a)
            end
            claimCash()
        end

        if Settings.CoffeeShop then
            for _, a in pairs(workspace.City.CoffeShop:GetChildren()) do
                if a.Name == "Register" then
                    fireTouch(a, LocalPlayer.Character.HumanoidRootPart)
                end
            end
            claimCash()
        end

        if Settings.CreepyShop then
            fireTouch(workspace.Forest.CreepyShop.CrystalSet1.TouchEventPlayer, LocalPlayer.Character.HumanoidRootPart)
            fireTouch(workspace.Forest.CreepyShop.Register, LocalPlayer.Character.HumanoidRootPart)
            claimCash()
        end
    end
end)
