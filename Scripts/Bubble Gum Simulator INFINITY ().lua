-- This code was generated using chatgpt of previous version of my code as i am not recoding this massive pile for a game i have discontinued.

getgenv().Settings = getgenv().Settings or {
    AutoTrickOrTreat = false,
    BlowBubbles = false,
    SellBubbles = false,
    ClaimPrizes = false,
    ClaimBattlepass = false,
    ClaimPlaytime = false,

    GenieStartQuest = false,
    GenieAutoComplete = false,

    OpenMysteryBox = false,
    UseGoldenOrbs = false,
    SpinWheel = false,
    FreeWheelSpin = false,

    UpgradePotions = false,
    PotionList = { "Lucky", "Speed", "Coins", "Mythic" },

    CollectNearest = false,
    GrabChests = false,
    ChestList = { "Void Chest", "Giant Chest", "Ticket Chest" },

    AutoRiftEggs = false,
    AutoRiftGifts = false,
    RiftEgg1 = "Common Egg",
    RiftEgg2 = "Spotted Egg",
    RiftEgg3 = "Spikey Egg",

    UnlockAllIslands = false,
    ClaimFreeStuff = false,

    BuyStorage = false,
    BuyFlavors = false,
    BuyMasteries = false,
    Masteries = { "Buffs", "Pets", "Shops" },
    AutoBlackmarket = false,
    AutoAlienShop = false,

    PetMatch = false,
    CartEscape = false,
    RobotClaw = false,
    HyperDarts = false,
    AutoDoggyJump = false,

    PetMatchDiff = "Easy",
    CartEscapeDiff = "Easy",
    RobotClawDiff = "Easy",
    HyperDartsDiff = "Easy",

    Delay = {
        TOT = 0.1,
        Blow = 0.15,
        Sell = 2.5,
        Prizes = 5,
        Battlepass = 2.5,
        Playtime = 5,
        GenieQuest = 2.5,
        GenieComplete = 0.25,
        Use = 5,
        FreeWheel = 10,
        Potions = 1,
        Collect = 0.1,
        GrabChests = 0.1,
        Rift = 1,
        AutoBuy = 5,
        Blackmarket = 1,
        AlienShop = 1,
        Minigames = 5
    }
}

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TweenService = game:GetService('TweenService')
local VirtualInputManager = game:GetService('VirtualInputManager')

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild('HumanoidRootPart')
local Humanoid = Character:FindFirstChildWhichIsA('Humanoid')

LocalPlayer.CharacterAdded:Connect(function(c)
    Character = c
    HRP = c:WaitForChild('HumanoidRootPart')
    Humanoid = c:FindFirstChildWhichIsA('Humanoid')
end)

local Storage = {
    "Stretchy Gum", "Chewy Gum", "Epic Gum", "Ultra Gum", "Omega Gum", "Unreal Gum",
    "Cosmic Gum", "XL Gum", "Mega Gum", "Quantum Gum", "Alien Gum", "Radioactive Gum", "Experiment #52", ""
}

local Flavors = {
    "Blueberry", "Cherry", "Pizza", "Watermelon", "Chocolate", "Contrast",
    "Gold", "Lemon", "Donut", "Swirl", "Molten", "Abstract"
}

local Eggs = {
    { "Common Egg", "Common" }, { "Spotted Egg", "Spotted" }, { "Iceshard Egg", "Iceshard" }, { "Spikey Egg", "Spikey" }, { "Magma Egg", "Magma" }, { "Crystal Egg", "Cystal" },
    { "Lunar Egg", "Lunar" }, { "Void Egg", "Void" }, { "Hell Egg", "Hell" }, { "Nightmare Egg", "Nightmare" }, { "Rainbow Egg", "Rainbow" }, { "Showman Egg", "Showman" },
    { "Mining Egg", "Mining" }, { "Cyber Egg", "Cyber" }, { "Neon Egg", "Neon" }, { "Beach Egg", "Beach Egg" }, { "Icecream Egg", "Icecream Egg" }, { "Fruit Egg", "Fruit Egg" }
}

local apcall = apcall or function(fn)
    local ok = pcall(fn)
    return ok
end

local function Disable(...)
    for _, k in pairs({ ... }) do
        Settings[k] = false
    end
end

