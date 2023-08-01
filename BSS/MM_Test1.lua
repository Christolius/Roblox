-- i dont know why i made this.
local plr = game.Players.LocalPlayer
local MMF:Frame = plr.PlayerGui.ScreenGui.MinigameLayer.MemoryMatchFrame.GuiGrid
local GuiGrid = MMF:GetChildren()[1] or MMF:GetChildren()[2]
if (GuiGrid and GuiGrid:FindFirstChild('GuiSlot')) then
    for i,slot:Frame in pairs(GuiGrid:GetChildren()) do
        for i,v in pairs(slot:GetDescendants()) do if v:IsA('GuiObject') then v.Visible = true end end
        if not slot:FindFirstChild('StageGrow') then continue end
        local ObjContent = slot.StageGrow.StagePop.StageFlip.ObjCard.ObjContent.GuiTile.StageGrow.StagePop.StageFlip.ObjCard.ObjContent
        local objimage:ImageLabel = ObjContent.ObjImage
        objimage.ImageTransparency = 0
        ObjContent.Visible = true
    end    
end