--- Right side info ---

local addon, ns = ...
local infoFrame = ns.infoFrame

-- fps
infoFrame.fpsText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
infoFrame.fpsText:SetJustifyH("LEFT")
infoFrame.fpsText:SetPoint("RIGHT", infoFrame, "RIGHT", 5, 0)
infoFrame.fpsText:SetHeight(infoFrame:GetHeight())

infoFrame.fpsIcon = infoFrame:CreateTexture(nil, "ARTWORK")
infoFrame.fpsIcon:SetTexture("Interface\\Addons\\"..addon.."\\media\\fps_blue.png")
infoFrame.fpsIcon:SetPoint("RIGHT", infoFrame.fpsText, "LEFT", -1, 0)
infoFrame.fpsIcon:SetHeight(infoFrame:GetHeight() - 4)
infoFrame.fpsIcon:SetWidth(infoFrame:GetHeight())

-- latency
infoFrame.latencyText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
infoFrame.latencyText:SetJustifyH("LEFT")
infoFrame.latencyText:SetPoint("RIGHT", infoFrame.fpsIcon, "LEFT", -8, 0)
infoFrame.latencyText:SetHeight(infoFrame:GetHeight())

infoFrame.latencyIcon = infoFrame:CreateTexture(nil, "ARTWORK")
infoFrame.latencyIcon:SetTexture("Interface\\Addons\\"..addon.."\\media\\latency")
infoFrame.latencyIcon:SetPoint("RIGHT", infoFrame.latencyText, "LEFT", -1, 0)
infoFrame.latencyIcon:SetHeight(infoFrame:GetHeight() - 4)
infoFrame.latencyIcon:SetWidth(infoFrame:GetHeight())


--- Functions

local function updateFps(info)
    ns:infoFrameSetText(info.fpsText, math.floor(GetFramerate()).."fps")
end

local function updateLatency(info)
    local _, _, latencyHome, latencyWorld = GetNetStats()
    if latencyWorld > 999 then
        latencyWorld = math.floor(latencyWorld/1000).."k+"
    end

    ns:infoFrameSetText(info.latencyText, latencyWorld.."ms")
end

--- Events

local function right_OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        updateFps(self)
        updateLatency(self)
    end
end

infoFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
infoFrame:HookScript("OnEvent", right_OnEvent)
infoFrame:HookScript("OnUpdate", function(self, elapsed)
    self.latencyLastUpdate = (self.latencyLastUpdate or 0) + elapsed
    self.fpsLastUpdate = (self.fpsLastUpdate or 0) + elapsed

    if (self.fpsLastUpdate > 1) then
        updateFps(self)        
        self.fpsLastUpdate = 0
    end
    if (self.latencyLastUpdate > 15) then
        updateLatency(self)
        self.latencyLastUpdate = 0
    end
end)
