--[[
    Recoded all this myself so itll work. no chatgpt as it produces absolutely shit coding... This version will allow actual learning for you and teach you things you SHOULD be doing.
    Some examples would be minimizing. this introduces stability, easy to change etc...

    Main Game (just the auto join game) 7606564092
    Actual Playing (All Features) 7606602544
    Secondary Source as well (88604154038333) 

    THEIR IS NO CODE FOR THE TWEEN AS MY METHOD IS UNIQUE. MAKE YOUR OWN or request chatgpt you skid...

    Did NOT add autofight as it has a ton of custom functions that i wont be sharing

    did NOT share the code for EquipTool find your own method.
]]
getgenv().Settings = {
    AutoJoinGame = true,
    AutoPlayGames = true,
    GlassBridgeAntiDeath = true,
    AutoFight = false,
    AutoEatHoneycomb = false,
    HoneyCombEatAt = 50, -- When your health is between 15->100 (dont do 0 cause youd be dead by then) just leave it alone
    InfiniteStamina = true,
    AutoSkipCutscene = true,
    BuyPush = true, -- id say keep this off because theirs no checks to see if you already have it or if you have enough money.
    BuyGlassTester = true, -- id say keep this off because theirs no checks to see if you already have it or if you have enough money.
    BuySandGrabber = true -- id say keep this off because theirs no checks to see if you already have it or if you have enough money.
}

if AlreadyRan then return end getgenv().AlreadyRan = true

local Loop = function(Delay, func)
    task.spawn(function() -- prevents hard bricks (if you just use while alone it will not run ANYTHING else below it. [until it ends or errors]) 
        while task.wait(Delay) do -- continously continue with a set delay for yall
            pcall(func) -- if any errors occur itll just instant stop it BUT continue everything
        end
    end)
end
local Attribute = function(Part, Attribute)
    local success, atr = pcall(function()
        return Part:GetAttribute(Attribute)
    end)

    return success and atr or false
end
local firetouchinterest = function(a, b, OP) -- literally a fixed firetouchinterest since most executors are dipshits and dont understand how to fix their own shit. [Literally skid this executors it fixes your issues]
    if OP then
        firetouchinterest(a, b, OP)
    else
        firetouchinterest(a, b, 1)
        firetouchinterest(a, b, 0)
    end
end
local EquipTool = function(toolname)
    
end

local WIRE = {
    Click = function(t)
        sgame.VirtualInputManager:SendMouseButtonEvent(1, 1, 0, true, nil, 0)
        task.wait(0.01)
        sgame.VirtualInputManager:SendMouseButtonEvent(1, 1, 0, false, nil, 0)
    end,
    Tween = function(delay, position)

    end
} -- not the full custom function but edited versions (not giving my op versions that are UD ;) )

local LocalPlayer = game.Players.LocalPlayer -- DO NOT define the character of the user. because if it deletes or dies itll just error the entire script. that is a clear sign someone uses chatgpt to generate their actual code. please dont be a skid. i made this so you can actually learn.
local VirtualManager = game:GetService('VirtualInputManager') -- you SHOULD wrap this in a cloneref but :shrug: -- dont have emojis on KB&M :sad:
local replicatedstorage = game:GetService("ReplicatedStorage")
if game.PlaceId == 7606564092 then
    Loop(5, function()
        if Settings["AutoJoinGame"] then
            LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.lobby.regular.gameQueue["UI-andBeams"].CFrame
        end
    end)
