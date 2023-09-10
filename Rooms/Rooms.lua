local last = game.Workspace:GetChildren()[#game.Workspace:GetChildren()]
local Goal = 100

for i=0,Goal,1 do
  last = game.Workspace:GetChildren()[#game.Workspace:GetChildren()]
  if last:IsA("Model") and last:FindFirstChild("door")then
      fireclickdetector(last.door.ClickDetector)
  end
end
