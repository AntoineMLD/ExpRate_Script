ExpRateController = {}
ExpRateController.__index = ExpRateController

function ExpRateController:GetInstance()
    if not self.instance then
        self.instance = setmetatable({}, ExpRateController)
        self.model = ExpRateModel
    end
    return self.instance
end

function ExpRateController:OnRateChanged(player, rate)
    if rate >= 1 and rate <= 5 then
        self.model:SetRate(player, rate) 
        player:SendBroadcastMessage("Experience rate set to " .. rate .. "x!")
    else
        player:SendBroadcastMessage("Invalid rate. Please select a value between 1 and 5.")
    end
end

function ExpRateController:GetRate(player)
    return self.model:GetRate(player) 
end


function ExpRateController:ApplyRate(player, baseXP)
    local rate = self:GetRate(player) 
    local adjustedXP = baseXP * rate 
    return adjustedXP, rate 
end
