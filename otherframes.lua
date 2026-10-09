-- Talking head
-- local function HookTalkingHead()
--     TalkingHeadFrame:SetScale(0.68)

--     local function hideHeadFrame()
--         TalkingHeadFrame.MainFrame.CloseButton:GetScript("OnClick")()
--     end

--     local function moveHeadFrame()
--         TalkingHeadFrame:ClearAllPoints()
--         TalkingHeadFrame:SetPoint("CENTER", "UIParent", 0, -400)
--     end

--     --TalkingHeadFrame:HookScript("OnShow", moveHeadFrame)
--     TalkingHeadFrame:HookScript("OnShow", hideHeadFrame)
-- end

-- Run the hook if frame is loaded, hook it to the loading function if not
if TalkingHeadFrame then
    TalkingHeadFrame:SetScale(0.68)
--     HookTalkingHead()
-- else
--     hooksecurefunc('TalkingHead_LoadUI', HookTalkingHead)
end

-- Islands/PVP etc mid top frame
-- if UIWidgetTopCenterContainerFrame then
--     local pnt, relTo, relPnt, x, y = UIWidgetTopCenterContainerFrame:GetPoint()
--     UIWidgetTopCenterContainerFrame:ClearAllPoints()
--     UIWidgetTopCenterContainerFrame:SetPoint(pnt, relTo, relPnt, x, y - 12)
-- end

-- Frames status decimals
function UpdateStatusTextPercent(statusFrame, textString, value, valueMin, valueMax)
    local textDisplay = GetCVar("statusTextDisplay")
    if ( value and valueMax > 0 and ( (textDisplay ~= "NUMERIC" and textDisplay ~= "NONE") or statusFrame.showPercentage ) and not statusFrame.showNumeric) then
        if ( not (value == 0 and statusFrame.zeroText) and textDisplay == "BOTH" and not statusFrame.showPercentage) then
            if( statusFrame.LeftText and statusFrame.RightText ) then
                if(not statusFrame.powerToken or statusFrame.powerToken == "MANA") then
                    statusFrame.LeftText:SetText(ceil((value / valueMax) * 1000)/10 .. "%")
                end
            end
        end
    end
end

if TextStatusBar_UpdateTextStringWithValues then
    hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", UpdateStatusTextPercent)
else
    print("Missing 'TextStatusBar_UpdateTextStringWithValues' to hook on!")
end


-- All Bags and menu buttons
-- MicroButtonAndBagsBar:Hide()

-- Just Bags
-- MainMenuBarBackpackButton:Hide()
-- BagBarExpandToggle:Hide()

-- Chat Bubble text
ChatBubbleFont:SetFontObject(GameFontNormalOutline)

-- Move xp bar
if StatusTrackingBarManager then
    StatusTrackingBarManager:SetScale(0.8)
	StatusTrackingBarManager:ClearAllPoints()
	StatusTrackingBarManager:SetPoint("BOTTOMLEFT", 41, 0)
	
end