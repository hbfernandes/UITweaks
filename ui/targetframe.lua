
if TargetFrame then
    -- Set position
    if not TargetFrame:IsUserPlaced() then
        TargetFrame:ClearAllPoints()
        TargetFrame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -405, -582)
        TargetFrame:SetClampedToScreen(true)
        TargetFrame:SetUserPlaced(true)
    end
end

-- Move the castbar to the top of the frame
local function setCastBarOnTop(self, relPnt)
    local parentFrame = self:GetParent()

    if parentFrame:IsUserPlaced() and (not parentFrame.buffsOnTop) and (not string.find(relPnt, "TOP")) then
        -- y was 15 for elite and 7 for normal, settle in the mid
        self:ClearAllPoints()
        self:SetPoint("BOTTOMLEFT", parentFrame, "TOPLEFT", 25, 13)
    end
end

if TargetFrameSpellBar then
    hooksecurefunc(TargetFrameSpellBar, "SetPoint", function(self, pnt, relTo, relPnt, x, y)
        setCastBarOnTop(self, relPnt)
    end)
end

-- Do it for focus too
if FocusFrameSpellBar then
    hooksecurefunc(FocusFrameSpellBar, "SetPoint", function(self, pnt, relTo, relPnt, x, y)
        setCastBarOnTop(self, relPnt)
    end)
end
