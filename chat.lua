-- Chat frame
local chatframe, editBox, buttonFrame
local i = 1
while _G["ChatFrame"..i] do
    -- make it fully movable and resizeable
    chatframe = _G["ChatFrame"..i]
    chatframe:SetClampRectInsets(0, 0, 0, 0)
    chatframe:SetMinResize(100, 100)

    -- edit box to top
    editBox = _G["ChatFrame"..i.."EditBox"]
    editBox:ClearAllPoints()
    editBox:SetPoint("BOTTOMLEFT", DEFAULT_CHAT_FRAME, "TOPLEFT", 0, 20 )
    editBox:SetPoint("BOTTOMRIGHT", DEFAULT_CHAT_FRAME, "TOPRIGHT", 0, 20 )
    editBox:Hide()
    
    -- hide button frame
    buttonFrame = _G["ChatFrame"..i.."ButtonFrame"]
    buttonFrame:Hide()
    i = i + 1
end

-- hide useless buttons
ChatFrameChannelButton:Hide()
ChatFrameMenuButton:Hide()
QuickJoinToastButton:Hide()

-- make the big border only present when editing

if ChatEdit_ActivateChat then
    hooksecurefunc("ChatEdit_ActivateChat", function(editBox)
        local frameName = editBox:GetName()
        _G[frameName.."Left"]:Show()
        _G[frameName.."Right"]:Show()
        _G[frameName.."Mid"]:Show()
    end)
else
    print("Missing 'ChatEdit_ActivateChat' to hook on!")
end
if ChatEdit_DeactivateChat then
    hooksecurefunc("ChatEdit_DeactivateChat", function(editBox)
        local frameName = editBox:GetName()
        _G[frameName.."Left"]:Hide()
        _G[frameName.."Right"]:Hide()
        _G[frameName.."Mid"]:Hide()
    end)
else
    print("Missing 'ChatEdit_DeactivateChat' to hook on!")
end