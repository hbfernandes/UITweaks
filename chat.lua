-- Chat frame

local chatframe, buttonFrame
local i = 1
while _G["ChatFrame"..i] do
    -- make it fully movable and resizeable
    chatframe = _G["ChatFrame"..i]
    chatframe:SetClampRectInsets(0, 0, 0, 0)
    chatframe:SetMinResize(100, 100)
    
    -- hide button frame
    buttonFrame = _G["ChatFrame"..i.."ButtonFrame"]
    buttonFrame:Hide()
    i = i + 1
end

-- edit box to top
-- with chatStyle = "classic" only the main edit box needs to change

local editBox = DEFAULT_CHAT_FRAME.editBox
editBox:ClearAllPoints()
editBox:SetPoint("BOTTOMLEFT", DEFAULT_CHAT_FRAME, "TOPLEFT", 0, 20 )
editBox:SetPoint("BOTTOMRIGHT", DEFAULT_CHAT_FRAME, "TOPRIGHT", 0, 20 )

-- hide useless buttons

ChatFrameChannelButton:Hide()
ChatFrameMenuButton:Hide()
QuickJoinToastButton:Hide()
