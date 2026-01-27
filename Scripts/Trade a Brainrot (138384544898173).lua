getgenv().Settings = {
    Delay = 1,
    AutoRebirth = true,
    AutoCollectCash = true,
    AutoOpenEggs = true,
    AutoTrade = true,
    HumanLikeTrade = false,
    HatchFarm = false,
    AutoBuyEggs = false,
    TradeFairness = {"Fair Trade", "Good Trade"},
    EggsToBuy = {"Simple Egg", "Good Egg", "Hacker Egg", "Kawaii Egg", "Star Egg", "Crystal Egg", "Secret Egg"},
    RequireMutation = false,
    Mutations = {"Golden", "Volcanic", "Diamond", "Bubblegum", "Bloodmoon", "Galaxy", "Blackhole", "Atlantis", "Halloween"}
}

if AlreadyLoaded then return end
getgenv().AlreadyLoaded = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local GrabBase = function()
    for _, a in pairs(workspace.GameObjects.Plots:GetChildren()) do
        if tostring(Attribute(a, "Owner")) == LocalPlayer.Name then
            return a
        end
    end
end

local GetCustomer = function()
    local Base = GrabBase()
    if not Base then return end
    for _, a in pairs(Base.Logic.Customers:GetChildren()) do
        if a:FindFirstChild("Head") and a.Head:FindFirstChild("Trade") then
            return a
        end
    end
end

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AutoRebirth then
            game.ReplicatedStorage.Packages.Knit.Services.RebirthService.RF.Rebirth:InvokeServer()
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AutoCollectCash then
            local Base = GrabBase()
            if Base then
                for _, a in pairs(Base.Logic.BrainrotSlots:GetChildren()) do
                    WIRE.firetouchinterest(LocalPlayer.Character.HumanoidRootPart, a.CashCollect)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AutoOpenEggs then
            local Base = GrabBase()
            if Base then
                for _, a in pairs(Base.Logic.BrainrotSlots:GetChildren()) do
                    if a.Item:FindFirstChild("Egg") and a.Item.Egg.Hitbox.HeightAttachment.ProximityPrompt.Enabled and a.Item.Egg.Hitbox.HeightAttachment.ProximityPrompt.ActionText == "Hatch Now" then
                        fireproximityprompt(a.Item.Egg.Hitbox.HeightAttachment.ProximityPrompt)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.AutoTrade then
            local Customer = GetCustomer()
            if Customer then
                local Text = Customer.Head.Trade.FairnessMeter.TradeFairness.TextLabel.Text
                if table.find(Settings.TradeFairness, Text) then
                    game.ReplicatedStorage.Packages.Knit.Services.NpcTradeService.RF.Clicked:InvokeServer("Accept")
                else
                    game.ReplicatedStorage.Packages.Knit.Services.NpcTradeService.RF.Clicked:InvokeServer("AddMore")
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.HumanLikeTrade then
            local Customer = GetCustomer()
            if Customer then
                local FrameCount = 0
                local SelfCount = 0
                for _, a in pairs(Customer.Head.Trade.Trade.Frame.Them:GetChildren()) do
                    if a.Name:match("Brainrot") then
                        FrameCount += 1
                    end
                end
                for _, a in pairs(Customer.Head.Trade.Trade.Frame.You:GetChildren()) do
                    if a.Name:match("Brainrot") then
                        SelfCount += 1
                    end
                end
                local Text = Customer.Head.Trade.FairnessMeter.TradeFairness.TextLabel.Text
                if (FrameCount == 1 and SelfCount == 2 and Text ~= "Bad Trade") or (FrameCount == 1 and Text == "Good Trade") or (FrameCount == 2 and Text == "Good Trade") then
                    game.ReplicatedStorage.Packages.Knit.Services.NpcTradeService.RF.Clicked:InvokeServer("Accept")
                else
                    game.ReplicatedStorage.Packages.Knit.Services.NpcTradeService.RF.Clicked:InvokeServer("Decline")
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(Settings.Delay) do
        if Settings.HatchFarm then
            local Base = GrabBase()
            if Base then
                for _, a in pairs(Base.Logic.BrainrotSlots:GetChildren()) do
                    if a.Part.Transparency < 1 or (a.Item:FindFirstChild("Egg") and a.Item.Egg.Hitbox.TopAttachment.HatchTime.Frame.Time.Frame.Xp.Text == "Ready!") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = a.Part.CFrame
                        task.wait(0.5)
                        if a.Item:FindFirstChild("Egg") and a.Item.Egg.Hitbox.TopAttachment.HatchTime.Frame.Time.Frame.Xp.Text == "Ready!" then
                            fireproximityprompt(a.Item:FindFirstChildWhichIsA("Model").Hitbox.HeightAttachment.ProximityPrompt)
                            task.wait(3.5)
                        end
                        fireproximityprompt(a.Spawn.ProximityPrompt)
                        task.wait(2)
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if Settings.AutoBuyEggs then
            local Base = GrabBase()
            if Base then
                for _, a in pairs(Base.Logic.Eggs:GetChildren()) do
                    local EggName = a.Hitbox.TopAttachment.EggPurchase.Frame.EggName.Text
                    local Mutation = a.Hitbox.TopAttachment.EggPurchase.Frame.Mutation.Text
                    if (#Settings.EggsToBuy == 0 or table.find(Settings.EggsToBuy, EggName)) and (not Settings.RequireMutation or table.find(Settings.Mutations, Mutation)) then
                        game.ReplicatedStorage.Packages.Knit.Services.EggService.RF.BuyEgg:InvokeServer(a.Name)
                    end
                end
            end
        end
    end
end)
