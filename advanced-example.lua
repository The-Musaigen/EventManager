local eventManager = require("eventManager")

local eventMotion = eventManager:MakeEvent("EventMotion", function(t, entityId, mX, mY, mZ)
    t.id = entityId
    t.speedX = mX
    t.speedY = mY
    t.speedZ = mZ
end)

local player = {
    onMotion = function(event)
        -- idk what to add here
        event.speedX = event.speedX - 2
    end
}

local handlerId = eventManager:AddEventHandler("EventMotion", player.onMotion)

if world:IsEntityExist(LOCAL_PLAYER_ENTITY_ID) and controller:IsPressedWASD() then
    local motion = eventMotion(LOCAL_PLAYER_ENTITY_ID, 2, 2, 3)
    print(motion.speedX) -- Output: 2
    eventManager:CallEvent(motion)
    print(motion.speedX) -- Output: 0
end

-- Somewhere
eventManager:RemoveHandlerById("EventMotion", handlerId)
-- or
eventManager:RemoveHandler("EventMotion", player.onMotion)

