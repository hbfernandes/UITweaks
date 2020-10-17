-- Talking head
local function HookTalkingHead()
    TalkingHeadFrame:SetScale(0.68)

    local function hideHeadFrame()
        TalkingHeadFrame.MainFrame.CloseButton:GetScript("OnClick")()
    end

    local function moveHeadFrame()
        TalkingHeadFrame:ClearAllPoints()
        TalkingHeadFrame:SetPoint("CENTER", "UIParent", 0, -400)
    end

    --TalkingHeadFrame:HookScript("OnShow", moveHeadFrame)
    TalkingHeadFrame:HookScript("OnShow", hideHeadFrame)
end

-- Run the hook if frame is loaded, hook it to the loading function if not
if TalkingHeadFrame then
    HookTalkingHead()
else
    hooksecurefunc('TalkingHead_LoadUI', HookTalkingHead)
end

-- Islands/PVP etc mid top frame
if UIWidgetTopCenterContainerFrame then
    local pnt, relTo, relPnt, x, y = UIWidgetTopCenterContainerFrame:GetPoint()
    UIWidgetTopCenterContainerFrame:ClearAllPoints()
    UIWidgetTopCenterContainerFrame:SetPoint(pnt, relTo, relPnt, x, y - 12)
end
