local addon, ns = ...

if not ns.backgrounds then return end

local infoFrameBack = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
infoFrameBack:SetPoint("TOP", UIParent, "TOP", 0, 6)
infoFrameBack:SetWidth(ns.infoFrame:GetWidth() + 10)
infoFrameBack:SetHeight(ns.infoFrame:GetHeight() + 8)

infoFrameBack:SetFrameStrata("BACKGROUND")
infoFrameBack:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileEdge = true,
    tileSize = 8,
    edgeSize = 8,
    insets = { left = 1, right = 1, top = 1, bottom = 1}
})

-- ns.bottomFrame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
-- ns.bottomFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 0)
-- ns.bottomFrame:SetFrameStrata("BACKGROUND")
-- ns.bottomFrame:SetWidth(UIParent:GetWidth())
-- ns.bottomFrame:SetHeight(130)

-- ns.bottomFrame:SetBackdrop({
--   bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
--   -- edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
--   tile = true,
--   tileEdge = true,
--   tileSize = 8,
--   edgeSize = 8,
--   insets = { left = -5, right = -5, top = -1, bottom = -5}
-- })