local SolarisLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/itzOgic/Roblox/main/SolarisLib.lua")()
Instance.new("Folder",Workspace).Name = "APET"
local player = game.Players.LocalPlayer
local statFolder,Filtered
local WeightVal,DelayVal = 100, 0.8
local fishDone = {}
local MutList = {"Aurora", "Mythical", "Midas", "Ghastly", "Sinister", "Mosaic", "Electric", "Glossy", "Silver", "Darkened", "Translucent", "Frozen", "Albino", "Negative"}
local win = SolarisLib:New({
  	Name = "Fisch Auto Appraise by Toto",
  	FolderToSave = "SolarisLibStuff"
})

local tab = win:Tab("Auto Appraise")
local sec = tab:Section("Menu")

local function hasValue(tab, val)
	for index, value in next, tab do		
		if val == value then return true end
	end
	return false
end

local function getallOwnedFish()
	local OwnedList = {}
	for i, fish in next, player.Backpack:GetChildren() do
		if not hasValue(OwnedList,fish.Name) and fish:FindFirstChild("Fish") then
			table.insert(OwnedList, fish.Name)
		end
	end
	return OwnedList
end

local allOwnedFish = getallOwnedFish()
local AutoToggle = sec:Toggle("Auto Appraise Toggle", false, "AutoToggle", function() end)
local AppraiseAll = sec:Toggle("Appraise all Selected Fish", false, "AppraiseAll", function() end)
local FishSelection = sec:MultiDropdown("Selected Fish", allOwnedFish, {},"FishSelection", function() end)
local AppraiseDelay = sec:Textbox("Appraise Delay", false, function(t) DelayVal = t end)
local WeightToggle = sec:Toggle("Weight Filter Toggle", false, "WeightToggle", function() end)
local WeightBox = sec:Textbox("Weight Target", false, function(t) WeightVal = t; fishDone = {} end)
local SparklingToggle = sec:Toggle("Require Sparkling", false, "SparklingToggle", function() fishDone = {} end)
local ShinyToggle = sec:Toggle("Require Shiny", false, "ShinyToggle", function() fishDone = {} end)
local MutationToggle = sec:Toggle("Mutation Toggle", false, "MutationToggle", function() end)
local MutationList = sec:MultiDropdown("Mutation Target", MutList, {"Glossy" ,"Ghastly"},"MutationList", function() fishDone = {} end)
WeightBox:Set("100")
AppraiseDelay:Set("0.8")

local function switchFish()
	for i,fish in next, player.Backpack:GetChildren() do
		if hasValue(FishSelection.Value,fish.Name) and not hasValue(fishDone,fish) then
			player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(fish)
			return
		end
	end
end

local function getHeldFish()
	for i,v in next, player.Character:GetChildren() do
		if v:isA("Tool") then 
			return v 
		end
	end
	return nil
end

player.Backpack.ChildAdded:Connect(function(instance)
	if instance:isA("Tool") and not instance:FindFirstChild("link") then
		repeat task.wait() until instance:FindFirstChild("link")
		local oldtools = getHeldFish()
		if oldtools then oldtools.Parent = player.Backpack end
		if AutoToggle then
			player.PlayerGui.hud.safezone.backpack.events.equip:FireServer(instance)
		end
	end
end)

local function applyFilter(statFolder)
	local t = true
	if WeightToggle.Value and statFolder.Weight.Value < tonumber(WeightVal) then
		t = false
	end
	if SparklingToggle.Value and not statFolder:FindFirstChild("Sparkling") then
		t = false
	end
	if ShinyToggle.Value and not statFolder:FindFirstChild("Shiny") then
		t = false
	end
	if MutationToggle.Value then
		local Mutation = statFolder:FindFirstChild("Mutation")
		if not Mutation then t = false end
		if not hasValue(MutationList.Value, Mutation.Value) then
			t = false
		end
	end
	return t
end

local function AutoAppraise()
	if not AutoToggle.Value then return end
	local fish = getHeldFish()
	if fish then
		statFolder = fish.link.Value
		Filtered = applyFilter(statFolder)
		if Filtered then 
			if AppraiseAll.Value and not hasValue(fishDone,fish) then
				table.insert(fishDone,fish)
				switchFish()
			end
			return
		end
		workspace.world.npcs.Appraiser.appraiser.appraise:InvokeServer()
		task.wait(tonumber(DelayVal))
	elseif not fish and AppraiseAll.Value then
		switchFish()
	end
end

while task.wait() and game.Workspace:FindFirstChild("APET") do
	AutoAppraise()
end
