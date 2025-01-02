ExpRateModel = {}
ExpRateModel.__index = ExpRateModel

function ExpRateModel:GetRate(player)
    local query = string.format("SELECT `rate` FROM `player_exp_rates` WHERE `player_guid` = %d", player:GetGUIDLow())
    local result = CharDBQuery(query) 
    if result then
        return result:GetInt32(0)
    else
        return 1
    end
end

function ExpRateModel:SetRate(player, rate)
    local query = string.format("REPLACE INTO `player_exp_rates` (`player_guid`, `rate`) VALUES (%d, %d)", player:GetGUIDLow(), rate)
    CharDBExecute(query) 
end
