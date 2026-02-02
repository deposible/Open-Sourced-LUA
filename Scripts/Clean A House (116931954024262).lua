--[[
    WIRE.EquipTool tagged out. find your own method to 
]]

getgenv().Settings = {
    AutoCleanHouse = true,
    FinishHouse = true,
    AutoUpgradeHouse = true
}

if AlreadyHas then return end getgenv().AlreadyHas = true

local LocalPlayer = game.Players.LocalPlayer

local GrabHouse = function()
    for _, a in pairs(workspace.GameFolder.Plots:GetChildren()) do
        if tostring(Attribute(a, 'Owner')) == LocalPlayer.Name then
            return a
        end
    end
end
local Attribute = function(Part, Attribute)
    local success, atr = pcall(function()
        return Part:GetAttribute(Attribute)
    end)

    return success and atr or false
end
local Loop = function(delay, func)
    task.spawn(function()
        while task.wait(delay) do
            pcall(func)
        end
    end)
end

Loop(1, function()
    if Settings["AutoCleanHouse"] then
        local Plot = GrabHouse()
        local CurrentHouse = Plot.House:FindFirstChildWhichIsA('Model')

        for _, b in pairs(CurrentHouse:GetChildren()) do
            pcall(function()
                if b.Name == "BrokenVersion" then
                    for _, c in pairs(b:GetChildren()) do
                        --WIRE.EquipTool("Hammer")
                        task.wait(0.2)
                        game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.ItemService.RF.UseHammer:InvokeServer('Break', Attribute(c, 'id'))
                        task.wait(0.2)
                        if not LocalPlayer.Character:FindFirstChild(c.Name) and not LocalPlayer.Backpack:FindFirstChild(c.Name) then
                            game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.ItemService.RF.PurchaseItem:InvokeServer(c.Name)
                        end
                        --WIRE.EquipTool(c.Name)
                        task.wait(0.2)
                        game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.ItemService.RF.NewFurniture:InvokeServer(Attribute(c, 'id'))
                        task.wait(0.5)
                    end
                elseif b.Name == "Cobweb" then
                    for i = 1, 3 do
                        --WIRE.EquipTool("Brush")
                        game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.ItemService.RF.CleanCobweb:InvokeServer(Attribute(b, 'key'))
                        task.wait(1.5)
                    end
                elseif b.Name == "Spills" then
                    for _, c in pairs(b:GetChildren()) do
                        for i = 1, 4 do
                            --WIRE.EquipTool("Broom")
                            task.wait(0.2)
                            game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.ItemService.RF.UseBroom:InvokeServer(Attribute(c, 'id'))
                            task.wait(0.5)
                        end
                    end
                elseif b.Name == "Rats" then
                    for i = 1, 5 do
                        for _, c in pairs(b:GetChildren()) do
                            --WIRE.EquipTool("Hammer")
                            task.wait(0.1)
                            game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.ItemService.RF.UseHammer:InvokeServer('Rat', Attribute(c, 'id'))
                            task.wait(0.1)
                        end
                    end
                elseif b:IsA('Part') then
                    task.spawn(function()
                        game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.ItemService.RF.CleanSurface:InvokeServer(b.Name)
                        task.wait(1)
                        game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.ItemService.RF.PaintSurface:InvokeServer(b.Name)
                    end)
                elseif b.Name == "HalloweenEvent" then
                    for _, c in pairs(b:GetChildren()) do
                        --WIRE.EquipTool("Hammer")
                        if c.Name == "jackolantern" then
                            game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.ItemService.RF.UseHammer:InvokeServer('Break', Attribute(c, 'id'))
                        end
                    end
                end
            end)
        end

        repeat task.wait() until not CurrentHouse ~= Plot.House:FindFirstChildWhichIsA('Model')
    end
    if Settings["FinishHouse"] then
        local Finished = true

        for _, a in pairs(LocalPlayer.PlayerGui.HUD.Customer.Frame.Required:GetChildren()) do
            if a:IsA('TextLael') and (a.TextColor3 ~= Color3.fromRGB(106, 234, 99) or a.TextColor3 ~= Color3.fromRGB(34, 234, 34)) then
                Finished = false
                break
            end
        end

        if Finished then
            firesignal(LocalPlayer.PlayerGui.HUD.Customer.Frame.Finish.MouseButton1Click)
        end
    end
    if Settings["AutoUpgradeHouse"] then
        game.ReplicatedStorage.Framework.Libraries.Packages.Knit.Services.PlayerService.RF.UpgradeHouse:InvokeServer()
    end
end)
