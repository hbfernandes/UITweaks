local addon, ns = ...

-- Nameplate font sizes
-- https://www.townlong-yak.com/framexml/live/SharedFontStyles.xml
-- https://www.townlong-yak.com/framexml/live/FontStyles.xml
SystemFont_LargeNamePlateFixed:SetFontObject(GameFontNormalMed1)
ChatBubbleFont:SetFontObject(GameFontNormalOutline)

-- Display health percentage on healthbar

local function createPercentHPFrame(nameplate)
    if nameplate:IsForbidden() or nameplate.hpPercent then return end
    
    nameplate.hpPercent = nameplate.healthBar:CreateFontString(nil, "OVERLAY", "TextStatusBarText")
    nameplate.hpPercent:SetAllPoints(true)    
end

local function updateHPPercent(nameplate)
    if nameplate.hpPercent then
        nameplate.hpPercent:SetText(ceil((UnitHealth(nameplate.displayedUnit) / UnitHealthMax(nameplate.displayedUnit) * 100)).."%")
    end
end


-- Dispellable buffs above nameplate

local maxShownBuffs = 3
local buffWidth = 20
local buffHeight = 15

local function createBuffFrame(nameplate, index)
    local buffFrame = CreateFrame("Frame", nil, nameplate, "NameplateBuffButtonTemplate")

    buffFrame:SetShown(false)
    buffFrame:SetID(index)
    buffFrame:SetPoint("BOTTOMRIGHT", nameplate.dispellable, "BOTTOMLEFT", 0 - buffWidth * (index - 1), 0)

    tinsert(nameplate.dispellable.buffs, buffFrame)
    return buffFrame
end

local function updateDispellableFramePosition(nameplate)
    if not nameplate.dispellable then return end
    
    if nameplate.name:IsShown() then
        nameplate.dispellable:SetPoint("BOTTOMRIGHT", nameplate.healthBar, "TOPRIGHT", 3, 24)
    else
        nameplate.dispellable:SetPoint("BOTTOMRIGHT", nameplate.healthBar, "TOPRIGHT", 3, 2)
    end
end

local function updateDispellableBuffs(nameplate)
    if not nameplate.dispellable then return end

    local reaction = UnitReaction("player", nameplate.displayedUnit)  -- 4 is neutral, less more hostile
    if not reaction or reaction > 4 then
        return
    end
    
    local buffFrame, name, icon, count, buffType, duration, expirationTime, stealable
    local shownBuffsIndex = 1
    local index = 1
    
    -- Check the new AuraUtil.ForEachAura comin in shadowlands

    while shownBuffsIndex <= maxShownBuffs do
        -- name, icon, count, buffType, duration, expirationTime, _, stealable = UnitDebuff(nameplate.displayedUnit, index, nil)
        name, icon, count, buffType, duration, expirationTime, _, stealable = UnitBuff(nameplate.displayedUnit, index, nil)
        
        if name then
            -- print(name, buffType, stealable)
            if buffType == "Magic" or (stealable and ns.class == "MAGE") then                                    
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
                    if stealable and ns.class == "MAGE" then
                        ActionButton_ShowOverlayGlow(buffFrame)
                    else
                        ActionButton_HideOverlayGlow(buffFrame)
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
    if nameplate:IsForbidden() or nameplate.dispellable then return end

    -- print("Creating for", nameplate:GetName())

    nameplate.dispellable = CreateFrame("Frame", nil, nameplate)
    nameplate.dispellable:SetWidth(1)
    nameplate.dispellable:SetHeight(1)

    nameplate.dispellable.buffs = {}
end


-- Aggro indicator on nameplate

local function updateAggroIndicator(nameplate)
    if not nameplate.aggro then return end
    
    local status = UnitThreatSituation("player", nameplate.displayedUnit)
    if not status or not IsInGroup() then 
        nameplate.aggro:Hide()    
        return 
    end
        
    -- print(nameplate.displayedUnit, status)
    if status > 0  then
        if ns:tanking() then
            nameplate.aggro:Hide()    
        else
            nameplate.aggro:Show()
        end
    else
        if ns:tanking() then
            nameplate.aggro:Show()
        else
            nameplate.aggro:Hide()    
        end
    end
end

local function createAggroFrame(nameplate)
    if nameplate:IsForbidden() or nameplate.aggro then return end
    
    nameplate.aggro = CreateFrame("Frame", nil, nameplate)
    nameplate.aggro:SetWidth(22)
    nameplate.aggro:SetHeight(22)
    nameplate.aggro:SetPoint("LEFT", nameplate, "RIGHT", -7, 0) -- 2 if other icons
    
    nameplate.aggro.texture = nameplate.aggro:CreateTexture(nil, "OVERLAY")
    nameplate.aggro.texture:SetAllPoints(nameplate.aggro)
    -- nameplate.aggro.texture:SetTexture("137008")    
    nameplate.aggro.texture:SetTexture("Interface/GossipFrame/AvailableQuestIcon")
    nameplate.aggro.texture:SetVertexColor(1, 0, 0)    
    
    -- if ns:tanking() then 
    --     nameplate.aggro.texture:SetTexture("895885")    
    -- else
    --     nameplate.aggro.texture:SetTexture("1357795")    
    -- end
end


-- Hook it up

if DefaultCompactNamePlateFrameSetupInternal then
    hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", createPercentHPFrame)
    hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", createDispellableFrame)
    hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", createAggroFrame)
else
    print("Missing 'DefaultCompactNamePlateFrameSetupInternal' to hook on!")
end

if CompactUnitFrame_UpdateHealth then
    hooksecurefunc("CompactUnitFrame_UpdateHealth", updateHPPercent)
else
    print("Missing 'CompactUnitFrame_UpdateHealth' to hook on!")
end

if CompactUnitFrame_UpdateAuras then
    hooksecurefunc("CompactUnitFrame_UpdateAuras", updateDispellableBuffs)
else
    print("Missing 'CompactUnitFrame_UpdateAuras' to hook on!")
end

if CompactUnitFrame_UpdateName then
    hooksecurefunc("CompactUnitFrame_UpdateName", updateDispellableFramePosition)
else
    print("Missing 'CompactUnitFrame_UpdateName' to hook on!")
end

if CompactUnitFrame_UpdateAggroFlash then
    hooksecurefunc("CompactUnitFrame_UpdateAggroFlash", updateAggroIndicator)
else
    print("Missing 'CompactUnitFrame_UpdateAggroFlash' to hook on!")
end

