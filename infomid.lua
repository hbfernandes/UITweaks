--- Middle Info ---

local addon, ns = ...
local infoFrame = ns.infoFrame

-- zone text
infoFrame.zoneText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
infoFrame.zoneText:SetPoint("CENTER", infoFrame, "CENTER", 0, 0.5)
infoFrame.zoneText:SetHeight(infoFrame:GetHeight())

--- Functions


--- Events

local function mid_OnEvent(self, event, ...)
    if (event == "PLAYER_ENTERING_WORLD" or
        event == "ZONE_CHANGED_NEW_AREA" or
        event == "ZONE_CHANGED_INDOORS" or
        event == "ZONE_CHANGED") then
        local zone, subzone = GetZoneText(), GetSubZoneText()
        if zone == subzone or subzone == "" then
            ns:infoFrameSetText(self.zoneText, zone)
        else
            ns:infoFrameSetText(self.zoneText, zone..": "..subzone)
        end
    end
end


infoFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
infoFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
infoFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
infoFrame:RegisterEvent("ZONE_CHANGED")
infoFrame:HookScript("OnEvent", mid_OnEvent)

