wait(5)
local tws = game:GetService'TweenService'
local twi = TweenInfo.new(15,Enum.EasingStyle.Sine)
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local humroot = char:FindFirstChild('HumanoidRootPart')
local enemy = workspace.Characters.adjskaes
local t = enemy.HumanoidRootPart.Position - humroot.Position
t = t < 0 and -t or t
local time = t / 10
tws:Create(humroot,twi,{CFrame = CFrame.new(enemy.HumanoidRootPart.Position)}):Play()
