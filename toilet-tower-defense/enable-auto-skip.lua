local CanSkip = game:GetService("ReplicatedStorage"):WaitForChild("MatchData"):WaitForChild("CanSkip")
local framework = require((game:GetService("ReplicatedStorage")):WaitForChild("MultiboxFramework"))

game:GetService'RunService'.Heartbeat:Connect(function(deltaTime)
    if CanSkip.Value == true then
        framework.Network.Fire("VoteSkipWave")
    end
end)