local rot = Vector3.new(50,0,0)
local pos = CFrame.fromMatrix(Vector3.new(1.5, .6, 1.5), Vector3.new(1,0,0), Vector3.new(0,0,1), Vector3.new(0,-1,0))
local balls = false -- set this to false if you dont want balls
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
wait(1)
	local plr = game.Players.LocalPlayer
	local bck = plr.Backpack
	for i,v in pairs(bck:GetChildren()) do
		if v.Name == 'Soda' then
			v.Equipped:Connect(function ()
				soda = v
				soda.Grip = pos
				if bck:FindFirstChild('Burger') and balls then
					bck.Burger.Parent = char
					soda.Handle.Rotation = rot
				end
			end)
		end
		if v.Name == 'TpRoll' then
			
			v.Equipped:Connect(function ()
				taco = v
				taco.Grip = pos
				if bck:FindFirstChild('Burger') and balls then
					bck.Burger.Parent = char
				end
			end)
		end
		if v.Name == 'TacoWithFoil' then
			v.Equipped:Connect(function ()
			taco = v
			taco.Grip = CFrame.fromMatrix(Vector3.new(1.5, 1, -0.3), Vector3.new(1,0,0), Vector3.new(0,1,0), Vector3.new(0,0,1))
				if bck:FindFirstChild('Burger') and balls then
					bck.Burger.Parent = char
				end
			end)
		end
		if v.Name == 'Coffee' then
			v.Equipped:Connect(function ()
				v.Grip = CFrame.fromMatrix(Vector3.new(-1.5, -0.5, -1.5), Vector3.new(0,0,-1), Vector3.new(-1,0,0), Vector3.new(0,1,0))
				if bck:FindFirstChild('Burger') and balls then
					bck.Burger.Parent = char
				end
			end)
		end
		if v.Name == 'Burger' then
			v.Equipped:Connect(function ()	
			v.Grip = CFrame.fromMatrix(Vector3.new(-1, 1.5, -1.5), Vector3.new(0,0,-1), Vector3.new(0,1,0), Vector3.new(1,0,0))
			end)
		end
	end
end)