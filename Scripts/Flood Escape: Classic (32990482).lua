getgenv().Settings = {
    ["Instant Win"] = true,
    ["Auto Join Game"] = false,
    ["Difficulty To Join"] = "Easy" --"Easy" or "Medium" or "Hard"
}

if ReExec then return else getgenv().ReExec = true end

local LocalPlayer = game.Players.LocalPlayer

local Win = function()
    for _, a in pairs({"Easy", "Medium", "Hard"}) do
        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, workspace[a].Main.Exit, 0)
        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, workspace[a].Main.Exit, 1)
    end
end
local loop = function(del, func)
    task.spawn(function()
        while task.wait(del) do
            pcall(func)
        end
    end)
end

loop(0.1, function()
    if Settings["Auto Join Game"] then
        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, workspace[Settings["Difficulty To Join"]].Entry.LiftEntryInfo, 0)
        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, workspace[Settings["Difficulty To Join"]].Entry.LiftEntryInfo, 1)
        
        repeat task.wait(0.1) until LocalPlayer.Ingame.Value ~= 0 or LocalPlayer.Waiting.Value ~= 0
        repeat task.wait(0.1) until LocalPlayer.Ingame.Value == 0
    end
end)
loop(0.25, function()
    if Settings["Instant Win"] then
        Win()
    end
end)
