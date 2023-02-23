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
local SPWNS = Window:AddTab("Summon", {default = false})

-- Create Section
local LE = SPWNS:AddSection("Local Entities", {default = false})

v49 = game:GetService("Players").totosimamora608.PlayerGui.MainUI.Initiator
v59 = v49.Main_Game.SpiderJumpscare

i = 100
sel = "Spider"
local rp = LE:AddBox("Repeat", {fireonempty = true}, function(text)
	if type(tonumber(text)) == "number" then
		i = tonumber(text)
	elseif text == nil or text == "" then
		i = 1	
	end
end)
local Dropdown = LE:AddDropdown("Select", {"A-90","Glitch","Halt","Screech","Timothy","Void"}, {default = "Item1"}, function(selected)
	sel = selected
end)
local strt = LE:AddButton("Summon", function()
	local func
	if sel == "Timothy" then
		func = 	require(v59)
	elseif sel == "Void" then
		func = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Void).stuff
	elseif sel == "Screech" then
		func = require(game:GetService("Players").totosimamora608.PlayerGui.MainUI.Initiator.Main_Game.Screech)
	elseif sel == "Glitch" then
		func = require(v49.Main_Game.Glitch).stuff
	elseif sel == "A-90" then
		func = require(v49.Main_Game.A90)
	elseif sel == "Halt" then
		func = require(v49.Main_Game.Shade).stuff		
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
