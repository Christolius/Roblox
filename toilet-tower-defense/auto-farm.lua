-- PUT THIS IS AUTOEXEC FOLDER
game.Players.LocalPlayer.CharacterAdded:Wait()
if not game.ReplicatedStorage:FindFirstChild'IsLobby' then return end
local map = "ToiletHQ"
if game.ReplicatedStorage.IsLobby.Value then
    task.spawn(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Christolius/Roblox/main/toilet-tower-defense/auto-start.lua'),true)()
    end)
    local lift = workspace.Lifts:GetChildren()[math.random(1,#workspace.Lifts:GetChildren())]
    while lift.Name ~= map do
        task.wait()
        lift = workspace.Lifts:GetChildren()[math.random(1,#workspace.Lifts:GetChildren())]
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lift.Area.CFrame
else
    task.spawn(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Christolius/Roblox/main/toilet-tower-defense/enable-auto-skip.lua'),true)()
    end)
end
