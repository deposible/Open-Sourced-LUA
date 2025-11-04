getgenv().Settings = {
    ["Auto Mine"] = true,
    ["Grab Drops"] = true,
    ["Auto Next World"] = true,
    ["Upgrade Pet"] = true
}

if ReExecute then return else getgenv().ReExecute = true end

local LocalPlayer = game.Players.LocalPlayer

local loop = function(del, func)
    task.spawn(function()
        while task.wait(del) do
            pcall(func)
        end
    end)
end

loop(0.1, function()
    LocalPlayer.PlayerGui.ScreenGui.Noti_Frame.Visible = false
end)
loop(0.25, function()
    if Settings["Auto Mine"] then
        game.ReplicatedStorage.RemoteEvent:FireServer({"Activate_Punch"})
    end
end)
loop(0.5, function()
    if Settings["Grab Drops"] then
        local Grabbed = 0

        for _, a in pairs(workspace.Map.Stages.Boosts[LocalPlayer.leaderstats.WORLD.Value]:GetChildren()) do
            if a:FindFirstChild('1') and Grabbed < 59 and (a.Name:match("MAP_"..tostring(LocalPlayer.leaderstats.WORLD.Value).."_5") or a.Name:match("MAP_"..tostring(LocalPlayer.leaderstats.WORLD.Value).."_4")) then
                a["1"].CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, a["1"], 0)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, a["1"], 1)
                Grabbed += 1
            end
        end

        if Grabbed >= 59 then
            task.wait(60)
        end
    end
end)
loop(1, function()
    if Settings["Auto Next World"] then
        game.ReplicatedStorage.RemoteEvent:FireServer({"WarpPlrToOtherMap", "Next"})
    end
    if Settings["Upgrade Pet"] then
        game.ReplicatedStorage.RemoteEvent:FireServer({"UpgradeCurrentPet"})
    end
end)
