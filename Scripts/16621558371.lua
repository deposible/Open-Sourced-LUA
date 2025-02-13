getgenv().DeposibleOnTop = {
    ["Farm Coins"] = false,
    ["Fast Farm"] = false, -- this may cause extremely lag so heads up
    ["Rebirth"] = false,
    ["Claim Gifts"] = false
}

local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end
local GetZone = function()
    for _, zone in pairs(Workspace.Game.Zones:GetChildren()) do
        if (zone.Teleport.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 300 then
            return zone.Name
        end
    end
end

newtask(0.1, "Farm Coins", function()
    local Subject = 0
    local ArgumenValue = 50
    local Argus = {}
    local CurrentKeyValue = tonumber(game.Players.LocalPlayer.PlayerData.Stats.Speed.Value)

    if GetZone() == "Summer" then
        local SUMMERKEYS = tonumber(game.Players.LocalPlayer.PlayerData.Stats.SummerKeys.Value)

        if SUMMERKEYS < 262 then
            print'UNUSABLE'
        elseif SUMMERKEYS < 3300 then
            Subject = 1
        elseif SUMMERKEYS < 15900 then
            Subject = 2
        elseif SUMMERKEYS < 57200 then
            Subject = 3
        elseif SUMMERKEYS < 616000 then
            Subject = 4
        else
            Subject = 5
        end
    elseif GetZone() == "Zone1" then
        if CurrentKeyValue < 685 then
            Subject = 1
        elseif CurrentKeyValue < 4400 then
            Subject = 2
        elseif CurrentKeyValue < 40100 then
            Subject = 3
        elseif CurrentKeyValue < 424900 then
            Subject = 4
        elseif CurrentKeyValue > 424900 then
            Subject = 5
        end
    elseif GetZone() == "Zone2" then
        if CurrentKeyValue > 2000000 and CurrentKeyValue < 10200000 then
            Subject = 1
        elseif CurrentKeyValue < 10200000 then
            Subject = 1
        elseif CurrentKeyValue < 72500000 then
            Subject = 2
        elseif CurrentKeyValue < 290000000 then
            Subject = 3
        elseif CurrentKeyValue < 3600000000 then
            Subject = 4
        else
            Subject = 5 
        end
    elseif GetZone() == "Zone3" then
        if CurrentKeyValue > 11300000000 and CurrentKeyValue < 67400000000 then
            Subject = 1
        elseif CurrentKeyValue < 224700000000 then
            Subject = 2
        elseif CurrentKeyValue < 436600000000 then
            Subject = 3
        elseif CurrentKeyValue < 3100000000000 then
            Subject = 4
        else
            Subject = 5 
        end
    elseif GetZone() == "Zone4" then
        if CurrentKeyValue > 8000000000000 and CurrentKeyValue < 16200000000000 then
            Subject = 1
        elseif CurrentKeyValue < 43600000000000 then
            Subject = 2
        elseif CurrentKeyValue < 100000000000000 then
            Subject = 3
        elseif CurrentKeyValue < 652000000000000 then
            Subject = 4
        else
            Subject = 5 
        end
    elseif GetZone() == "Zone5" then
        if CurrentKeyValue > 1500000000000000 and CurrentKeyValue < 5200000000000000 then
            Subject = 1
        elseif CurrentKeyValue < 13900000000000000 then
            Subject = 2
        else
            Subject = 3
        end
    elseif GetZone() == "Zone6" then
        if CurrentKeyValue > 62100000000000000 and CurrentKeyValue < 154800000000000000 then
            Subject = 1
        elseif CurrentKeyValue < 248000000000000000 then
            Subject = 2
        elseif CurrentKeyValue < 725000000000000000 then
            Subject = 3
        elseif CurrentKeyValue < 1300000000000000000 then
            Subject = 4
        else
            Subject = 5 
        end
    elseif GetZone() == "Zone7" then
        if CurrentKeyValue > 2000000 and CurrentKeyValue < 10200000 then
            Subject = 1
        elseif CurrentKeyValue < 10200000 then
            Subject = 1
        elseif CurrentKeyValue < 72500000 then
            Subject = 2
        elseif CurrentKeyValue < 290000000 then
            Subject = 3
        elseif CurrentKeyValue < 3600000000 then
            Subject = 4
        else
            Subject = 5 
        end
    elseif GetZone() == "Zone8" then
        if CurrentKeyValue > 2000000 and CurrentKeyValue < 10200000 then
            Subject = 1
        elseif CurrentKeyValue < 10200000 then
            Subject = 1
        elseif CurrentKeyValue < 72500000 then
            Subject = 2
        elseif CurrentKeyValue < 290000000 then
            Subject = 3
        elseif CurrentKeyValue < 3600000000 then
            Subject = 4
        else
            Subject = 5 
        end
    end

    game.ReplicatedStorage["_GAME"]["_MODULES"].Utilities.NetworkUtility.Events.UpdateTest:FireServer('Join', Workspace.Game.Zones[GetZone()].Tests["Test" .. Subject])

    for i = 1, ArgumenValue do
        table.insert(Argus, {["index"] = i, ["mistakes"] = 0})

        if not DeposibleOnTop["Fast Farm"] then
            task.wait()
        end
    end

    game.ReplicatedStorage["_GAME"]["_MODULES"].Utilities.NetworkUtility.Events.UpdateTest:FireServer('ConfirmWord', Workspace.Game.Zones[GetZone()].Tests["Test" .. Subject], Argus, false)

    task.wait()

    game.ReplicatedStorage["_GAME"]["_MODULES"].Utilities.NetworkUtility.Events.UpdateTest:FireServer('Leave')
end)
newtask(0.1, "Farm Keys", function()
    game:GetService('ReplicatedStorage')["_GAME"]["_MODULES"].Utilities.NetworkUtility.Events.UpdateDesk:FireServer('Smash')
end)
newtask(0.5, "Rebirth", function()
    game:GetService('ReplicatedStorage')["_GAME"]["_MODULES"].Utilities.NetworkUtility.Events.UpdateRebirths:FireServer('AttemptRebirth')
end)
newtask(1, "Claim Gifts", function()
    for i = 1, 12 do
        game:GetService('ReplicatedStorage')["_GAME"]["_MODULES"].Utilities.NetworkUtility.Events.Rewards:FireServer('ClaimGiftReward', i)
    end
end)
