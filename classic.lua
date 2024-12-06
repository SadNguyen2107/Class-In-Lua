---
--- classic
---
--- Copyright (c) 2014, rxi
---
--- This module is free software; you can redistribute it and/or modify it under
--- the terms of the MIT license. See LICENSE for details.
---

--- @class Object
--- A base class that supports the `extend`, `implement`, and `is` functionalities.
--- @field super Object|nil # A reference to the parent class (if extended).
local Object = {}
Object.__index = Object

--- Default constructor for an Object.
function Object:new(...)
end

--- Creates a subclass of the current class.
--- @return table # A new subclass of Object.
function Object:extend()
    local cls = {}
    for k, v in pairs(self) do
        if k:find("^__") then -- Copy only metamethods starting with "__"
            cls[k] = v
        end
    end
    cls.__index = cls
    cls.super = self -- Reference to the parent class
    setmetatable(cls, self)
    return cls
end

--- Implements the methods from other classes into the current class.
--- @vararg table # A list of classes whose methods will be implemented.
function Object:implement(...)
    for _, cls in ipairs({ ... }) do
        for k, v in pairs(cls) do
            if self[k] == nil and type(v) == "function" then
                self[k] = v
            end
        end
    end
end

--- Checks if the current object is an instance of the given class.
--- @param T table # The class to check against.
--- @return boolean # True if the object is an instance of T, otherwise false.
function Object:is(T)
    local mt = getmetatable(self)
    while mt do
        if mt == T then
            return true
        end
        mt = getmetatable(mt)
    end
    return false
end

--- Returns a string representation of the Object.
--- @return string
function Object:__tostring()
    return "Object"
end

--- Creates a new instance of the class when called.
--- @return table # A new instance of the class.
function Object:__call(...)
    local obj = setmetatable({}, self)
    obj:new(...)
    return obj
end

return Object
