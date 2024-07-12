local function grabAllCubes()
    local char = game.Players.LocalPlayer.Character
    local orgpos = char.HumanoidRootPart.CFrame
    for i,v in workspace:GetChildren() do
        if not string.find(v.Name," Cube") or not v:FindFirstChild("Hitbox") then continue end
        char.HumanoidRootPart.CFrame = v.Hitbox.CFrame
        task.wait(.05)
    end
    char.HumanoidRootPart.CFrame = orgpos
end

grabAllCubes()
