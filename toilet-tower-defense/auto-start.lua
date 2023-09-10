local framework = require(game:GetService("ReplicatedStorage"):WaitForChild("MultiboxFramework"))

local localplayer = game:GetService("Players").LocalPlayer
local queueId = nil

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
    end
end)

while task.wait() do
    if queueId then
        framework.Network.Fire("StartTeleport",queueId)
        break
    end
end
