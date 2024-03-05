local DiscordLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/discord"))()

local Part = Instance.new("Part", workspace)
Part.Name = "Running Part"
Part.Position = Vector3.new(0, 1000, 0)
Part.Anchored = true
Part.CanCollide = true
Part.Size = Vector3.new(5, 1, 5)

local Plr = game:GetService("Players").LocalPlayer

local vim = game:GetService("VirtualInputManager")

function GetMurderer()
 for i, v in game:GetService("Players"):GetChildren() do
  if v.Backpack:FindFirstChild"Knife" or v.Character and v.Character:FindFirstChild("Knife") then return v.Character end
 end
 return nil
end

local win = DiscordLib:Window("Murder Mystery 2")

local serv = win:Server("ByteHub","http://www.roblox.com/asset/?id=6031075938")
function Notify(Title, Text, ButtonText)
  DiscordLib:Notification(Title, Text, ButtonText)
end
function Seperate(Tab) Tab:Seperator() end
function Channel(Name) return serv:Channel(tostring(Name)) end
function Label(Tab, Text) returnTab:Label(tostring(Text)) end
function TextBox(Tab, Text, Placeholder, Callback) return Tab:Textbox(tostring(Text), tostring(Placeholder), true, Callback) end
function DropDown(Tab, Text, Options, Callback) return Tab:Dropdown(tostring(Text), tostring(Options), Callback) end
function Toggle(Tab, Text, Default, Callback) return Tab:Toggle(tostring(Text), Default, Callback) end
function Button(Tab, Text, Callback) return Tab:Button(tostring(Text), Callback) end
Notify("Developer Note!", "Hey! If you would like to support the developer make sure to join our discord!", "Okay!")
local Main = Channel("Main")
local SayMessageRequest = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
local G = Channel("UI")
Button(Main, "Murderer & Sherrif Finder", function()
 local a = game:GetService("Players"):GetChildren()
 table.remove(a, 1)
 for i, v in a do
  if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
  if CMS then SayMessageRequest:FireServer(v.DisplayName.." is sherrif.", "normalchat") else Notify("Sherrif Found!", v.DisplayName.." is sherrif", "Okay") end 
  elseif v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
  if not CMS then
   Notify("Murderer Found!" , v.DisplayName.." is murderer.", "Okay")
  else
  SayMessageRequest:FireServer(v.DisplayName.." is murderer.", "normalchat") end
  end
end
end)
Button(Main, "Kill All (Murderer Only)", function()
 for i, v in game:GetService("Players"):GetChildren() do
  if Plr.Backpack:FindFirstChild("Knife") then Plr.Backpack.Knife.Parent = Plr.Character end
   Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
   vim:SendMouseButtonEvent(0,0,0,true,game,false,0)
   task.wait()
   vim:SendMouseButtonEvent(0,0,0,false,game,false,0)
   task.wait(.75)
  end
end)
Button(Main, "Teleport To Lobby", function()
  Plr.Character.HumanoidRootPart.CFrame = workspace.Lobby.Spawns.Spawn.CFrame
end)
Button(G, "Center UI", function()
 game:GetService("CoreGui"):WaitForChild("Discord").MainFrame.Position = UDim2.new(.5, 0, .5, 0)
 game:GetService("CoreGui"):WaitForChild("Discord").MainFrame.AnchorPoint = Vector2.new(.5,0.5)
end)
Button(Main, "Grab Gun", function()
 Plr.Character.HumanoidRootPart.CFrame = workspace.GunDrop.CFrame
end)
Toggle(Main, "Auto Escape Murderer", false, function(state)
 AE = state
end)
Toggle(Main, "Auto Shoot Murderer", false, function(state)
 ASM = state
end)
Toggle(Main, "Auto Take Gun", false, function(state)
ATG = state
end)
Toggle(Main, "Chat Murderer and Sherrif Finder's results", false, function(state)
 CMS = state
end)
workspace.ChildAdded:Connect(function(child)
task.delay(.25, function()
if child.Name == "GunDrop" and ATG then
local c = Plr.Character.HumanoidRootPart.CFrame
Plr.Character.HumanoidRootPart.CFrame = child.CFrame
Plr.Character.HumanoidRootPart.CFrame = c
end
end)
end)
function MurdererLoop()
 if ASM and Plr.Character and GetMurderer() and Plr.Character:FindFirstChild("Gun") or Plr.Backpack:FindFirstChild("Gun") then
  if Plr.Backpack:FindFirstChild("Gun") then Plr.Backpack.Gun.Parent = Plr.Character end
  local Murd = GetMurderer()
  Plr.Character.HumanoidRootPart.CFrame = Murd.HumanoidRootPart.CFrame + Vector3.new(11, 0, 0)
  Plr.Character.Gun.KnifeServer.ShootGun:InvokeServer(1, Murd.HumanoidRootPart.Position, "AH")
 end
 task.wait(.5)
end
function SecondLoop()
 if GetMurderer() == Plr.Character or GetMurderer() == nil or not AE then return end
 if (GetMurderer().HumanoidRootPart.Position-Plr.Character.HumanoidRootPart.Position).magnitude < 11 then
  Plr.Character.HumanoidRootPart.CFrame = Part.CFrame + Vector3.new(0, 3, 0)
 end
end
Main2 = Channel("Freezers & Runners")
Button(Main2, "Unfreeze All", function()
 for i, v in game:GetService("Players"):GetChildren() do
  if v ~= Plr and not v.Backpack:FindFirstChild("Knife") or v.Character and not v.Character:FindFirstChild("Knife") then
   Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
   task.wait(.75)
  end
 end
end)
Button(Main2, "Freeze All", function()
 for i, v in game:GetService("Players"):GetChildren() do
  if v ~= Plr and not v.Backpack:FindFirstChild("Knife") or v.Character and not v.Character:FindFirstChild("Knife") then
  if Plr.Backpack:FindFirstChild("Knife") then Plr.Backpack.Knife.Parent = Plr.Character end
   Plr.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
   vim:SendMouseButtonEvent(0,0,0,true,game,false,0)
   task.wait()
   vim:SendMouseButtonEvent(0,0,0,false,game,false,0)
   task.wait(.75)
  end
 end
end)
game:GetService("RunService").Heartbeat:Connect(MurdererLoop)
game:GetService("RunService").Heartbeat:Connect(SecondLoop)
game:GetService("CoreGui"):WaitForChild("Discord").DisplayOrder = -1
