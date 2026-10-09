--- Right side info ---

local addon, ns = ...
local infoFrame = ns.infoFrame

-- fps
infoFrame.fpsText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
infoFrame.fpsText:SetJustifyH("LEFT")
infoFrame.fpsText:SetPoint("RIGHT", infoFrame, "RIGHT", -4, 0)
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

-- Repair
infoFrame.repairText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
infoFrame.repairText:SetJustifyH("LEFT")
infoFrame.repairText:SetPoint("RIGHT", infoFrame.latencyIcon, "LEFT", -30, 0)
infoFrame.repairText:SetHeight(infoFrame:GetHeight())

infoFrame.repairIcon = infoFrame:CreateTexture(nil, "ARTWORK")
infoFrame.repairIcon:SetTexture("Interface\\Minimap\\TRACKING\\Repair")
infoFrame.repairIcon:SetPoint("RIGHT", infoFrame.repairText, "LEFT", -1, 0)
infoFrame.repairIcon:SetHeight(infoFrame:GetHeight())
infoFrame.repairIcon:SetWidth(infoFrame:GetHeight())

-- Equipment Set
infoFrame.gearText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
infoFrame.gearText:SetJustifyH("LEFT")
infoFrame.gearText:SetPoint("RIGHT", infoFrame.repairIcon, "LEFT", -10, 0)
infoFrame.gearText:SetHeight(infoFrame:GetHeight())

infoFrame.gearIcon = infoFrame:CreateTexture(nil, "ARTWORK")
infoFrame.gearIcon:SetTexCoord(0.05, 0.95, 0.05, 0.95);
infoFrame.gearIcon:SetPoint("RIGHT", infoFrame.gearText, "LEFT", -3, 0)
infoFrame.gearIcon:SetHeight(infoFrame:GetHeight() - 3)
infoFrame.gearIcon:SetWidth(infoFrame:GetHeight())


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

local function updateDurability(info)
    local current, max
    local lowestPercent = 100
    local thisPercent
    for i = 0, 19 do
        current, max = GetInventoryItemDurability(i)

        if current then
            thisPercent = current*100/max
            if thisPercent <= lowestPercent then
                lowestPercent = thisPercent
            end
        end

    end
    ns:infoFrameSetText(info.repairText, math.floor(lowestPercent).."%")
end

local function updateGearSet(info, setID)
    local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
    local i, hasEquipped = 1, false
    while equipmentSetIDs[i] do
        local name, iconFileID, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(equipmentSetIDs[i])
        if isEquipped then
            info.gearIcon:SetTexture(iconFileID)
            ns:infoFrameSetText(info.gearText, name)
            
            hasEquipped = true
            break
        end
        i = i + 1
    end

    if not hasEquipped then
        info.gearIcon:SetTexture("134400")
        ns:infoFrameSetText(info.gearText, "No set equipped")
    end
    
    info.updating = false    
end

--- Events

local function info_OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        updateGearSet(self)
        updateFps(self)
        updateLatency(self)
    elseif event == "UPDATE_INVENTORY_DURABILITY" then
        updateDurability(self)
    elseif (event == "EQUIPMENT_SETS_CHANGED" or 
            event == "PLAYER_EQUIPMENT_CHANGED" or 
            event == "EQUIPMENT_SWAP_FINISHED") then
        if not self.updating then
            self.updating = true
            ns:wait(1, updateGearSet, self)
        end
    end
    
end

infoFrame:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
infoFrame:RegisterEvent("EQUIPMENT_SWAP_FINISHED")
infoFrame:RegisterEvent("EQUIPMENT_SETS_CHANGED")
infoFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
infoFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

infoFrame:HookScript("OnEvent", info_OnEvent)
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