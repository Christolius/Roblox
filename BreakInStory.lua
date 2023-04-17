local lib = loadstring(game:HttpGet('https://github.com/shlexware/Orion/raw/main/source'))()
plr = game.Players.LocalPlayer
window=lib:MakeWindow({Name = "Break In (Story)", HidePremium = true, SaveConfig = true, ConfigFolder = "CHUB",IntroText='Break In (Story)'})
tab=window:MakeTab({Name = 'Server Side'})
igf = tab:AddSection({Name='Item Giver'})
function error(msg,time)
	lib:MakeNotification({
	Name = "ERROR",
	Content = tostring(msg),
	Image = "",
	Time = time
})	
end
function info(msg,time)
	lib:MakeNotification({
	Name = "INFO",
	Content = tostring(msg),
	Image = "",
	Time = time
})	
end
selc = 'Apple'
opt = {}
for i,v in pairs(game.Workspace.ShopItems:GetChildren()) do
	table.insert(opt, v.Name)
end
table.insert(opt,'LinkedSword')
table.insert(opt, 'Plank')
items = tab:AddDropdown({
	Name = "Select Item",
	Default = "Apple",
	Options = opt,
	Callback = function(Value)
		selc = Value
	end    
})
hmng = 1
igf:AddTextbox({
	Name = "Amount",
	Default = "1",
	TextDisappear = false,
	Callback = function(val)
		if tonumber(val) then
			hmng = tonumber(val)
		else
			error("Amount must be a number.",5)
		end
	end	  
})
igf:AddButton({
	Name = "Give Item(s)",
	Callback = function ()
	for i=1,hmng do
		wait()	
		game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("GiveTool"):FireServer(selc)
	end
		info("Gave you ".. tostring(hmng)..' '..selc..'(s).',1)
	end
})
ents = tab:AddSection({Name='Entities'})
ents:AddButton({Name='Hit All BadGuys (Must be near the entity.)',
	Callback = function ()
		for i,v in pairs(game.Workspace.BadGuys:GetChildren()) do
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("HitBadguy"):FireServer(v,10)
		end
	end
})
plrs = tab:AddSection({Name='Player'})
plrs:AddTextbox({
	Name = 'WalkSpeed';
	Default = 16;
	TextDisappear = false;
	Callback = function (v)
		if tonumber(v) then
			plr.Character.Humanoid.WalkSpeed = math.round(tonumber(v))
		else
			error('WalkSpeed must be a number.', 5)
		end
	end
})
plrs:AddTextbox({
	Name = 'JumpPower';
	Default = 16;
	TextDisappear = false;
	Callback = function (v)
		if tonumber(v) then
			plr.Character.Humanoid.JumpPower = math.round(tonumber(v))
		else
			error('JumpPower must be a number.', 5)
		end
	end
})
ih = false
plrs:AddToggle({
	Name = 'Infinite Health (this will annoy the entire server.)',
	Default = false,
	Callback = function(c)
		ih = c
		while ih and wait() do
			a = 'BloxyCola'
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("GiveTool"):FireServer(a)
			lvl = 15
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("Energy"):FireServer(lvl,a)
		end
	end
})