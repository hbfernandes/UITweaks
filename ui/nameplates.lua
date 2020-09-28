-- Nameplate font sizes
local npFontFamily = SystemFont_LargeNamePlateFixed
local fontName, _, _ = npFontFamily:GetFont()

npFontFamily:SetFont(fontName, 14, "NONE")

-- Display health percentage on healthbar

local function createPercentHPFrame(nameplate)
    if nameplate:IsForbidden() or nameplate.healthPercent then
        return
    end
    
    nameplate.healthPercent = CreateFrame("Frame", nil, nameplate)
    nameplate.healthPercent:SetAllPoints(nameplate.healthBar)
    nameplate.healthPercent:SetFrameStrata("HIGH")

    nameplate.healthPercent.text = nameplate.healthPercent:CreateFontString(nil, "OVERLAY")
    nameplate.healthPercent.text:SetAllPoints(true)
    nameplate.healthPercent.text:SetVertexColor(1, 1, 1)

    -- If 'Larger Nameplates' option is enabled.
    if InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() == "1" then 
        nameplate.healthPercent.text:SetFont("FONTS\\FRIZQT__.TTF", 10, "OUTLINE")
    else
        nameplate.healthPercent.text:SetFont("FONTS\\FRIZQT__.TTF", 8, "OUTLINE")
    end                
end

local function updateHPPercent(nameplate)
    if (nameplate.healthPercent) then
        -- update a percentage value for health.
        local healthPercentage = ceil((UnitHealth(nameplate.displayedUnit) / UnitHealthMax(nameplate.displayedUnit) * 100))
        nameplate.healthPercent.text:SetText(healthPercentage .. "%")
    end
end


-- Dispellable buffs above nameplate

local maxShownBuffs = 3
local buffWidth = 20
local buffHeight = 15

local function createBuffFrame(nameplate, index)
    local buffFrame = CreateFrame("Frame", nil, nameplate, "NameplateBuffButtonTemplate")
   
    -- Steal highlight
    local buffStealHighlight = buffFrame:CreateTexture(nil, "ARTWORK")
    buffStealHighlight:SetAllPoints(buffFrame)
    buffStealHighlight:SetBlendMode("ADD")
    buffStealHighlight:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Stealable")
    buffFrame.Stealable = buffStealHighlight

    buffFrame:SetShown(false)
    buffFrame:SetPoint("BOTTOMRIGHT", nameplate.dispellable, "BOTTOMLEFT", 0 - buffWidth * (index - 1), 0)

    tinsert(nameplate.dispellable.buffs, buffFrame)
    return buffFrame
end

local function updateDispellableFramePosition(nameplate)
    if not nameplate.dispellable then
        return
    end
    
    if nameplate.name:IsShown() then
        nameplate.dispellable:SetPoint("BOTTOMRIGHT", nameplate.healthBar, "TOPRIGHT", 3, nameplate.name:GetHeight() + 10)
    else
        nameplate.dispellable:SetPoint("BOTTOMRIGHT", nameplate.healthBar, "TOPRIGHT", 3, 2)
    end
end

local function updateDispellableBuffs(nameplate)
    if not nameplate.dispellable then
        return
    end

    local reaction = UnitReaction("player", nameplate.displayedUnit)  -- 4 is neutral, less more hostile
    if not reaction or reaction > 4 then
        return
    end
    
    local buffFrame, name, icon, count, buffType, duration, expirationTime, stealable
    local shownBuffsIndex = 1
    local index = 1
    
    -- Check the new AuraUtil.ForEachAura comin in shadowlands

    while shownBuffsIndex <= maxShownBuffs do
        --name, icon, count, buffType, duration, expirationTime, _, stealable = UnitDebuff(nameplate.displayedUnit, index, nil)
        name, icon, count, buffType, duration, expirationTime, _, stealable = UnitBuff(nameplate.displayedUnit, index, nil)
        
        if name then
            -- print(name, buffType, stealable)
            if buffType == "Magic" or stealable then                                    
                buffFrame = nameplate.dispellable.buffs[shownBuffsIndex]
                if not buffFrame then
                    buffFrame = createBuffFrame(nameplate, shownBuffsIndex)                    
                end

                if ( icon ) then
                    -- set the icon
                    buffFrame.Icon:SetTexture(icon)

                    -- set the count
                    -- count=3
                    if ( count > 1 ) then
                        buffFrame.CountFrame.Count:SetText(count)
                        buffFrame.CountFrame.Count:Show()
                    else
                        buffFrame.CountFrame.Count:Hide()
                    end

                    -- Handle cooldowns
                    CooldownFrame_Set(buffFrame.Cooldown, expirationTime - duration, duration, duration > 0, true)

                    -- Stealable
                    -- stealable = true
                    if stealable then
                        buffFrame.Stealable:Show()
                    else
                        buffFrame.Stealable:Hide()
                    end
            
                    buffFrame:Show()
                    shownBuffsIndex = shownBuffsIndex + 1
                end
            end
        else
            -- stop
            break
        end

        index = index + 1
    end

    -- Hide unused frames
    for i = shownBuffsIndex, maxShownBuffs do
        local buffFrame = nameplate.dispellable.buffs[i]
        if buffFrame then
            buffFrame:Hide()
        else
            break
        end
    end
end

local function createDispellableFrame(nameplate)
    if nameplate:IsForbidden() or nameplate.dispellable then
        return
    end

    -- print("Creating for", nameplate:GetName())

    nameplate.dispellable = CreateFrame("Frame", nil, nameplate)
    nameplate.dispellable:SetWidth(1)
    nameplate.dispellable:SetHeight(1)

    nameplate.dispellable.buffs = {}
end

-- Hook it up

if DefaultCompactNamePlateFrameSetupInternal then
    hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", createPercentHPFrame)
    hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", createDispellableFrame)
end

if CompactUnitFrame_UpdateHealth then
    hooksecurefunc("CompactUnitFrame_UpdateHealth", updateHPPercent)
end

if CompactUnitFrame_UpdateAuras then
    hooksecurefunc("CompactUnitFrame_UpdateAuras", updateDispellableBuffs)
end

if CompactUnitFrame_UpdateName then
    hooksecurefunc("CompactUnitFrame_UpdateName", updateDispellableFramePosition)
end