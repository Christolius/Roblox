for i,v in pairs(workspace.BaconStuff.JackedBacons:GetChildren()) do
    if not v:FindFirstChild("Humanoid")then continue end
    while v.Humanoid.Health > 0 and wait(.1) do
        game:GetService("ReplicatedStorage").Remotes.Punch:FireServer(v)
    end
end