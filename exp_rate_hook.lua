local function OnGiveXP(event, player, amount, victim)
    local controller = ExpRateController:GetInstance()
    local rate = controller:GetRate(player)


    local adjustedXP = amount
    if victim and victim:IsInDungeon() then
        adjustedXP = math.floor(amount * rate)
        player:SendBroadcastMessage("You earned " .. adjustedXP .. " XP in a dungeon with a " .. rate .. "x rate!")
    else
        adjustedXP = math.floor(amount * rate)
    end


    player:GiveXP(adjustedXP)

    return false 
end


local function OnQuestReward(event, player, quest, xp)
    local controller = ExpRateController:GetInstance()
    local rate = controller:GetRate(player)

    local adjustedXP = math.floor(xp * rate)
    player:GiveXP(adjustedXP)


    player:SendBroadcastMessage("Quest completed! You earned " .. adjustedXP .. " XP with a " .. rate .. "x rate!")
    return false 
end

-- Enregistrement des hooks
RegisterPlayerEvent(12, OnGiveXP) 
RegisterPlayerEvent(28, OnQuestReward) 
