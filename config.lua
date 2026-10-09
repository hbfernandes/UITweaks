local addon, ns = ...

ns.backgrounds = false


-------------------------------------------
-- Personal CVAR and other config tweaks --
-------------------------------------------

-- nameplate settings
SetCVar("NamePlateVerticalScale", 2.7)      -- use large nameplates

SetCVar("nameplateMotion", 1)               -- default 0 (overlapping)
SetCVar("nameplateOverlapV", 0.6)           -- default 1.1
SetCVar("nameplateSelectedScale", 1)        -- default 1.2
SetCVar("nameplateMinScale", 1)             -- default 0.8
SetCVar("nameplateOtherTopInset", 0.06)     -- default 0.08
SetCVar("nameplateOtherBottomInset", 0)     -- default 0.1
SetCVar("showTargetCastbar", 1)             -- default 1
SetCVar("nameplateMinAlpha", 0.8)           -- default 0.6
SetCVar("nameplateGlobalScale", 0.8)        -- default 1.0
SetCVar("nameplateOccludedAlphaMult", 0.4)  -- default 0.4

SetCVar("nameplateShowSelf", 0)             -- default 1 (show resource mid screen)

-- camera
SetCVar("cameraDistanceMaxZoomFactor", 2.6) -- default 1.9
SetCVar("cameraYawModeSpeed", 75) -- default 180 - UI min is 90

-- Status text
SetCVar("statusTextDisplay", "BOTH")
SetCVar("threatShowNumeric", 1)

-- UI scale
--SetCVar("useUiScale", 1)
--SetCVar("uiScale", 0.80)

-- Loot to the left bag
C_Container.SetSortBagsRightToLeft(true) 
C_Container.SetInsertItemsLeftToRight(false)


SetCVar("chatMouseScroll", 1)
SetCVar("chatStyle", "classic")
SetCVar("whisperMode", "inline")

