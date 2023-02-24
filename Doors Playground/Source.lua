local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/UI-Libraries/main/Vynixius/Source.lua"))()
local ACC = false
-- Create Window
local Window = Library:AddWindow({
	title = {"Christolius's UI", "Doors Playground Script"},
	theme = {
		Accent = Color3.fromRGB(79,45,35)
	},
	key = Enum.KeyCode.RightControl,
	default = true
})

-- Create Tab
local SPWNS = Window:AddTab("Summon", {default = true})

-- Create Section
local LE = SPWNS:AddSection("Local Entities", {default = false})
local JS = SPWNS:AddSection("Jumpscares", {default = false})
local ACH = SPWNS:AddSection("Achievement", {default = false})

v49 = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator
v59 = v49.Main_Game.SpiderJumpscare

i = 1
iach = 1
sel = "Spider"
selj = "Rush"
selach = "SurviveFigureLibrary"
nms={}
for i,v in pairs(require(game.ReplicatedStorage.Achievements)) do
	nms[i] = i
end
wait(0.1)
table.sort(nms, function(a,b)
	return a:lower() < b:lower()
end)
local rp = LE:AddBox("Amount", {fireonempty = true}, function(text)
	if type(tonumber(text)) == "number" then
		i = tonumber(text)
	elseif text == nil or text == "" then
		i = 1	
	end
end)
local rp = ACH:AddBox("Amount", {fireonempty = true}, function(text)
	if type(tonumber(text)) == "number" then
		iach = tonumber(text)
	elseif text == nil or text == "" then
		iach = 1	
	end
end)
local Dropdown = LE:AddDropdown("Select", {"A-90","Glitch","Halt","Seek","Screech","Timothy","Void"}, {default = "A-90"}, function(selected)
	sel = selected
end)
local Dropdown = JS:AddDropdown("Select", {"Ambush","Rush"}, {default = "Ambush"}, function(selected)
	selj = selected
end)
local Dropdown = ACH:AddDropdown("Select", nms, {default = "SurviveFigureLibrary"}, function(selected)
	selach = selected
end)
local strt = LE:AddButton("Summon", function()
	local func
	if sel == "Timothy" then
		func = 	require(v59)
	elseif sel == "Void" then
		func = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Void).stuff
	elseif sel == "Screech" then
		func = require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Screech)
	elseif sel == "Glitch" then
		func = require(v49.Main_Game.Glitch).stuff
	elseif sel == "A-90" then
		func = require(v49.Main_Game.A90)
	elseif sel == "Halt" then
		func = require(v49.Main_Game.Shade).stuff		
	elseif sel == "Seek" then
		func = require(v49.Main_Game.Seek)		
	end
	idx = i
	repeat
		idx = idx - 1
		spawn(function ()
		if sel ~= "Timothy" then
		func(require(v49.Main_Game), workspace.Halt)	
		else
		func(require(v59.Parent),workspace.Timothy,0.5)
		end
		end)
	until idx == 0
end)
local strtj = JS:AddButton("Summon", function()
		require(v49.Main_Game.Jumpscare)(selj)
end)
local strtach = ACH:AddButton("Get", function()
	dx = iach
	repeat
	spawn(function ()
	if selach ~= nil then
		require(v49.Main_Game.AchievementUnlock)(nil, selach)
	end
		dx = dx - 1
	end)
	until dx == 0
end)
local strtach = ACH:AddButton("GetAll", function()
	for i,v in pairs(require(game.ReplicatedStorage.Achievements)) do
	spawn(function ()
		
	require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.AchievementUnlock)(nil, i)
	end)
end
end)
