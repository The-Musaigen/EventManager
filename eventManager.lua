local mod = {
    handlers = {}
}

--- Creating a event instance
---@param name string Name of event
---@param constructor function Constructor of event
---@return table
function mod:MakeEvent(name, constructor)
    local mt = {}

    mt.__tostring = function()
        return name
    end
    mt.__call = function(_, ...)
        local t = setmetatable({}, mt)
        constructor(t, ...)
        return t
    end

    return setmetatable({}, mt)
end

--- Adding a handler to the specific event
---@param eventName string Name of specific event
---@param handler function Our handler
---@return number The id of the handler
function mod:AddEventHandler(eventName, handler)
    if not self.handlers[eventName] then
        self.handlers[eventName] = {}
    end
    table.insert(self.handlers[eventName], handler)
    return #self.handlers[eventName]
end

--- Removing a handler from specific event
---@param eventName string Event name
---@param handler function Our handler
function mod:RemoveHandler(eventName, handler)
    for key, eventHandler in pairs(self.handlers[eventName]) do
        if handler == eventHandler then
            table.remove(self.handlers[eventName], key)
        end
    end
end

--- Removing a handler from specific event
---@param eventName string Event name
---@param id number Our handler id
function mod:RemoveHandlerById(eventName, id)
    table.remove(self.handlers[eventName], id)
end

--- Calling the event handlers
---@param instance table Event instance
function mod:CallEvent(instance)
    for _, handler in pairs(self.handlers[tostring(instance)]) do
        handler(instance)
    end
end

return mod
