--[[
    Egg List: {{"Spawn Egg", "Zone_0"}, {"Candy Egg", "Zone_1"}, {"Ice Egg", "Zone_2"}, {"Volcanic Egg", "Zone_3"}, {"Void Egg", "Zone_4"}, {"Alien Egg", "Zone_5"}, {"Heaven Egg", "Zone_6"}, {"Hell Egg", "Zone_7"}, {"Space Egg", "Zone_8"}}
]]
getgenv().Settings = {
    ["Auto Click Fast"] = true,
    ["Claim Gifts"] = true,
    ["Auto Rebirth"] = true,
    ["Auto Open Eggs"] = false,
    ["Egg To Open"] = nil -- Check Above for list only use the second string!
}

if ReExecute then return else getgenv().ReExecute = true end

local LocalPlayer = game.Players.LocalPlayer
local replicatedstorage = game.ReplicatedStorage

local loop = function(del, func)
    task.spawn(function()
        while task.wait(del) do
            pcall(func)
        end
    end)
end

game:GetService('RunService').Heartbeat:Connect(function()
    if Settings["Auto Click Fast"] then
        replicatedstorage.events.ClickEvent:FireServer('cReq', true)
    end
end)

loop(1, function()
    if Settings["Auto Rebirth"] then
        local MostRebirths = 0
    
        for _, a in pairs(LocalPlayer.PlayerGui.Main.RebirthFrame.ScrollingFrame:GetChildren()) do
            if a:IsA('ImageLabel') and a.Visible and tonumber(a.Name:match('rebirth_(.*)')) > MostRebirths then
                MostRebirths = tonumber(a.Name:match('rebirth_(.*)'))
            end
        end

        replicatedstorage.events.RebirthEvent:FireServer("req_Rebirth", MostRebirths)
    end
    if Settings["Auto Open Eggs"] then
        replicatedstorage.events.HatcherEvent:FireServer('egg_Hatch', E1:Value(), "hatch")
    end
end)
loop(10, function()
    if Settings["Claim Gifts"] then
        for i = 1, 8 do
            replicatedstorage.events.GiftSystemFunc:InvokeServer("ClaimGift", { giftName = "Gift"..i} )            
        end
    end
end)
