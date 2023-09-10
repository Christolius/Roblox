-- Decompiled using Krnl
-- Modified by Christolius

local framework = require((game:GetService("ReplicatedStorage")):WaitForChild("MultiboxFramework"))
while true do
    local Loaded = framework.Loaded
    if not Loaded then break end
    game:GetService("RunService").Heartbeat:Wait()
end
local AccurateWait = framework.AccurateWait
local localplayer = game:GetService("Players").LocalPlayer
local CurrentWave = ((game:GetService("ReplicatedStorage")):WaitForChild("MatchData")):WaitForChild("CurrentWave")
local VoteSkipPlayers = ((game:GetService("ReplicatedStorage")):WaitForChild("MatchData")):WaitForChild("VoteSkipPlayers")
local BeatenAttackers = ((game:GetService("ReplicatedStorage")):WaitForChild("MatchData")):WaitForChild("BeatenAttackers")
local TotalAttackers = ((game:GetService("ReplicatedStorage")):WaitForChild("MatchData")):WaitForChild("TotalAttackers")
local Interval = ((game:GetService("ReplicatedStorage")):WaitForChild("MatchData")):WaitForChild("Interval")
local CanSkip = ((game:GetService("ReplicatedStorage")):WaitForChild("MatchData")):WaitForChild("CanSkip")
local VoteSkipEnabled = false
local function Rerender_1()
    if CurrentWave.Value == 0 then
        script.Parent.WaveNumber.Text = string.format("Intermission (%s)", Interval.Value)
        script.Parent.WavePercent.Text = ""
    else
        script.Parent.WaveNumber.Text = string.format("Wave %s", CurrentWave.Value)
        --v63 = BeatenAttackers ???????????????
        --v63 = TotalAttackers.Value ???????????????
        script.Parent.WavePercent.Text = ("%*%% Complete"):format(math.round(((BeatenAttackers.Value) / TotalAttackers.Value) * 100))
    end
    local v82 = string.format("Skip Wave %s/%s", VoteSkipPlayers.Value, math.round((#(game:GetService("Players")):GetPlayers()) / 2))
    script.Parent.SkipWave.Text = v82
    local v85 = VoteSkipPlayers:FindFirstChild(localplayer.UserId)
    if v85 then
        script.Parent.SkipWave.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    else
        script.Parent.SkipWave.BackgroundColor3 = Color3.fromRGB(0, 177, 255)
    end
    script.Parent.SkipWave.Visible = CanSkip.Value
    if CanSkip.Value == true then
        if VoteSkipEnabled == true then
            framework.Network.Fire("VoteSkipWave")
        end
    end
end

Rerender_1()
CurrentWave.Changed:Connect(Rerender_1)
VoteSkipPlayers.Changed:Connect(Rerender_1)
BeatenAttackers.Changed:Connect(Rerender_1)
TotalAttackers.Changed:Connect(Rerender_1)
Interval.Changed:Connect(Rerender_1)
CanSkip.Changed:Connect(Rerender_1)

script.Parent.SkipWave.Activated:Connect(function()
    framework.Network.Fire("VoteSkipWave")
end)

local function autoSkipChanged_1()
    local v136 = script
    local v141 = (v136.Parent:WaitForChild("AutoSkip")):WaitForChild("OnAndOff")
    local v142 = VoteSkipEnabled
    if v142 then
        v136 = Color3.fromRGB
        v142 = 0
        local v145 = v136(v142, 255, 0)
        if not v145 then
            v145 = Color3.fromRGB
            local v149 = v145(255, 0, 0)
        end
        v141.BackgroundColor3 = v149
        v149 = CanSkip
        v141 = v149.Value
        if v141 == true then
            v141 = VoteSkipEnabled
            if v141 == true then
                v149 = framework.Network
                v141 = v149.Fire
                v149 = "VoteSkipWave"
                v141(v149)
            end
        end
        return 
    end
end

autoSkipChanged_1()

script.Parent:WaitForChild("AutoSkip"):WaitForChild("OnAndOff").Activated:Connect(function()
    VoteSkipEnabled = not VoteSkipEnabled
    autoSkipChanged_1()
end)