local function Attribute(obj, name)
    if obj and obj.GetAttribute then
        return obj:GetAttribute(name)
    end
end

local function EventFire(args)
    ReplicatedStorage.Shared.Framework.Network.Remote.RemoteEvent:FireServer(unpack(args))
end

local function EventInvoke(args)
    return ReplicatedStorage.Shared.Framework.Network.Remote.RemoteFunction:InvokeServer(unpack(args))
end

local function TweenTo(goal)
    if not HRP or not Humanoid then return end
    local cf = typeof(goal) == "CFrame" and goal or CFrame.new(goal)
    local dist = (HRP.Position - cf.Position).Magnitude
    local spd = Humanoid.WalkSpeed > 0 and Humanoid.WalkSpeed or 16
    local t = dist / spd

    local tw = TweenService:Create(HRP, TweenInfo.new(t, Enum.EasingStyle.Linear), { CFrame = cf })
    tw:Play()
    tw.Completed:Wait()
end

local function Click()
    local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
    local x, y = math.floor(vp.X / 2), math.floor(vp.Y / 2)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
    VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
end

task.spawn(function()
    while task.wait(Settings.Delay.TOT) do
        if Settings.AutoTrickOrTreat then
            Disable("CollectNearest")
            for _, a in pairs(workspace.HalloweenEvent.Houses:GetChildren()) do
                if not Settings.AutoTrickOrTreat then break end
                if a:FindFirstChild("Activation") and a.Activation:FindFirstChild("Root") then
                    TweenTo(a.Activation.Root:GetPivot())
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Blow) do
        if Settings.BlowBubbles then
            EventFire({ "BlowBubble" })
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Sell) do
        if Settings.SellBubbles then
            EventFire({ "SellBubble" })
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Prizes) do
        if Settings.ClaimPrizes then
            for i = 1, 100 do
                if not Settings.ClaimPrizes then break end
                EventFire({ "ClaimPrize", i })
                task.wait(0.1)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Battlepass) do
        if Settings.ClaimBattlepass then
            EventFire({ "ClaimSeason" })
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Playtime) do
        if Settings.ClaimPlaytime then
            for i = 1, 12 do
                if not Settings.ClaimPlaytime then break end
                EventInvoke({ "ClaimPlaytime", i })
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.GenieQuest) do
        if Settings.GenieStartQuest then
            EventFire({ "StartGenieQuest", 1 })
        end
    end
end)

local OVERWORLD_EGG_POS_A = Vector3.new(-5.75655842, 9.59802437, -82.0251846)
local OVERWORLD_EGG_POS_B = Vector3.new(-8.48505211, 9.59802437, -70.7082214)
local FLOATING_EGG_POS = Vector3.new(-6.7575264, 423.531647, 159.570404)

