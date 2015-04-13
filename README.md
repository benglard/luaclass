# luaclass - Easy Classes for Lua

Typical OOP in Lua looks something like this:

```lua
local Class = {}

function Class:new( o )
   o = o or {}
   setmetatable( o, self )
   self.__index = self
   return o
end

return Class
```

with [torch/class](https://github.com/torch/class) it looks something like this:

```lua
local B = class('B', 'A')

function B:__init(stuff)
   A.__init(self, stuff) -- call the parent init
end

function B:run5()
   for i=1,5 do
      print(self.stuff)
   end
end
```

with luaclass, it looks something like this:

```lua
local Test = Class({
   var = 5,

   __init__ = function(self, p1, p2, p3)
      self.stuff = {p1, p2, p3}
   end,

   test = function(self)
      print(self.var, self.stuff)
   end
})

local c = Test(1,2,3)
c:test()
```

I like the style of the last way :). Thoughts, feedback, and contributions are all welcome.