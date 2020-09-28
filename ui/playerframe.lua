-- https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/PlayerFrame.lua

if PlayerFrame then
    -- Set position
    if not TargetFrame:IsUserPlaced() then
        PlayerFrame:ClearAllPoints()
        PlayerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 405, -582)
        TargetFrame:SetClampedToScreen(true)
        PlayerFrame:SetUserPlaced(true)
    end

    -- Stop showing heals/dmg on player frame
    PlayerFrame:UnregisterEvent("UNIT_COMBAT")

    -- Display raid marker on frame
    PlayerFrame:RegisterEvent("RAID_TARGET_UPDATE")

    local playerMarkFrame = CreateFrame("Frame", nil, PlayerFrame)
    playerMarkFrame:SetFrameStrata("MEDIUM") -- PlayerFrame is LOW, set MEDIUM to display above
    playerMarkFrame:SetWidth(40)
    playerMarkFrame:SetHeight(40)
    playerMarkFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 55, 5)

    local markTexture = playerMarkFrame:CreateTexture(nil, "OVERLAY")
    markTexture:SetAllPoints(playerMarkFrame)
    playerMarkFrame.texture = markTexture

    PlayerFrame.markFrame = playerMarkFrame

    local function updatePlayerMarker(self, event, ...)
        local index = GetRaidTargetIndex(self.unit)
        if (index) then
            self.markFrame.texture:SetTexture("13700" .. index)
            self.markFrame:Show()
        else
            self.markFrame:Hide()
        end
    end

    PlayerFrame:HookScript("OnEvent", updatePlayerMarker)
end

if MageArcaneChargesFrame then
    MageArcaneChargesFrame:Hide()
    MageArcaneChargesFrame:HookScript("OnShow",function(self) self:Hide() end)
end