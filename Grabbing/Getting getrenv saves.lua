-- this will save evertything that is in the getrenv (roblox environment) Used to be for Murder Mystery 2 but im pretty sure they removed everything from _G. youll have to see tho.
local Data = {}

local suc, res = pcall(function()
    return readfile("getrenv.json")
end)

if not suc then
    writefile("getrenv.json", "{}")
end

for i, a in next, getrenv()._G do
    pcall(function()
        Data[i] = a
    end)
end

setclipboard(tostring(Data))
writefile("getrenv.json", game:GetService('HttpService'):JSONEncode(Data))

--Saving children
local Data = {}

local suc, res = pcall(function()
    return readfile("Children.json")
end)

if not suc then
    writefile("Children.json", "{}")
end

for i, a in next,  game:GetService('Workspace').Ignored.Shop:GetChildren() do
    pcall(function()
        Data[i] = a
    end)
end

writefile("Children.json", game:GetService('HttpService'):JSONEncode(Data))
