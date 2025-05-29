
local A1, A2, A3, A4, A5, A6, A7
local M1
local T1, T2

local GrabNearestEnemies = function()
    local dist, Closest = math.huge, nil

    for _, a in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
        if (LocalPlayer.Character.HumanoidRootPart.Position - a.HumanoidRootPart.Position).Magnitude < dist and (LocalPlayer.Character.HumanoidRootPart.Position - a.HumanoidRootPart.Position).Magnitude < A3:Value() and a.HealthBar.Main.Bar.Amount.Text ~= "0 HP" then
            dist = (LocalPlayer.Character.HumanoidRootPart.Position - a.HumanoidRootPart.Position).Magnitude
            Closest = a
        end
    end

    if Closest then
        return Closest
    end
end
local GrabNearestTable = function(tbl)
    local dist, Closest = math.huge, nil

    for _, a in pairs(workspace.__Main.__Enemies.Client:GetChildren()) do
        if table.find(tbl, Attribute(a, 'ID')) and (LocalPlayer.Character.HumanoidRootPart.Position - a.HumanoidRootPart.Position).Magnitude < dist and (LocalPlayer.Character.HumanoidRootPart.Position - a.HumanoidRootPart.Position).Magnitude < A3:Value() and a.HealthBar.Main.Bar.Amount.Text ~= "0 HP" then
            dist = (LocalPlayer.Character.HumanoidRootPart.Position - a.HumanoidRootPart.Position).Magnitude
            Closest = a
        end
    end

    if Closest then
        return Closest
    end
end
local Pets = function()
    local pets = {}
    
    for i, a in pairs(workspace.__Main.__Pets[LocalPlayer.UserId]:GetChildren()) do
        pets[a.Name] = Vector3.new(0, 0, 0)
    end

    return pets
end

local Tabs = {
    Auto = Autofarm:Menu('Left', 'Auto Fight'),
    Misc = Autofarm:Menu('Middle', 'Miscellaneous'),
    Teleports = Gameplay:Menu('Left', 'Teleports'),
    Mounts = Gameplay:Menu('Middle', 'Mounts')
}

local Enemies = {
    {"[1] Soondoo", "SL1"}, {"[1] Gonshee", "SL2"}, {"[1] Daek", "SL3"}, {"[1] Longin", "SL4"}, {"[1] Anders", "SL5"}, {"[1] Largalgan", "SL6"}, -- Leveling City
    {"[2] Snake Man", "NR1"}, {"[2] Blossom", "NR2"}, {"[2] Black Crow", "NR3"}, -- Grass Village
    {"[3] Shark Man", "OP1"}, {"[3] Eminel", "OP2"}, {"[3] Light Admiral", "OP3"}, -- Brum Island
    {"[4] Luryu", "BL1"}, {"[4] Fyakuya", "BL2"}, {"[4] Genji", "BL3"}, -- Faceheal Town
    {"[5] Sortudo", "BC1"}, {"[5] Michille", "BC2"}, {"[5] Wind", "BC3"}, -- Lucky Kingdom
    {"[6] Heaven", "CB1"}, {"[6] Zere", "CB2"}, {"[6] Ika", "CB3"}, -- Nipon City
    {"[7] Diablo", "JB1"}, {"[7] Gosuke", "JB2"}, {"[7] Golyne", "JB3"}, -- Mori Town
}
local Bosses = {
    {"[1] Soondoo", "SLB1"}, {"[1] Gonshee", "SLB2"}, {"[1] Daek", "SLB3"}, {"[1] Longin", "SLB4"}, {"[1] Anders", "SLB5"}, {"[1] Largalgan", "SLB6"}, -- Leveling City
    {"[2] Snake Man", "NRB1"}, {"[2] Blossom", "NRB2"}, {"[2] Black Crow", "NRB3"}, -- Grass Village
    {"[3] Shark Man", "OPB1"}, {"[3] Eminel", "OPB2"}, {"[3] Light Admiral", "OPB3"}, -- Brum Island
    {"[4] Luryu", "BLB1"}, {"[4] Fyakuya", "BLB2"}, {"[4] Genji", "BLB3"}, -- Faceheal Town
    {"[5] Sortudo", "BCB1"}, {"[5] Michille", "BCB2"}, {"[5] Wind", "BCB3"}, -- Lucky Kingdom
    {"[6] Heavenwd", "CHB1"}, {"[6] Zere", "CHB2"}, {"[6] Ika", "CHB3"}, -- Nipon City
    {"[7] Diablo", "JBB1"}, {"[7] Gosuke", "JBB2"}, {"[7] Golyne", "JBB3"}, -- Mori Town
}

