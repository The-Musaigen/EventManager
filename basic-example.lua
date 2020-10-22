local eventManager = require("eventManager")

-- Create an instance of our event
local someEvent = eventManager:MakeEvent("SomeEvent", function(t, a, b)
    t.a = a
    t.b = b
end)

-- Our handler
function mul(event)
    print(event.a * event.b)
end

-- Add a handler to our event
eventManager:AddEventHandler("SomeEvent", mul)

-- Calling!
eventManager:CallEvent(someEvent(5, 5))
-- Output: 25
