-- https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/PlayerFrame.lua

if PlayerFrame then
    -- Set position
    if not TargetFrame:IsUserPlaced() then
        PlayerFrame:ClearAllPoints()
        PlayerFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 405, -582)
        PlayerFrame:SetUserPlaced(true)
    end

    -- Stop showing heals/dmg on player frame
    PlayerFrame:UnregisterEvent("UNIT_COMBAT")

    -- Display raid marker on frame
    local function updatePlayerMarker(self, event, ...)
        local index = GetRaidTargetIndex("player")
        if (index) then
            self.texture:SetTexture("13700" .. index)
            self:Show()
        else
            self:Hide()
        end
    end

    local markFrame = CreateFrame("Frame", nil, PlayerFrame)
    markFrame:SetFrameStrata("MEDIUM") -- PlayerFrame is LOW, set MEDIUM to display above
    markFrame:SetWidth(40)
    markFrame:SetHeight(40)
    markFrame:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 55, 5)

    markFrame.texture = markFrame:CreateTexture(nil, "OVERLAY")
    markFrame.texture:SetAllPoints(markFrame)

    markFrame:RegisterEvent("RAID_TARGET_UPDATE")  
    markFrame:HookScript("OnEvent", updatePlayerMarker)

    -- Displaye XP percentage on playerframe
    if UnitLevel("player") ~= GetMaxPlayerLevel() then 
        local function updateXP(self)       
            self.text:SetText(math.floor((UnitXP("player")*100)/UnitXPMax("player")) .. "%")
        end

        local xpframe = CreateFrame("Frame", nil, PlayerFrame)
        xpframe:SetWidth(40)
        xpframe:SetHeight(40)
        xpframe:SetPoint("RIGHT", PlayerFrame, "BOTTOMLEFT", 49, 33)

        xpframe.text = xpframe:CreateFontString(nil, "OVERLAY")
        xpframe.text:SetAllPoints(true)
        xpframe.text:SetVertexColor(1, 1, 1)
        xpframe.text:SetFont("FONTS\\FRIZQT__.TTF", 10, "OUTLINE")
    
        xpframe:Show()
        xpframe:RegisterEvent("PLAYER_XP_UPDATE")
        xpframe:RegisterEvent("PLAYER_ENTERING_WORLD")
        xpframe:HookScript("OnEvent", updateXP)
    end 
end

if MageArcaneChargesFrame then
    MageArcaneChargesFrame:Hide()
    MageArcaneChargesFrame:HookScript("OnShow",function(self) self:Hide() end)
end