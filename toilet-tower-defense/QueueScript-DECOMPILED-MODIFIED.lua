-- Decompiled using Krnl
-- Modified by Christolius

local framework = require((game:GetService("ReplicatedStorage")):WaitForChild("MultiboxFramework"))
while true do
    local v10 = framework.Loaded
    if not v10 then
        break
    end
    v10 = game:GetService("RunService").Heartbeat
    v10:Wait()
end
local v11 = framework.AccurateWait
local maps = {}
maps.ToiletCity = {
    ["DisplayName"] = "Toilet City",
    ["Difficulty"] = "Easy",
    ["WinReward"] = 50
}
maps.Desert = {
    ["DisplayName"] = "Desert",
    ["Difficulty"] = "Hard",
    ["WinReward"] = 200
}
maps.CameramanHQ = {
    ["DisplayName"] = "Cameraman HQ",
    ["Difficulty"] = "Insane",
    ["WinReward"] = 400
}
maps.ToiletHQ = {
    ["DisplayName"] = "Toilet HQ",
    ["Difficulty"] = "Nightmare",
    ["WinReward"] = 600
}
difficulty_colors = {}
difficulty_colors.Easy = {
    ["DisplayName"] = "Easy",
    ["Color"] = Color3.fromRGB(0,255,0)
}
difficulty_colors.Hard = {
    ["DisplayName"] = "Hard",
    ["Color"] = Color3.fromRGB(255,0,0)
}
difficulty_colors.Insane = {
    ["DisplayName"] = "Insane",
    ["Color"] = Color3.fromRGB(177,0,255)
}
difficulty_colors.Nightmare = {
    ["DisplayName"] = "Nightmare",
    ["Color"] = Color3.fromRGB(97,0,255)
}
local queueId = nil
local localplayer = game:GetService("Players").LocalPlayer
framework.Network.Fired("QueueLeaderChanged"):Connect(function(QID, mapName, players, maxPlayers, player)
    if queueId == QID then
        if player ~= localplayer then
            queueId = nil
            script.Parent.Visible = false
            return 
        end
    end
    if player == localplayer then
        queueId = QID
        local v74 = maps[mapName]
        v39 = script.Parent.MapName
        v39.Text = v74.DisplayName
        v39 = v74.Difficulty
        local v53 = difficulty_colors[v39]
        script.Parent.Difficulty.Text = v53.DisplayName
        script.Parent.Difficulty.BackgroundColor3 = v53.Color
        script.Parent.PlayerAmount.Text = string.format("%s/%s", players, maxPlayers)
        script.Parent.CoinAmount.RewardAmount.Text = v74.WinReward
        script.Parent.Visible = true
    end
end)
script.Parent.Start.Activated:Connect(function()
    if not queueId then return end
    framework.Network.Fire("StartTeleport", queueId)
end)
