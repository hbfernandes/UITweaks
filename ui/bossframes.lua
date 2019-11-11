-- Boss frames rescale and reposition
local bossFrameScale = 0.85

for i = 1, 5 do
    local bframe = _G["Boss"..i.."TargetFrame"]

    bframe:SetScale(bossFrameScale)
    if i > 1 then
        local point, relativeTo, relativePoint, xofs, _ = bframe:GetPoint()
        bframe:ClearAllPoints()
        bframe:SetPoint(point, relativeTo, relativePoint, xofs, 0)
    end
end

--[[
_G["SLASH_TESTBOSS1"] = "/testboss"
SlashCmdList["TESTBOSS"] = function()
]]--
--[[
    for i = 1, 5 do
        local bf = _G["Boss"..i.."TargetFrame"]
        bf.unit = "player"
        TargetFrame_Update(_G["Boss"..i.."TargetFrame"]);
    end
]]--
-- end