A1 = Tabs.Auto:CreateToggle({name = "Selected Enemies", toggle = function() A2:SetStatus(false) end})
A2 = Tabs.Auto:CreateToggle({name = "Nearest Enemies", toggle = function() A1:SetStatus(false) end})
A6 = Tabs.Auto:CreateToggle({name = "Farm Bosses"})
A8 = Tabs.Auto:CreateToggle({name = "Auto Destroy"})
A3 = Tabs.Auto:CreateSlider({name = "Max Distance", min = 5, max = 750, start = 250})
A5 = Tabs.Auto:CreateSlider({name = "Tween Speed", min = 20, max = 100, start = 35})
A4 = Tabs.Auto:CreateDropdown({name = "Enemies", table = Enemies, multi = true})
A7 = Tabs.Auto:CreateDropdown({name = "Bosses", table = Bosses, multi = true})

M1 = Tabs.Misc:CreateToggle({name = "Auto Punch", delay = 0.25, callback = function()
    local Enemy = GrabNearestEnemies()

    if Enemy then
        replicatedstorage.BridgeNet2.dataRemoteEvent:FireServer({{
            ["Event"] = "PunchAttack", 
            ["Enemy"] = Enemy.Name
        }, "\4"})
    end
end})

T1 = Tabs.Teleports:CreateButton({name = "Teleport To Location", callback = function()
    if T2:Value() == "World 5" then
        WIRE.TweenTo(10, workspace.__Main.__World[T2:Value()]["black cover"].MainPart.WorldPivot.Position)
    else
        WIRE.TweenTo(10, workspace.__Main.__World[T2:Value()].MainPart.WorldPivot.Position)
    end
end})
T2 = Tabs.Teleports:CreateDropdown({name = "Locations", table = {{"Leveling City", "World 1"}, {"Grass Village", "World 2"}, {"Brum Island", "World 3"}, {"Faceheal Town", "World 4"}, {"Lucky Kingdom", "World 5"}, {"Nipon City", "World 6"}, {"Mori Town", "World 7"}}})

MM1 = Tabs.Mounts:CreateButton({name = "Go To Mount", callback = function()
    if MM2:Value() and MM2:Value() == "Flying" then
        WIRE.TweenTo(10, Vector3.new())
    elseif MM2:Value() and MM2:Value() == "Ground" then
        WIRE.TweenTo(10, Vector3.new())
    else
        WIRE.TweenTo(10, Vector3.new(4825.21973, 29.9423389, -101.407997))
    end
end})
MM2 = Tabs.Mounts:CreateDropdown({name = "Mounts", table = {{"Aquatic"}, {"Flying"}, {"Ground"}}})

WIRE.loop(0.5, function()
    if A1:Status() or A2:Status() or A6:Status() then
        local tblPet = Pets()

        if A6:Status() then
            local Enemy = A7:Value() and GrabNearestTable(A7:Value())

            if Enemy then
                for i, a in pairs(tblPet) do
                    tblPet[i] = Enemy.HumanoidRootPart.Position
                end

                if (Enemy.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 12 then
                    WIRE.TweenTo(((Enemy.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / A5:Value() or 30), Vector3.new(Enemy.HumanoidRootPart.Position.X, Enemy.HumanoidRootPart.Position.Y, Enemy.HumanoidRootPart.Position.Z + 4))
                end

                replicatedstorage.BridgeNet2.dataRemoteEvent:FireServer({{
                    ["PetPos"] = tblPet,
                    ["AttackType"] = "All",
                    ["Event"] = "Attack",
                    ["Enemy"] = Enemy.Name
                }, "\5"})
                
                repeat task.wait() until not Enemy.HealthBar.Enabled

                if A8:Status() then
                    for i = 1, 2 do
                        task.wait(0.15)
                        
                        replicatedstorage.BridgeNet2.dataRemoteEvent:FireServer({{
                            ["Event"] = "EnemyDestroy",
                            ["Enemy"] = Enemy.Name
                        }, "\4"})
                    end
                end
            end
        end
        if A1:Status() or A2:Status() then
            local Enemy = A1:Status() and A4:Value() and GrabNearestTable(A4:Value()) or A2:Status() and GrabNearestEnemies()
            
            if Enemy then
                for i, a in pairs(tblPet) do
                    tblPet[i] = Enemy.HumanoidRootPart.Position
                end

                if (Enemy.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 12 then
                    WIRE.TweenTo(((Enemy.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude / A5:Value() or 30), Vector3.new(Enemy.HumanoidRootPart.Position.X, Enemy.HumanoidRootPart.Position.Y, Enemy.HumanoidRootPart.Position.Z + 4))
                end
                
                replicatedstorage.BridgeNet2.dataRemoteEvent:FireServer({{
                    ["PetPos"] = tblPet,
                    ["AttackType"] = "All",
                    ["Event"] = "Attack",
                    ["Enemy"] = Enemy.Name
                }, "\5"})

                repeat task.wait() until not Enemy.HealthBar.Enabled

                if A8:Status() then
                    for i = 1, 2 do
                        task.wait(0.15)

                        replicatedstorage.BridgeNet2.dataRemoteEvent:FireServer({{
                            ["Event"] = "EnemyDestroy",
                            ["Enemy"] = Enemy.Name
                        }, "\4"})
                    end
                end
            end
        end
    end
end)
