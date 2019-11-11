-- Buff frames config
-- https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/BuffFrame.lua

-- position it
if BuffFrame then
    local buffsY = -30
    hooksecurefunc(BuffFrame, "SetPoint", function(self, pnt, relTo, relPnt, x, y)
        if y ~= buffsY then
            self:ClearAllPoints()
            self:SetPoint(pnt, relTo, relPnt, x, buffsY)
        end
    end)
end

-- limit max amount of buffs
if BuffFrame_UpdateAllBuffAnchors then
    hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", function()
        local shownBuffCount = _G["BUFF_ACTUAL_DISPLAY"]
        local origBuffSpacing = _G["BUFF_ROW_SPACING"]
        local newBuffSpacing = 12
        local maxBuffsShown = 3 * _G["BUFFS_PER_ROW"] -- want 3 rows only shown

        --print(totalBuffs)
        for i = 1, shownBuffCount do
            local buff = _G["BuffButton"..i]
            if i > maxBuffsShown then
                buff:Hide()
            else
                local pnt, relTo, relPnt, x, y = buff:GetPoint()
                if y == -origBuffSpacing then
                    buff:ClearAllPoints()
                    buff:SetPoint(pnt, relTo, relPnt, x, -newBuffSpacing)
                end
            end
        end
    end)
end

-- fixate debuff position
if DebuffButton_UpdateAnchors then
    local debuffsY = -78
    hooksecurefunc("DebuffButton_UpdateAnchors", function()
        local d = _G.DebuffButton1
        if d then
            local pnt, relTo, relPnt, x, _ = d:GetPoint()
            d:ClearAllPoints()
            d:SetPoint(pnt, relTo, relPnt, x, debuffsY)
        end
    end)
end

