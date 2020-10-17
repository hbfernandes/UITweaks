local addon, ns = ...

local waitTable = {}
local waitFrame = nil

-- Global Vars

ns.class = UnitClassBase("player")

-- Global Functions

function ns:wait(delay, func, ...)
  if type(delay) ~= "number" or type(func) ~= "function" then
    return false
  end

  if(waitFrame == nil) then
    waitFrame = CreateFrame("Frame")
    waitFrame:SetScript("onUpdate", function (self, elapse)
      local count = #waitTable
      local i = 1
      while i <= count do
        local waitRecord = tremove(waitTable, i)
        local d = tremove(waitRecord, 1)
        local f = tremove(waitRecord, 1)
        local p = tremove(waitRecord, 1)
        if d > elapse then
          tinsert(waitTable, i, {d-elapse, f, p} )
          i = i + 1
        else
          count = count - 1
          f(unpack(p))
        end
      end
    end)
  end
  tinsert(waitTable, {delay, func, {...}})
  return true
end

function ns:infoFrameSetText(frame, text)
    frame:SetText(text)
    frame:SetWidth(string.len(text) * 8)
end

-- Global Frames

ns.infoFrame = CreateFrame("Frame", nil, UIParent)
ns.infoFrame:SetPoint("TOP", UIParent, "TOP", 0, 0)
ns.infoFrame:SetWidth(UIParent:GetWidth())
ns.infoFrame:SetHeight(18)
