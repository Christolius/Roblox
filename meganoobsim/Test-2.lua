local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local function fti(part:BasePart)
    firetouchinterest(part,hrp,0)
    firetouchinterest(part,hrp,1)
end
for i,v in pairs(workspace.CoinStuff:GetChildren()) do
    for i,v in pairs(v.Coins:GetChildren()) do
        fti(v)
    end
end