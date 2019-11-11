-- nameplate settings
-- this assumes using large nameplates
SetCVar("nameplateMotion", 1)
SetCVar("nameplateOverlapV", 0.5)
SetCVar("nameplateSelectedScale", 1)
SetCVar("nameplateMinScale", 1)
SetCVar("nameplateOtherTopInset", -1)
SetCVar("nameplateOtherBottomInset", 0)
SetCVar("nameplateMinAlpha", 0.8)
SetCVar("nameplateGlobalScale", 0.85)

-- nameplate font sizes
local npFontFamily = SystemFont_LargeNamePlateFixed
local fontName, _, _ = npFontFamily:GetFont()

npFontFamily:SetFont(fontName, 14, "NONE")

if DefaultCompactNamePlateFrameSetupInternal then
    hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", function(frame, setupOptions, frameOptions)      
        if not frame:IsForbidden() then
            -- cast bar smaller (SystemFont_NamePlateCastBar)
            --frame.castBar:SetScale(0.9)

            -- create health display frames
            if not frame.health then
                frame.health = CreateFrame("Frame", nil, frame)
                frame.health:SetSize(frame:GetSize())
                frame.health.text = frame.health.text or frame.health:CreateFontString(nil, "OVERLAY")
                frame.health.text:SetAllPoints(true)
                frame.health:SetFrameStrata("HIGH")
                frame.health:SetPoint("CENTER", frame.healthBar)
                frame.health.text:SetVertexColor(1, 1, 1)

                -- If 'Larger Nameplates' option is enabled.
                if InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() == "1" then 
                    frame.health.text:SetFont("FONTS\\FRIZQT__.TTF", 10, "OUTLINE")
                else
                    frame.health.text:SetFont("FONTS\\FRIZQT__.TTF", 8, "OUTLINE")
                end                
            end
        end        
    end)
end

-- From https://eu.battle.net/forums/en/wow/topic/17616672145
if CompactUnitFrame_UpdateHealth then
    hooksecurefunc("CompactUnitFrame_UpdateHealth", function(frame)
        if (not frame:IsForbidden() and string.match(frame:GetName(), "NamePlate%d+UnitFrame")) then
            -- update a percentage value for health.
            local healthPercentage = ceil((UnitHealth(frame.displayedUnit) / UnitHealthMax(frame.displayedUnit) * 100))
            frame.health.text:SetText(healthPercentage .. "%")
        end
    end)
end