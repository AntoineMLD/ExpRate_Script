ExpRateView = {}
ExpRateView.__index = ExpRateView

local PNJ_ID = 380 

local instance = nil -- Singleton instance

function ExpRateView:GetInstance()
    if not instance then
        instance = setmetatable({}, ExpRateView)
    end
    return instance
end


function ExpRateView:SendConfirmation(player, adjustedXP, rate)
    player:SendBroadcastMessage("You gained " .. adjustedXP .. " XP with a " .. rate .. "x rate!")
end


function ExpRateView:OnGossipHello(event, player, creature)
    print("OnGossipHello called for player: " .. player:GetName())
    local controller = ExpRateController:GetInstance()
    local currentRate = controller:GetRate(player)

    player:GossipMenuAddItem(0, "Current rate: " .. currentRate .. "x", 1, 0)
    player:GossipMenuAddItem(0, "Set experience rate to 1x", 1, 1)
    player:GossipMenuAddItem(0, "Set experience rate to 2x", 1, 2)
    player:GossipMenuAddItem(0, "Set experience rate to 3x", 1, 3)
    player:GossipMenuAddItem(0, "Set experience rate to 4x", 1, 4)
    player:GossipMenuAddItem(0, "Set experience rate to 5x", 1, 5)
    player:GossipSendMenu(1, creature)
end

function ExpRateView:OnGossipSelect(event, player, creature, sender, intid, code)
    local controller = ExpRateController:GetInstance()
    if intid > 0 then
        controller:OnRateChanged(player, intid)
    end
    player:GossipComplete()
end

if not _G.ExpRateView_Registered then
    _G.ExpRateView_Registered = true
    RegisterCreatureGossipEvent(PNJ_ID, 1, function(...) ExpRateView:GetInstance():OnGossipHello(...) end)
    RegisterCreatureGossipEvent(PNJ_ID, 2, function(...) ExpRateView:GetInstance():OnGossipSelect(...) end)
end