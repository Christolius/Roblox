for i, v in ipairs(game:GetService("Workspace"):GetChildren()) do
    if v.ClassName == "Model" then
        for i, vv in ipairs(v:GetDescendants()) do
			if vv.ClassName == "ProximityPrompt" then
				vv.HoldDuration = 0  -- Set HoldDuration to 0 to remove the delay
				print("Set HoldDuration of ProximityPrompt to 0: " .. vv.Name)
			end
		end
    end
end