else
    local Modules = {}
  
    for i, a in pairs(LocalPlayer.PlayerScripts:GetDescendants()) do
        if a:IsA('ModuleScript') then
            task.spawn(function() apcall(function() Modules[a.Name] = require(a) end) end) -- Loads all the users Modules. This is so its easier to reference SPECIFIC modules.
        end
    end
  
    local GrabTrack = function()
        local Track, Dist = nil, math.huge
    
        for i, a in pairs(workspace.Maps.Pentathlon.irregular.Tracks:GetChildren()) do
            if a:FindFirstChild('Collider') and (LocalPlayer.Character.HumanoidRootPart.Position - a.Collider.Position).Magnitude < Dist then
                Dist = (LocalPlayer.Character.HumanoidRootPart.Position - a.Collider.Position).Magnitude
                Track = a
            end
        end
    
        return Track
    end -- Since theirs 2 versions the easiest method is just grabbing the distance of your character to the nearest track. and that is 99% of the time YOUR track
    local NearestPlayer = function()
        local Nearest, NearestDist = nil, math.huge
    
        for _, a in pairs(players:GetPlayers()) do
            if a ~= LocalPlayer and a.Character and a.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - a.Character.HumanoidRootPart.Position).Magnitude < NearestDist then
                Nearest = a
                NearestDist = (LocalPlayer.Character.HumanoidRootPart.Position - a.Character.HumanoidRootPart.Position).Magnitude
            end
        end
    
        return Nearest
    end -- Pretty simple stuff just another distance thing
    
    Loop(5, function()
        if Settings["AutoPlayGames"] then
            repeat task.wait(0.50) until Attribute(game.Players, 'Countdown') > 0
  
            local Game = Attribute(game.Players, "CurrentGame")
        
            if Game == "Red Light, Green Light" then
                repeat 
                    task.wait(0.1)
        
                    if LocalPlayer.PlayerGui.HUD.Intermission.Status.DropShadow.ImageColor3 ~= Color3.fromRGB(153, 29, 31) then
                        VirtualManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
        
                        LocalPlayer.Character.Humanoid:MoveTo(workspace.Maps["Red Light, Green Light"].regular.barriers.finishBarrier.CFrame.Position)
                    else
                        LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.CFrame.Position)
                    end
                until Attribute(game.Players, "CurrentGame") ~= "Red Light, Green Light"
            elseif Game == "Dalgona" then
                repeat task.wait(1) until workspace.Camera:FindFirstChild('Needle')
                
                Modules["DalgonaCutter"].End({Data = Modules["DalgonaCutter"].Data, Lighter = false}, "Success")
            elseif Game == "Pentathlon" then
                local Track = GrabTrack()
        
                task.wait(35)
                
                for i = 1, 5 do
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Track.EventTriggers.Game1)
                    task.wait(0.5)
                end
        
                task.spawn(function()
                    repeat task.wait(0.1) until LocalPlayer.PlayerGui.Pentathlon.Ddakji.Visible
                    
                    Modules["Ddakji"].End("Success")
        
                    for i = 1, 5 do
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Track.EventTriggers.Game2)
                        task.wait(0.25)
                    end
                end)
                task.spawn(function()
                    repeat task.wait(0.1) until LocalPlayer.PlayerGui.Pentathlon.Biseokchigi.Visible
        
                    Modules["Biseokchigi"].End("Success")
        
                    for i = 1, 5 do
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Track.EventTriggers.Game3)
                        task.wait(0.5)
                    end
                end)
                task.spawn(function()
                    repeat task.wait(0.1) until LocalPlayer.PlayerGui.Pentathlon.Gonggi.Visible
        
                    repeat 
                        task.wait()
        
                        if LocalPlayer.PlayerGui.Pentathlon.Gonggi.Timer.Bar.Line.Position.X.Scale >= LocalPlayer.PlayerGui.Pentathlon.Gonggi.Timer.Bar.Objective.Position.X.Scale then
                            WIRE.Click({version = 0})
                        end
                    until not LocalPlayer.PlayerGui.Pentathlon.Gonggi.Visible
        
                    for i = 1, 5 do
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Track.EventTriggers.Game4)
                        task.wait(0.5)
                    end
                end)
                task.spawn(function()
                    repeat task.wait(0.1) until LocalPlayer.PlayerGui.Pentathlon.Paengi.Visible
        
                    --Modules["Paengi"].End("Success")
                    WIRE.Click({delay = 1})
        
                    repeat task.wait(1) until not LocalPlayer.PlayerGui.Pentathlon.Paengi.Visible
                    
                    for i = 1, 5 do
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Track.EventTriggers.Game5)
                        task.wait(0.5)
                    end
                end)
                task.spawn(function()
                    repeat task.wait(0.1) until LocalPlayer.PlayerGui.Pentathlon.Jegi.Visible
        
                    repeat 
                        task.wait(0.1)
        
                        if LocalPlayer.PlayerGui.Pentathlon.Jegi.Main.Circle.Inner.Size.X.Scale <= LocalPlayer.PlayerGui.Pentathlon.Jegi.Main.Circle.Objective.Size.X.Scale then
                            WIRE.Click({version = 0})
                        end
                    until not LocalPlayer.PlayerGui.Pentathlon.Jegi.Visible
        
                    for i = 1, 5 do
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Track.EventTriggers.End)
                        task.wait(0.25)
                    end
                end)
            elseif Game == "Jump Rope" then
                task.wait(35)
        
                if workspace.Maps["Jump Rope"].RopeEdit then
                    workspace.Maps["Jump Rope"].RopeEdit:Destroy()
                end
                
                WIRE.Tween(5, workspace.Maps["Jump Rope"].FlowerBed.CFrame.Position)
            elseif Game == "Glass Stepping Stones" then
                for _, a in pairs(workspace.Maps["Stepping Stones"].Main.Tiles:GetDescendants()) do
                    if a:IsA('TouchInterest') then
                        a:Destroy()
                    end
                end
        
                workspace.Maps["Stepping Stones"].Main.KillZone:Destroy()
        
                WIRE.Tween(10, workspace.Maps["Stepping Stones"].End.Build.FinishZone.CFrame.Position)
            end
        
            repeat task.wait() until Attribute(game.Players, "CurrentGame") ~= Game
        end
    end)
    Loop(1, function()
        if Settings["GlassBridgeAntiDeath"] then
            if workspace.Maps:FindFirstChild("Stepping Stones") then
                for _, a in pairs(workspace.Maps["Stepping Stones"].Main.Tiles:GetDescendants()) do
                    if a:IsA('TouchInterest') then
                        a:Destroy()
                    end
                end
            end
        end
    end)
    Loop(1, function()
        if Settings["AutoEatHoneycomb"] then
            if LocalPlayer.Character.Humanoid.Health <= Settings["HoneyCombEatAt"] then
                EquipTool('Honeycomb')
                WIRE.Click({})
            end
        end
    end)
    Loop(0.1, function()
        if Settings["InfiniteStamina"] then
            Modules["StaminaHandler"].Stamina = 999 -- dont even really need this with the method bellow :skull:
            Modules["StaminaHandler"].UseStamina = function() return false end -- makes it literally not use your stamina :skull: worst system ive seen yet
        end
    end)
    Loop(5, function()
        if Settings["AutoSkipCutscene"] then
            replicatedstorage.Shared.Common.Network.Communication.NetworkEvent.SkipCutscene:FireServer(buffer.fromstring(""))
        end
        if Settings["BuyPush"] then
            replicatedstorage.Shared.Common.Network.Communication.NetworkEvent.StoreEvent:FireServer(buffer.fromstring('\004\000Push\a\000BuyItem'))
        end
        if Settings["BuyGlassTester"] then
            replicatedstorage.Shared.Common.Network.Communication.NetworkEvent.StoreEvent:FireServer(buffer.fromstring('\004\000Glass Tester\a\000BuyItem'))
        end
        if Settings["BuySandGrabber"] then
            replicatedstorage.Shared.Common.Network.Communication.NetworkEvent.StoreEvent:FireServer(buffer.fromstring('\004\000Sand\a\000BuyItem'))
        end
    end)
end
