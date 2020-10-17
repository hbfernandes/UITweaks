--- Info frames ---

local addon, ns = ...

-- Frames
local infoFrame = CreateFrame("Button")
infoFrame:SetWidth(100)
infoFrame:SetHeight(16)
infoFrame:SetPoint("TOP", UIParent, "TOP", 0, 0)
infoFrame:RegisterForClicks("LeftButtonUp")

infoFrame.zoneText = infoFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
infoFrame.zoneText:SetFont("FONTS\\FRIZQT__.TTF", 10, "NORMAL")
infoFrame.zoneText:SetPoint("CENTER", infoFrame, "CENTER", 0, 0.5)
infoFrame.zoneText:SetHeight(infoFrame:GetHeight())
infoFrame.zoneText:SetWidth(400)

--- Functions


--- Events

local function infoFrame_OnEvent(self, event, ...)
    local zone, subzone = GetZoneText(), GetSubZoneText()
    if zone == subzone or subzone == "" then
        self.zoneText:SetText(zone)
    else
        self.zoneText:SetText(zone..": "..subzone)
    end
end


infoFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
infoFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
infoFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
infoFrame:RegisterEvent("ZONE_CHANGED")
infoFrame:HookScript("OnEvent", infoFrame_OnEvent)




-- test crap

-- infoFrame.portalFrame = CreateFrame("Frame", addon.."PortalFrame", infoFrame, "TooltipBorderBackdropTemplate")
-- infoFrame.portalFrame:SetWidth(200)
-- infoFrame.portalFrame:SetHeight(400)
-- infoFrame.portalFrame:SetPoint("TOP", infoFrame, "BOTTOM", 0, -2)
-- infoFrame.portalFrame:Hide()

-- infoFrame.portalFrame:SetBackdrop({
-- 	bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
-- 	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
-- 	tile = true,
-- 	tileEdge = true,
-- 	tileSize = 8,
-- 	edgeSize = 8,
-- 	insets = { left = 1, right = 1, top = 1, bottom = 1 }
-- })


-- local portals


-- local function SetupSpells()
--     local spells = {
--         Alliance = {
--             { 3561, 10059 },    -- TP:Stormwind
--             { 3562, 11416 },    -- TP:Ironforge
--             { 3565, 11419 },    -- TP:Darnassus
--             { 32271, 32266 },   -- TP:Exodar
--             { 49359, 49360 },   -- TP:Theramore
--             { 33690, 33691 },   -- TP:Shattrath
--             { 53140, 53142 },   -- TP:Dalaran
--             { 88342, 88345 },   -- TP:Tol Barad
--             { 132621, 132620 }, -- TP:Vale of Eternal Blossoms
--             { 120145, 120146 }, -- TP:Ancient Dalaran
--             { 176248, 176246 }, -- TP:StormShield
--             { 224869, 224871 }, -- TP:Dalaran - Broken Isles
--             { 193759, nil },    -- TP:Hall of the Guardian
--             { 281403, 281400 }, -- TP:Boralus
--         },
--         Horde = {
--             { 3563, 11418 },    -- TP:Undercity
--             { 3566, 11420 },    -- TP:Thunder Bluff
--             { 3567, 11417 },    -- TP:Orgrimmar
--             { 32272, 32267 },   -- TP:Silvermoon
--             { 49358, 49361 },   -- TP:Stonard
--             { 35715, 35717 },   -- TP:Shattrath
--             { 53140, 53142 },   -- TP:Dalaran
--             { 88344, 88346 },   -- TP:Tol Barad
--             { 132627, 132626 }, -- TP:Vale of Eternal Blossoms
--             { 120145, 120146 }, -- TP:Ancient Dalaran
--             { 176242, 176244 }, -- TP:Warspear
--             { 224869, 224871 }, -- TP:Dalaran - Broken Isles
--             { 193759, nil },    -- TP:Hall of the Guardian
--             { 281404, 281402 }, -- TP:Dazar'alor
--         }
--     }

--     local _, class = UnitClass('player')
--     if class == 'MAGE' then
--         portals = spells[select(1, UnitFactionGroup('player'))]
--     elseif class == 'DEATHKNIGHT' then
--         portals = {
--             { 50977, nil }      -- Death Gate
--         }
--     elseif class == 'DRUID' then
--         portals = {
--             { 18960,  nil },    -- TP:Moonglade
--             { 147420, nil },    -- TP:One with Nature
--             { 193753, nil }     -- TP:Dreamwalk
--         }
--     elseif class == 'SHAMAN' then
--         portals = {
--             { 556, nil }        -- Astral Recall
--         }
--     elseif class == nil then
--         portals = {
--             { 126892, nil },    -- Zen Pilgrimage
--             { 126895, nil }     -- Zen Pilgrimage: Return
--         }
--     else
--         portals = {}
--     end

--     local _, race = UnitRace('player')
--     if race == 'DarkIronDwarf' then
--         table.insert(portals, { 265225 }) -- Mole Machine
--     end

--     wipe(spells)
-- end

-- SetupSpells()

-- function findSpell(spellName)
--     local i = 1
--     while true do
--         local s = GetSpellBookItemName(i, BOOKTYPE_SPELL)
--         if not s then
--             break
--         end

--         if s == spellName then
--             local slotType, actionID = GetSpellBookItemInfo(i, BOOKTYPE_SPELL)
--             print(s, i, slotType, actionID)
--             return i
--         end

--         i = i + 1
--     end
-- end


-- local function castit(spellId)
--     securecall("CastSpellByID", spellId)
-- end


-- for i, teleport in ipairs(portals) do
--     local name, _, icon = GetSpellInfo(teleport[1])

--     local item =  CreateFrame("Button", nil, infoFrame.portalFrame, "SecureActionButtonTemplate")
--     item:SetPoint("TOP", infoFrame.portalFrame, "TOP", 0, - (10 + (i-1)*22) ) 
--     item:SetHeight(22)
--     item:SetWidth(175)    
--     item:SetText(name:gsub("%Teleport:", ""):gsub("%  ", " "))
--     item:RegisterForClicks("AnyUp")
--     -- print("SpellButton"..findSpell(name))    

    
--     item:HookScript("OnClick", function(self, button)
                   
--         -- end
--         castit(teleport[1])

--         -- print(slot)
--         infoFrame.portalFrame:Hide()
--     end)
-- end


-- tinsert(UISpecialFrames, infoFrame.portalFrame:GetName())