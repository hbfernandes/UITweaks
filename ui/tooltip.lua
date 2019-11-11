-- See https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/GameTooltip.lua

-- adjust corner tooltip placement
if GameTooltip_SetDefaultAnchor then
    local function tooltipPos(tooltip, parent)
        -- corner are the only ones with parent?
        if parent then
            local pnt, relTo, relPnt, x, y = tooltip:GetPoint()
            tooltip:ClearAllPoints()
            tooltip:SetPoint(pnt, relTo, relPnt, x, 145)
        end
    end

    hooksecurefunc("GameTooltip_SetDefaultAnchor", tooltipPos)
end

-- place status bar on top of the tooltip
if GameTooltipStatusBar then
	GameTooltipStatusBar:ClearAllPoints()
	GameTooltipStatusBar:SetPoint("TOPLEFT", 2, 9)
	GameTooltipStatusBar:SetPoint("TOPRIGHT", -2, 9)
end
