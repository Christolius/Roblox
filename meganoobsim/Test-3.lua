local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart

for i,v in pairs(workspace.CoinStuff:GetChildren()) do
    for i,v in pairs(v.Coins:GetChildren()) do
        hrp.CFrame = v.CFrame
    end
end