# Class in Lua

* A tiny class module for Lua. Attempts to stay simple and provide decent
performance by avoiding unnecessary over-abstraction.

* Can work perfectly with Lua's Intellisense and Autocompletion with extension [Lua by sumneko](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)


## Usage

The [module](classic.lua) should be dropped in to an existing project and
required by it:

```lua
Object = require "class"
```

The module returns the object base class which can be extended to create any
additional classes.


### Creating a new class
```lua
Point = Object:extend()

function Point:new(x, y)
  local obj = setmetatable({}, self)
  obj.x = x or 0
  obj.y = y or 0

  return obj
end
```

### Creating a new object
```lua
local p = Point:new(10, 20)
```

### Extending an existing class
```lua
Rect = Point:extend()

function Rect:new(x, y, width, height)
  local obj = Rect.super.new(self, x, y)
  obj.width = width or 0
  obj.height = height or 0

  return obj
end
```

### Checking an object's type
```lua
local p = Point:new(10, 20)
print(p:is(Object)) -- true
print(p:is(Point)) -- true
print(p:is(Rect)) -- false 
```

### Using interfaces
```lua
PairPrinter = Object:extend()

function PairPrinter:printPairs()
  for k, v in pairs(self) do
    print(k, v)
  end
end


Point = Object:extend()
Point:implement(PairPrinter)

function Point:new(x, y)
  local obj = setmetatable({}, self)
  obj.x = x or 0
  obj.y = y or 0

  return obj
end


local p = Point:new()
p:printPairs()
```

### Using static variables
```lua
Point = Object:extend()
Point.scale = 2

function Point:new(x, y)
  local obj = setmetatable({}, self)
  obj.x = x or 0
  obj.y = y or 0

  return obj
end

function Point:getScaled()
  return self.x * Point.scale, self.y * Point.scale
end
```

### Creating a metamethod
```lua
function Point:__tostring()
  return self.x .. ", " .. self.y
end
```


## License

This module is free software; you can redistribute it and/or modify it under
the terms of the MIT license. See [LICENSE](LICENSE) for details.

