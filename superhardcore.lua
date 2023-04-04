while wait() do 
  for i,v in pairs(game.Workspace:GetDescendants()) do 
    v:Clone().Parent = game.Workspace 
  end 
end
