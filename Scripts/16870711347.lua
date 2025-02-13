getgenv().DeposibleOnTop = {
    ["Print Tax Forms"] = false,
    ["Fax Forms"] = false,
    ["Buy Buttons"] = false
}
  
local newtask = function(delay, val, callback)
    task.spawn(function()
        while task.wait(delay) and DeposibleOnTop[val] do
            callback()
        end
    end)
end

newtask(0.25, "Print Tax Forms", function()
    pcall(function() -- Main
        Workspace.Tycoons[tostring(game.Players.LocalPlayer.UserId)].Upgrades.bossDesk.PrintPaper:FireServer(Workspace.Tycoons[game.Players.LocalPlayer.UserId].Upgrades.bossDesk)
        task.wait(0.10)
        fireclickdetector(Workspace.Tycoons[tostring(game.Players.LocalPlayer.UserId)].Upgrades.Computer.Printer.ClickDetector)
    end)

    pcall(function() -- bossdesk
        Workspace.Tycoons[tostring(game.Players.LocalPlayer.UserId)].Upgrades.Computer.PrintPaper:FireServer(Workspace.Tycoons[game.Players.LocalPlayer.UserId].Upgrades.Computer)

        task.wait(0.10)

        fireclickdetector(Workspace.Tycoons[tostring(game.Players.LocalPlayer.UserId)].Upgrades.bossDesk.Printer.ClickDetector)                    
    end)

    pcall(function() -- Worker
        for _, workers in pairs({"worker1", "worker2", "worker3", "worker4", "worker5", "worker6"}) do
            fireclickdetector(Workspace.Tycoons[tostring(game.Players.LocalPlayer.UserId)].Upgrades[workers].Computer.printer1.ClickDetector)
        end
    end)

    pcall(function() -- Business Workers
        for _, cubicals in pairs({ 'cubicle1', 'cubicle2', 'cubicle3', 'cubicle4', 'cubicle5', 'cubicle6', 'cubicle7', 'cubicle8' }) do
            fireclickdetector(Workspace.Tycoons[tostring(game.Players.LocalPlayer.UserId)].Upgrades[cubicals].Computer.printer1.ClickDetector)
        end
    end)
end)
newtask(0.25, "Fax Forms", function()
    pcall(function()
        replicatedstorage.Events.FaxDocuments:FireServer(1, Workspace.Tycoons[game.Players.LocalPlayer.UserId].Upgrades.faxMachine)
    end)
end)
newtask(1, "Buy Buttons", function()
    pcall(function()
        for _, a in pairs(Workspace.Tycoons[tostring(game.Players.LocalPlayer.UserId)].Buttons:GetChildren()) do
            if a:FindFirstChild('button').Color ~= Color3.fromRGB(103, 0, 0) and a:FindFirstChild('button').Color ~= Color3.fromRGB(158, 131, 0) then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, a:FindFirstChild('button'), 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, a:FindFirstChild('button'), 1)

                task.wait(0.50)
            end
        end
    end)
end)
