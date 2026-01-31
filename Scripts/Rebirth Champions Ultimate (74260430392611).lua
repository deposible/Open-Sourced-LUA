--[[
    Yet another goated release of open sourced recoded by deposible. yes yes yes i am THE guy.

    Forever R.I.P - V.G Hub (the most goated open sourced script. possibly the BEST place to learn)
]]

getgenv().Settings = {
    AutoClick = true,
    AutoBESTRebirth = true,
    RebirthDelay = 0.1, -- 0.01 -> 30 can always do different numbers just what i had in my script. just depends on what rebirth your trying to go to
    AutoOpenEggs = false, -- YOU NEED TO BE NEXT TO THE EGG IN ORDER FOR THIS TO WORK
    EggType = "Open1" -- or Open3
}

local LocalPlayer = game.Players.LocalPlayer
local Modules = {}

for i, a in pairs(game.ReplicatedStorage:GetDescendants()) do
    if a:IsA('ModuleScript') then
        task.spawn(function()
            pcall(function() Modules[a.Name] = require(a) end)
        end)
    end
end

local Loop = function(delay, func)
    taks.spawn(function()
        while task.wait(delay) do
            pcall(func)
        end
    end)
end

Loop(0.1, function() -- check the module before making it any faster. they could add detections if you go to fast.
    if Settings["AutoClick"] then
        Modules["ClickController"].doClick()
    end
end)
Loop(0.01, function()
    if Settings["AutoBESTRebirth"] then
         if not LocalPlayer.PlayerGui.MainUI.Menus.RebirthFrame.Visible then
            firesignal(LocalPlayer.PlayerGui.MainUI.HUD.Bars.Left.Row2.Rebirth.Main.Click.MouseButton1Down)
            firesignal(LocalPlayer.PlayerGui.MainUI.HUD.Bars.Left.Row2.Rebirth.Main.Click.MouseButton1Up)
            
            task.wait(1)
        else
            local Max, Part = 0, false

            for _, a in pairs(LocalPlayer.PlayerGui.MainUI.Menus.RebirthFrame.Main.List.Holder.Rebirths:GetChildren()) do
                if a:IsA('Frame') and tonumber(a.Name) and not a.Main.Locked.Visible and tonumber(a.Name) > Max then
                    Max = tonumber(a.Name)
                    Part = a.Main.Click
                end
            end

            if Max > 0 then
                firesignal(Part.MouseButton1Down)
                firesignal(Part.MouseButton1Up)
            end

            task.wait(Settings["RebirthDelay"])
        end
    end
end)
Loop(0.25, function()
    if Settings["AutoOpenEggs"] then
        if LocalPlayer.PlayerGui.MainUI.Menus.EggDisplayFrame.Visible then
            firesignal(LocalPlayer.PlayerGui.MainUI.Menus.EggDisplayFrame.Main.Buttons[Settings["EggType"]].Click.MouseButton1Down)
            firesignal(LocalPlayer.PlayerGui.MainUI.Menus.EggDisplayFrame.Main.Buttons[Settings["EggType"]].Click.MouseButton1Up)
        end
    end 
end)
