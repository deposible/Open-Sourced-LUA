game:GetService('RunService').Heartbeat:Connect(function()
    for _, Servers in next, {ScriptContext.Error, LogService.MessageOut} do
        for _, Connections in next, getconnections(Servers) do
            Connections:Disable()
        end
    end
end)
