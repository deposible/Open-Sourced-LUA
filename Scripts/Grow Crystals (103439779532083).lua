getgenv().Settings = {
    AutoGrabOres = false,
    AutoSell = false,
    AutoPlaceCrystals = false,
    OresToPlace = {},
    BuyOres = false,
    BuyMiners = false,
    BuyGears = false,
    MinersToBuy = {},
    OresToBuy = {},
    GearsToBuy = {}
}

if AlreadyRan then return end
getgenv().AlreadyRan = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local replicatedstorage = game:GetService("ReplicatedStorage")

local GrabFarm = function()
    for _, a in pairs(workspace.Plots:GetChildren()) do
        if Attribute(a, "Owner") == LocalPlayer.UserId then
            return a
        end
    end
end

local Fire = function(arg)
    replicatedstorage.Packages.Knit.Services.GameService.RE.Network:FireServer(unpack(arg))
end

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoGrabOres then
            local farm = GrabFarm()
            if farm then
                for _, a in pairs(farm.Items:GetChildren()) do
                    if not Attribute(a, "GrowthProgress") or tonumber(Attribute(a, "GrowthProgress")) >= 100 then
                        if (a.Primary.CFrame.Position - LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude >= 8 then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = a.Primary.CFrame
                        end
                        fireproximityprompt(a.Primary:FindFirstChildWhichIsA("ProximityPrompt"))
                    end
                    task.wait()
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoSell then
            replicatedstorage.Packages.Knit.Services.CashService.RF.SellInventory:InvokeServer()
        end
    end
end)

task.spawn(function()
    while task.wait(0.25) do
        if Settings.AutoPlaceCrystals then
            local farm = GrabFarm()
            if farm then
                for _, a in pairs(LocalPlayer.Backpack:GetChildren()) do
                    for _, b in pairs(Settings.OresToPlace) do
                        if a.Name == b then
                            EquipTool(a)
                            task.wait(0.1)
                            replicatedstorage.Packages.Knit.Services.PlotService.RE.PlaceItem:FireServer(farm.Placements["1"],Vector3.new(farm.Placements["1"].Position.X, 63.65000015, farm.Placements["1"].Position.Z))
                            task.wait(0.05)
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.15) do
        if Settings.BuyOres then
            for _, a in pairs(LocalPlayer.PlayerGui.HUD.Menus.Materials.Container:GetChildren()) do
                for _, b in pairs(Settings.OresToBuy) do
                    if a.Name == b and not a.Stock.Text:match("x0 Stock") and not a.Stock.Text:match("Out Of Stock") then
                        local price = tonumber(a.Price.Text:gsub("%D",""))
                        for _ = 1, tonumber(a.Stock.Text:match("x(.*) Stock")) or 1 do
                            if price < LocalPlayer.leaderstats.Cash.Value then
                                replicatedstorage.Packages.Knit.Services.MaterialShopService.RF.Buy:InvokeServer(b)
                                task.wait(0.1)
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.15) do
        if Settings.BuyMiners then
            for _, a in pairs(LocalPlayer.PlayerGui.HUD.Menus.Miners.Container:GetChildren()) do
                for _, b in pairs(Settings.MinersToBuy) do
                    if a.Name == b and not a.Stock.Text:match("x0 Stock") and not a.Stock.Text:match("Out Of Stock") then
                        local price = tonumber(a.Price.Text:gsub("%D",""))
                        for _ = 1, tonumber(a.Stock.Text:match("x(.*) Stock")) or 1 do
                            if price < LocalPlayer.leaderstats.Cash.Value then
                                replicatedstorage.Packages.Knit.Services.MinerShopService.RF.Buy:InvokeServer(b)
                                task.wait(0.1)
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.15) do
        if Settings.BuyGears then
            for _, a in pairs(LocalPlayer.PlayerGui.HUD.Menus.Gears.Container:GetChildren()) do
                for _, b in pairs(Settings.GearsToBuy) do
                    if a.Name == b and not a.Stock.Text:match("x0 Stock") and not a.Stock.Text:match("Out Of Stock") then
                        local price = tonumber(a.Price.Text:gsub("%D",""))
                        for _ = 1, tonumber(a.Stock.Text:match("x(.*) Stock")) or 1 do
                            if price < LocalPlayer.leaderstats.Cash.Value then
                                replicatedstorage.Packages.Knit.Services.MinorShopService.RF.Buy:InvokeServer(b)
                                task.wait(0.1)
                            end
                        end
                    end
                end
            end
        end
    end
end)
