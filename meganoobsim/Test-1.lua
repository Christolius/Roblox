for i,f:Instance in pairs(workspace.BaconStuff:GetChildren()) do
    if f:IsA('Folder') then
        for i,v in pairs(f:GetChildren()) do
            if not v:FindFirstChild("Humanoid")then;continue;end
            for i=1,100 do
                game:GetService("ReplicatedStorage").Remotes.Punch:FireServer(v)
            end
        end
    end
end     