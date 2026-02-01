--[[
    use: print(a.Name) -- inside of it in order to view locations you can go to!
    for i, a in pairs(workspace.Ambient:GetChildren()) do
        print(a.Name)
        if a.Name == "" then -- Insert the location you wanna teleport to (the name that you get from the print)
            LocalPlayer.Character.HumanoidRootPart.CFrame = a:FindFirstChild('Union').CFrame * CFrame.new(0, 50, 0)
        end
    end

]]

getgenv().Settings = {
    AutoSell = true,
    AutoSwing = true,
    AutoSpinWheel = true,
    AutoBuyScythes = true,
    AutoBuyClasses = true,
    CandyCanesStats = false, -- added since you can still learn since they dont have an actual tracker for it but the update shouldve been removed by them by now (its literally love month.)
    KillWeakerPlayers = false, -- Basically troll  tf outta peeps
    FarmKOH = false,  -- these 2 turn eachother off. so only CHOOSE 1! this prevents them from causing issues.
    FarmBoss = false, -- these 2 turn eachother off. so only CHOOSE 1! this prevents them from causing issues.
    BossesToFarm = {}, -- ONLY COPY THE SECOND THING example of table: {"BossBase1", "BossBase2"} --{{"Area 1", "BossBase1"}, {"Area 2", "BossBase2"}, {"Area 3", "BossBase3"}, {"Area 4", "BossBase4"}, {"Area 5", "BossBase5"}, {"Santa", "XmasBoss1"}, {"Elf", "XmasBoss2"}, {"krampus", "XmasBoss3"}}
    FarmBestLocation = false
}

if Settings["FarmKOH"] then Settings["FarmBoss"] = false end
if AlreadyRan then return end getgenv().AlreadyRan = true

local LocalPlayer = game.Players.LocalPlayer

local Loop = function(Delay, func)
    task.spawn(function()
        while task.wait(Delay) do
            pcall(func)
        end
    end)
end
local Classes = function()
    local Total = 0

    for _, a in pairs(LocalPlayer.PlayerGui.MainUI.Frames.ClassShopFrame.ScrollingFrame:GetChildren()) do
        if a.Name == "ClassSlot" and not a.Lock.Visible then
            Total += 1
        end
    end

    return Total
end

Loop(0.25, function()
    if Settings["AutoSwing"] then
        LocalPlayer.Character:FindFirstChildWhichIsA('Tool'):Activate() -- Since each scythes name changes this is the SIMPLEST way.
    end
end)
Loop(1, function()
    local Class = Classes() - 1

    if Settings["CandyCanesStats"] then
        print(LocalPlayer:FindFirstChild('Data'):FindFirstChild('Events'):FindFirstChild('XMAS'):FindFirstChild('CandyCanes') and LocalPlayer:FindFirstChild('Data'):FindFirstChild('Events'):FindFirstChild('XMAS'):FindFirstChild('CandyCanes').Value)
    end
    if Settings["AutoSell"] then
        game.ReplicatedStorage.Remotes.BankSell:FireServer()
    end
    if Settings["AutoSpinWheel"] then
        firesignal(LocalPlayer.PlayerGui.MainUI.Frames.WheelFrame.SpinButton.MouseButton1Click)
    end
    if Settings["AutoBuyScythes"] and LocalPlayer.PlayerGui.MainUI.ProgressBar.Visible and LocalPlayer.PlayerGui.MainUI.ProgressBar.Percentage.Text == "100%" then
        game.ReplicatedStorage.Remotes.ScytheEquip:FireServer(-1)
    end
    if Settings["AutoBuyClasses"] then
        game.ReplicatedStorage.Remotes.ClassEquip:FireServer(Classes() - 1)
    end
end)
Loop(1, function()
    local Class = Classes() - 1

    if Settings["KillWeakerPlayers"] then
        for _, a in pairs(game.Players:GetPlayers()) do
            if not a.Data.SafeArea.Value and LocalPlayer.Data.Souls.Value > a.Data.Souls.Value then
                repeat
                    task.wait()

                    LocalPlayer.Character.HumanoidRootPart.CFrame = a.Character.HumanoidRootPart.CFrame
                    LocalPlayer.Character:FindFirstChildWhichIsA('Tool'):Activate()
                until not a or not a.Character or not a.Character:FindFirstChild('Humanoid') or a.Character.Humanoid.Health <= 0 or not A5:Status()
            end
        end
    end
    if Settings["FarmKOH"] then
        LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["KingOfHill_"..LocalPlayer.Data.Area.Value].Model.Hill.CFrame * CFrame.new(0, 2, 0)
    end
    if Settings["FarmBoss"] then
        for _, a in pairs(BossesToFarm) do
            if workspace.Arena.Boss:FindFirstChild(a) then
                repeat
                    task.wait(0.25)

                    LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Arena.Boss:FindFirstChild(a).PrimaryPart.CFrame * CFrame.new(0, -4, 0)
                until Settings["FarmBoss"] or not workspace.Arena.Boss:FindFirstChild(a) 
            end
        end
    end
    if Settings["FarmBestLocation"] then
        if Class >= 34 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-118.68685913085938, 37.246131896972656, 20143.2265625)
        elseif Class >= 32 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(153.4252471923828, 8.334108352661133, 19854.828125)
        elseif Class >= 28 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-197.787918, 71.9431229, 15197.8418)
        elseif Class >= 24 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139.226776, 4.71425295, 14858.7949)
        elseif Class >= 19 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-165.222778, 53.4459305, 10170.9912)
        elseif Class >= 17 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(150.811356, 8.75764465, 9838.55859)
        elseif Class >= 12 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-186.192734, 63.7264099, 5181.24854)
        elseif Class >= 10 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(82.1897736, 3.95924377, 4838.37109)
        elseif Class >= 6 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-176.422775, 60.9101715, 172.747482)
        elseif Class >= 5 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(132.468567, 3.95922136, -132.26355)
        end
    end
end)
