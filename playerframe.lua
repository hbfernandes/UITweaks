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
    markFrame:RegisterEvent("PLAYER_ENTERING_WORLD")  
    markFrame:HookScript("OnEvent", updatePlayerMarker)

    -- Display XP percentage on playerframe
    if UnitLevel("player") ~= GetMaxLevelForPlayerExpansion() then 
        local xpframe = CreateFrame("Frame", nil, PlayerFrame)
        xpframe:SetWidth(40)
        xpframe:SetHeight(40)
        xpframe:SetPoint("RIGHT", PlayerFrame, "BOTTOMLEFT", 49, 33)

        xpframe.text = xpframe:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
        xpframe.text:SetAllPoints(true)
      
        xpframe:Show()
        xpframe:RegisterEvent("PLAYER_XP_UPDATE")
        xpframe:RegisterEvent("PLAYER_ENTERING_WORLD")
        xpframe:HookScript("OnEvent", function(self)
            self.text:SetText(math.floor((UnitXP("player")*100)/UnitXPMax("player")) .. "%")
        end)
    end 
end

if MageArcaneChargesFrame then
    MageArcaneChargesFrame:Hide()
    MageArcaneChargesFrame:HookScript("OnShow", function(self) self:Hide() end)
end

if RuneFrame then
    RuneFrame:ClearAllPoints()
    RuneFrame:SetPoint("CENTER", UIParent, "CENTER", 6, -130)

    -- remove mouseover tooltip
    for i = 1, 6 do
        RuneFrame["Rune"..i]:SetScript("OnEnter", function() end)
        RuneFrame["Rune"..i]:SetScript("OnLeave", function() end)
    end
end