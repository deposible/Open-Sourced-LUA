-- Works for: 16436007861 [Main], 17678973277 [World1?], 17678973620 [World2?], 17678973875 [World3?], 17678974142 [World4?]
getgenv().DeposibleOnTop = {
    ["Forgot :Skull:"] = true, -- recommended not to turn off because i forgot what EXACTLY this is supposed to do
    ["Kill Aura"] = false,
    ["Equip Best Weapon"] = false,
    ["Equip Best Pets"] = false,
    ["Farm Zones"] = false,
    ["Auto Defense"] = false,
    ["Auto Damage"] = false,
    ["Auto Speed"] = false,
    ["Auto Luck"] = false,
    ["Claim Online Gifts"] = false,
    ["Daily Gifts"] = false,
    ["Claim Season Rewards"] = false,
    ["Auto Spin Wheel"] = false,
    ["Auto Rebirth"] = false,
    ["Auto Open Eggs"] = false,
    ["Egg Number"] = 17 -- this could be alot better but these are just translations of my old scripting skills :Skull:
}



local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end

newtask(0.1, "Forgot :Skull:", function()
    game:GetService('ReplicatedStorage').Remotes.Common.Teleport.InputBegin:FireServer()
end)
newtask(0, "Kill Aura", function()
    pcall(function()
        game:GetService('ReplicatedStorage').Remotes.Weapon.TakeDamage:FireServer()
    end)
end)
newtask(30, "Equip Best Weapon", function()
    game:GetService('ReplicatedStorage').Remotes.Weapon.EquipBest:FireServer()
end)
newtask(1, "Equip Best Parts", function()
    pcall(function()
        game:GetService('ReplicatedStorage').Remotes.Common.Pet.EquipBest:FireServer()
    end)
end)
newtask(0, "Farm Zones", function()
    pcall(function()
        if string.find(game.Players.LocalPlayer.stats.SynRegion.Value, 'Lobby') then
            game:GetService('ReplicatedStorage').Remotes.Match.Join:InvokeServer(tonumber(string.sub(game.Players.LocalPlayer.stats.SynRegion.Value, 6)))

            task.wait(10)
        else
            local BattleField = string.sub(game.Players.LocalPlayer.stats.SynRegion.Value, 7)

            for _, a in pairs(Workspace.Battle[BattleField].Enemy:GetChildren()) do
                pcall(function()
                    repeat
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)

                        task.wait()
                    until a.Humanoid.Health <= 0
                end)
            end
        end
    end)
end)

newtask(0.1, "Auto Defense", function()
    pcall(function()
        game:GetService('ReplicatedStorage').Remotes.Profile.AddPoint:FireServer('Defense', 1)
    end)
end)
newtask(0.1, "Auto Damage", function()
    pcall(function()
        game:GetService('ReplicatedStorage').Remotes.Profile.AddPoint:FireServer('Damage', 1)
    end)
end)
newtask(0.1, "Auto Speed", function()
    pcall(function()
        game:GetService('ReplicatedStorage').Remotes.Profile.AddPoint:FireServer('Speed', 1)
    end)
end)
newtask(0.1, "Auto Luck", function()
    pcall(function()
        game:GetService('ReplicatedStorage').Remotes.Profile.AddPoint:FireServer('Luck', 1)
    end)
end)

newtask(5, "Claim Online Gifts", function()
    pcall(function()
        for i = 1, 8 do
            game:GetService('ReplicatedStorage').Remotes.Common.Online.TryGetOnlineGift:InvokeServer(i)
        end
    end)
end)
newtask(5, "Daily Gifts", function()
    pcall(function()
        for i = 1, 7 do
            game:GetService('ReplicatedStorage').Remotes.Common.Reward.DailyReward:InvokeServer(i)
        end
    end)
end)
newtask(5, "Claim Season Rewards", function()
    pcall(function()
        for i = 1, 20 do
            game:GetService('ReplicatedStorage').Remotes.Common.Season.GetReward:FireServer('Free', i)
        end
    end)
end)
newtask(2, "Auto Spin Wheel", function()
    pcall(function()
        game:GetService('ReplicatedStorage').Remotes.Common.Spin.TrySpin:InvokeServer()
    end)
end)
newtask(1, "Auto Rebirth", function()
    game:GetService('ReplicatedStorage').Remotes.Profile.RebirthRequest:InvokeServer()
end)
newtask(0.25, "Auto Open Eggs", function()
    pcall(function()
        game:GetService('ReplicatedStorage').Remotes.Common.Hatch.EggHatch:InvokeServer(Deposible["Egg Number"], "1", {})
    end)
end)