task.spawn(function()
    while task.wait(Settings.Delay.GenieComplete) do
        if not Settings.GenieAutoComplete then continue end

        local gui = LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
        if not gui or not gui:FindFirstChild("GemGenieTask") then continue end

        local Task = gui.GemGenieTask.Content.Info.Task.Text

        if Task:match('Hatch') and Task:match('Eggs') then
            if (HRP.Position - OVERWORLD_EGG_POS_A).Magnitude > 15 then
                EventFire({ "Teleport", "Workspace.Worlds.The Overworld.PortalSpawn" })
                task.wait(1)
                TweenTo(OVERWORLD_EGG_POS_A)
            end
            EventFire({ "Hatch Egg", "Common Egg", 6 })
        end

        if Task:match('Blow') and Task:match('Bubbles') then
            if not Settings.BlowBubbles or not Settings.SellBubbles then
                Settings.BlowBubbles = true
                Settings.SellBubbles = true
            end
        end

        if Task:match('Collect') and Task:match('Coins') then
            EventFire({ "Teleport", "Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn" })
            task.wait(2)
            Settings.CollectNearest = true

            repeat task.wait()
                if not Settings.GenieAutoComplete then break end
            until (not gui.GemGenieTask.Content.Info.Task.Text:match('Collect')) or (not gui.GemGenieTask.Content.Info.Task.Text:match('Coins'))
        end

        if Task:match('Hatch') and Task:match('Pets') then
            if Task:match('Common') or Task:match("Unique") or Task:match('Rare') then
                if (HRP.Position - OVERWORLD_EGG_POS_A).Magnitude > 15 then
                    EventFire({ "Teleport", "Workspace.Worlds.The Overworld.PortalSpawn" })
                    task.wait(1)
                    TweenTo(OVERWORLD_EGG_POS_A)
                end
                EventFire({ "Hatch Egg", "Common Egg", 6 })
            end

            if Task:match('Epic') then
                if (HRP.Position - OVERWORLD_EGG_POS_B).Magnitude > 15 then
                    EventFire({ "Teleport", "Workspace.Worlds.The Overworld.PortalSpawn" })
                    task.wait(1)
                    TweenTo(OVERWORLD_EGG_POS_B)
                end
                EventFire({ "Hatch Egg", "Spotted Egg", 6 })
            end

            if Task:match('Legendary') then
                if (HRP.Position - FLOATING_EGG_POS).Magnitude > 15 then
                    EventFire({ "Teleport", "Workspace.Worlds.The Overworld.Islands.Floating Island.Island.Portal.Spawn" })
                    task.wait(1)
                    TweenTo(FLOATING_EGG_POS)
                end
                EventFire({ "Hatch Egg", "Spikey Egg", 6 })
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Use) do
        if Settings.OpenMysteryBox then
            EventFire({ "UseGift", "Mystery Box", 1 })
        end

        if Settings.UseGoldenOrbs then
            EventFire({ "UseGoldenOrb" })
        end

        if Settings.SpinWheel then
            EventInvoke({ "WheelSpin" })
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.FreeWheel) do
        if Settings.FreeWheelSpin then
            EventFire({ "ClaimFreeWheelSpin" })
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Potions) do
        if Settings.UpgradePotions then
            for _, a in pairs(Settings.PotionList) do
                for i = 1, 5 do
                    if not Settings.UpgradePotions then break end
                    EventFire({ "CraftPotion", a, i, false })
                    task.wait()
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Collect) do
        if Settings.CollectNearest then
            Disable("AutoTrickOrTreat")
            for _, a in pairs(workspace.Rendered:GetChildren()) do
                if not Settings.CollectNearest then break end
                if a.Name == "Chunker" and #a:GetChildren() > 1 then
                    local Nearest, Dist = nil, math.huge
                    for _, b in pairs(a:GetChildren()) do
                        local mp = b and b:FindFirstChildWhichIsA('MeshPart')
                        if mp then
                            local d = (mp.Position - HRP.Position).Magnitude
                            if d < Dist then
                                Nearest = mp
                                Dist = d
                            end
                        end
                    end
                    if Nearest then
                        TweenTo(Nearest.Position)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.GrabChests) do
        if Settings.GrabChests then
            for _, a in pairs(Settings.ChestList) do
                if not Settings.GrabChests then break end
                EventFire({ "ClaimChest", a, true })
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Rift) do
        if Settings.AutoRiftEggs then
            Disable("CollectNearest", "GrabChests")
            for _, r in pairs(workspace.Rendered.Rifts:GetChildren()) do
                if not Settings.AutoRiftEggs then break end

                local Found
                local n = tostring(r.Name):lower()

                if Settings.RiftEgg1 and n:match(tostring(Settings.RiftEgg1):lower()) then
                    Found = Settings.RiftEgg1
                elseif Settings.RiftEgg2 and n:match(tostring(Settings.RiftEgg2):lower()) then
                    Found = Settings.RiftEgg2
                elseif Settings.RiftEgg3 and n:match(tostring(Settings.RiftEgg3):lower()) then
                    Found = Settings.RiftEgg3
                end

                if Found and r:FindFirstChild("Output") then
                    TweenTo(r.Output.CFrame.Position)
                    repeat
                        if not Settings.AutoRiftEggs then break end
                        EventFire({ "HatchEgg", Found, 3 })
                        EventFire({ "HatchEgg", Found, 1 })
                        task.wait(0.25)
                    until not Settings.AutoRiftEggs or not r
                    break
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Rift) do
        if Settings.AutoRiftGifts then
            Disable("CollectNearest", "GrabChests", "AutoRiftEggs")
            for _, r in pairs(workspace.Rendered.Rifts:GetChildren()) do
                if not Settings.AutoRiftGifts then break end
                if tostring(r.Name):lower():match('gift') and r:FindFirstChild("Gift") and r.Gift:FindFirstChild("Prompt") then
                    TweenTo(r.Gift.Prompt.CFrame.Position)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.25) do
        if Settings.UnlockAllIslands then
            Settings.UnlockAllIslands = false
            for _, b in pairs(workspace.Worlds:GetChildren()) do
                if b:FindFirstChild("Islands") then
                    for _, a in pairs(b.Islands:GetChildren()) do
                        if a:FindFirstChild("Island") and a.Island:FindFirstChild("UnlockHitbox") then
                            firetouchinterest(HRP, a.Island.UnlockHitbox, 0)
                            firetouchinterest(HRP, a.Island.UnlockHitbox, 1)
                        end
                    end
                end
            end
        end

        if Settings.ClaimFreeStuff then
            Settings.ClaimFreeStuff = false
            for _, a in pairs({ "FreeNotifyLegendary", "ClaimFreeWheelSpin" }) do
                EventFire({ a })
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.AutoBuy) do
        if Settings.BuyStorage then
            for _, a in next, Storage do
                if not Settings.BuyStorage then break end
                EventFire({ "GumShopPurchase", a })
            end
        end

        if Settings.BuyFlavors then
            for _, a in next, Flavors do
                if not Settings.BuyFlavors then break end
                EventFire({ "GumShopPurchase", a })
            end
        end

        if Settings.BuyMasteries then
            for _, a in pairs(Settings.Masteries) do
                if not Settings.BuyMasteries then break end
                EventFire({ "UpgradeMastery", a })
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Blackmarket) do
        if Settings.AutoBlackmarket then
            for i = 1, 6 do
                if not Settings.AutoBlackmarket then break end
                EventFire({ "BuyShopItem", "shard-shop", i })
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.AlienShop) do
        if Settings.AutoAlienShop then
            for i = 1, 3 do
                if not Settings.AutoAlienShop then break end
                EventFire({ "BuyShopItem", "alien-shop", i })
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Minigames) do
        if Settings.PetMatch then
            EventFire({ "StartMinigame", "Pet Match", Settings.PetMatchDiff })
            task.wait(8)
            EventFire({ "FinishMinigame" })
        end

        if Settings.CartEscape then
            EventFire({ "StartMinigame", "Cart Escape", Settings.CartEscapeDiff })
            task.wait(20)
            EventFire({ "FinishMinigame" })
        end

        if Settings.HyperDarts then
            EventFire({ "StartMinigame", "Hyper Darts", Settings.HyperDartsDiff })
            task.wait(20)
            EventFire({ "FinishMinigame" })
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay.Minigames) do
        if Settings.RobotClaw then
            EventFire({ "StartMinigame", "Robot Claw", Settings.RobotClawDiff })
            task.wait(20)
            if workspace:FindFirstChild("ClawMachine") then
                for _, a in pairs(workspace.ClawMachine:GetChildren()) do
                    if not Settings.RobotClaw then break end
                    if a.Name == "Capsule" then
                        EventFire({ "GrabMinigameItem", Attribute(a, "ItemGUID") })
                        task.wait(0.15)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    local conn

    local function disconnect()
        if conn then
            conn:Disconnect()
            conn = nil
        end
    end

    while task.wait(0.2) do
        if Settings.AutoDoggyJump and not conn then
            local gui = LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
            if gui and gui:FindFirstChild("DoggyJump") then
                local dj = gui.DoggyJump
                local area = dj.Frame.Inner.Main.Area.Objects

                conn = area.ChildAdded:Connect(function(a)
                    apcall(function()
                        local score = tonumber(dj.Frame.Inner.Main.Area.Score.Text:match("Score: (.*)"))
                        if score and score <= 500 then
                            repeat task.wait() until a.Position.X.Offset < 150 or not Settings.AutoDoggyJump
                            if Settings.AutoDoggyJump then
                                Click()
                            end
                        end
                    end)
                end)
            end
        end

        if not Settings.AutoDoggyJump and conn then
            disconnect()
        end

        if Settings.AutoDoggyJump then
            local gui = LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
            if gui and gui:FindFirstChild("DoggyJump") then
                local dj = gui.DoggyJump
                local label = tostring(dj.Frame.Label)
                if not label:match('More prizes available in') then
                    dj.Visible = true
                end
            end
        end
    end
end)
