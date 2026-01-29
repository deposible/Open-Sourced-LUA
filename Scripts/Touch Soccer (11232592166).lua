getgenv().Settings = {
  SpeedCheats = false,
  WantedSpeed = 16,
  AutoWalkToBall = false
}

if not AlreadyRan then return end
getgenv().AlreadyRan = true

task.spawn(function()
    while task.wait() do
        if Settings.SpeedCheats then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Settings.WantedSpeed
        end
        if Settings.AutoWalkToBall then
            local Ball = workspace.FootballField:FindFirstChild('SoccerBall')

            game.Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(Ball.X, game.Players.LocalPlayer.Character.PrimaryPart.Position.Y, Ball.Z))
        end
    end
end)

local o; o = hookmetamethod(game, '__namecall', function(self, ...)
    local Args = {...}

    if Settings.SpeedCheats and self.Name == "UpdateWalkSpeed" and getnamecallmethod() == "FireServer" then
        Args[2] = Settings.WantedSpeed
        
        return o(self, unpack(Args))
    end
    
    return o(self, ...)
end)
