-- Move the castbar to the top of the frame
local function setCastBarOnTop(self, relPnt, x)
    local parentFrame = self:GetParent()
        
    if (not parentFrame.buffsOnTop) and (not string.find(relPnt, "TOP")) then
        -- y was 15 for elite and 7 for normal, settle in the mid
        self:ClearAllPoints()
        self:SetPoint("BOTTOMLEFT", parentFrame, "TOPLEFT", x, 13)
    end
end

if TargetFrameSpellBar then
    hooksecurefunc(TargetFrameSpellBar, "SetPoint", function(self, pnt, relTo, relPnt, x, y)
        setCastBarOnTop(self, relPnt, 43)
    end)
end

-- Do it for focus too
if FocusFrameSpellBar then
    hooksecurefunc(FocusFrameSpellBar, "SetPoint", function(self, pnt, relTo, relPnt, x, y)
        setCastBarOnTop(self, relPnt, 38)
    end)
end
