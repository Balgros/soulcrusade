local ADDON_NAME = ...

local frame = CreateFrame("Frame")

local function isGuildTradeAllowed()
  if not IsInGuild() then
    return false
  end

  if not UnitExists("target") then
    return false
  end

  return UnitIsInMyGuild("target")
end

local function blockTrade(reason)
  CancelTrade()
  UIErrorsFrame:AddMessage(
    string.format("%s: Trade blocked (%s).", ADDON_NAME, reason),
    1.0,
    0.1,
    0.1,
    1.0
  )
end

frame:SetScript("OnEvent", function(_, event)
  if event == "TRADE_SHOW" then
    if not isGuildTradeAllowed() then
      if not IsInGuild() then
        blockTrade("not in a guild")
      elseif not UnitExists("target") then
        blockTrade("no target")
      else
        blockTrade("target not in guild")
      end
    end
  end
end)

frame:RegisterEvent("TRADE_SHOW")
