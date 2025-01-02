local function OnGiveXP(event, player, amount, victim)
    local controller = ExpRateController:GetInstance()
    local rate = controller:GetRate(player)


    local adjustedXP = math.floor(amount * rate)
    player:GiveXP(adjustedXP)


    if victim and victim:IsInDungeon() then
        player:SendBroadcastMessage("You earned " .. adjustedXP .. " XP in a dungeon with a " .. rate .. "x rate!")
    else
        player:SendBroadcastMessage("You earned " .. adjustedXP .. " XP with a " .. rate .. "x rate!")
    end

    return false 
end

local function OnQuestReward(event, player, quest, xp)
    local controller = ExpRateController:GetInstance()
    local rate = controller:GetRate(player)


    local adjustedXP = math.floor(xp * rate)
    player:GiveXP(adjustedXP)

    -- Message de confirmation
    player:SendBroadcastMessage("Quest completed! You earned " .. adjustedXP .. " XP with a " .. rate .. "x rate!")
    return false 
end


RegisterPlayerEvent(12, OnGiveXP) 
RegisterPlayerEvent(28, OnQuestReward) 
