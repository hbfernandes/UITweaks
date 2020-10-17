-------------------------------------------
-- Personal CVAR and other config tweaks --
-------------------------------------------

-- nameplate settings
SetCVar("NamePlateVerticalScale", 2.7) -- use large nameplates

SetCVar("nameplateMotion", 1)               -- default 0 (overlapping)
SetCVar("nameplateOverlapV", 0.6)           -- default 1.1
SetCVar("nameplateSelectedScale", 1)        -- default 1.2
SetCVar("nameplateMinScale", 1)             -- default 0.8
SetCVar("nameplateOtherTopInset", 0.08)     -- default 0.08
SetCVar("nameplateOtherBottomInset", 0)     -- default 0.1
SetCVar("showTargetCastbar", 1)             -- default 1
SetCVar("nameplateMinAlpha", 0.8)           -- default 0.6
SetCVar("nameplateGlobalScale", 0.85)       -- default 1.0
SetCVar("nameplateOccludedAlphaMult", 0.4)  -- default 0.4

SetCVar("nameplateShowSelf", 0)             -- default 1 (show resource mid screen)

-- camera
SetCVar("cameraDistanceMaxZoomFactor", 2.6) -- default 1.9

-- Status text
SetCVar("statusTextDisplay", "BOTH")
SetCVar("threatShowNumeric", 1)

-- UI scale
SetCVar("useUiScale", 1)
SetCVar("uiScale", 0.85)

-- Loot to the left bag
SetInsertItemsLeftToRight(true)
SetSortBagsRightToLeft(true)

SetCVar("chatMouseScroll", 1)