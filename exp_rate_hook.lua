local function OnGiveXP(event, player, amount, victim)
    local controller = ExpRateController:GetInstance()
    local rate = controller and controller:GetRate(player) or 1

    if amount == nil then
        print("[ERROR] 'amount' is nil in OnGiveXP.")
        return false
    end

    if rate == nil then
        print("[ERROR] 'rate' is nil in OnGiveXP. Defaulting to 1.")
        rate = 1
    end

    local adjustedXP = math.floor(amount * rate)
    print(string.format("[DEBUG] OnGiveXP: Player: %s, Original XP: %d, Rate: %.2f, Adjusted XP: %d", 
                        player:GetName(), amount, rate, adjustedXP))
    
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
    local rate = controller and controller:GetRate(player) or 1

    if xp == nil then
        print("[ERROR] 'xp' is nil in OnQuestReward.")
        return false
    end

    if rate == nil then
        print("[ERROR] 'rate' is nil in OnQuestReward. Defaulting to 1.")
        rate = 1
    end

    local adjustedXP = math.floor(xp * rate)
    print(string.format("[DEBUG] OnQuestReward: Player: %s, Quest: %s, Original XP: %d, Rate: %.2f, Adjusted XP: %d",
                        player:GetName(), quest:GetTitle(), xp, rate, adjustedXP))

    player:GiveXP(adjustedXP)

    player:SendBroadcastMessage("Quest completed! You earned " .. adjustedXP .. " XP with a " .. rate .. "x rate!")
    return false
end

-- Register events
RegisterPlayerEvent(12, OnGiveXP)
RegisterPlayerEvent(28, OnQuestReward)
