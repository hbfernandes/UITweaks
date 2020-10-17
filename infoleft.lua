--- Info frames ---

local addon, ns = ...

-- Frames
local infoFrame = CreateFrame("Frame")
infoFrame:SetWidth(100)
infoFrame:SetHeight(16)
infoFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)

-- Repair
infoFrame.repairIcon = infoFrame:CreateTexture(nil, "ARTWORK")
infoFrame.repairIcon:SetTexture("Interface\\Minimap\\TRACKING\\Repair")
infoFrame.repairIcon:SetPoint("LEFT", infoFrame, "LEFT", 0, 0)
infoFrame.repairIcon:SetHeight(infoFrame:GetHeight())
infoFrame.repairIcon:SetWidth(16)

infoFrame.repairText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
infoFrame.repairText:SetFont("FONTS\\FRIZQT__.TTF", 9, "NORMAL")
infoFrame.repairText:SetJustifyH("LEFT")
infoFrame.repairText:SetPoint("LEFT", infoFrame.repairIcon, "RIGHT", 0, 0)
infoFrame.repairText:SetHeight(infoFrame:GetHeight())
infoFrame.repairText:SetWidth(28)

-- Equipment Set
infoFrame.gearIcon = infoFrame:CreateTexture(nil, "ARTWORK")
infoFrame.gearIcon:SetTexCoord(0.05, 0.95, 0.05, 0.95);
infoFrame.gearIcon:SetPoint("LEFT", infoFrame.repairText, "RIGHT", 0, 0)
infoFrame.gearIcon:SetHeight(infoFrame:GetHeight() - 3)
infoFrame.gearIcon:SetWidth(16)

infoFrame.gearText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
infoFrame.gearText:SetFont("FONTS\\FRIZQT__.TTF", 9, "NORMAL")
infoFrame.gearText:SetJustifyH("LEFT")
infoFrame.gearText:SetPoint("LEFT", infoFrame.gearIcon, "RIGHT", 3, 0)
infoFrame.gearText:SetHeight(infoFrame:GetHeight())
infoFrame.gearText:SetWidth(100)


--- Functions

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
    info.repairText:SetText(math.floor(lowestPercent).."%")
end

local function updateGearSet(info, setID)
    local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
    local i, hasEquipped = 1, false
    while equipmentSetIDs[i] do
        local name, iconFileID, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(equipmentSetIDs[i])
        if isEquipped then
            info.gearIcon:SetTexture(iconFileID)
            info.gearText:SetText(name)
            
            hasEquipped = true
            break
        end
        i = i + 1
    end

    if not hasEquipped then
        info.gearIcon:SetTexture("134400")
        info.gearText:SetText("No set equipped")
    end
    
    info.updating = false    
end

--- Events

local function infoFrame_OnEvent(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        updateGearSet(self)
    elseif event == "UPDATE_INVENTORY_DURABILITY" then
        updateDurability(self)
    elseif event == "EQUIPMENT_SETS_CHANGED" or event == "PLAYER_EQUIPMENT_CHANGED" or event == "EQUIPMENT_SWAP_FINISHED" then
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
infoFrame:HookScript("OnEvent", infoFrame_OnEvent)
