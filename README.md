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
local A = class('A')

function A:__init(stuff)
  self.stuff = stuff
end

function A:run()
  print(self.stuff)
end
```

with luaclass it looks something like this:

```lua
local Test = Class {
   var = 5,

   __init__ = function(self, p1, p2, p3)
      self.stuff = {p1, p2, p3}
   end,

   test = function(self)
      print(self.var, self.stuff)
   end
}

local c = Test(1,2,3)
c:test()
```

I like the style of the last way :) (because of the table-based format).

## Subclasses

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

with luaclass it looks something like this:

```lua
local Thing = Class {
   name = '',

   __init__ = function(self, name)
      self.name = name
   end,

   __tostring = function(self)
      return tostring(self.name)
   end
}

local Person = Class({
   talk = function(self)
      print(string.format('Hello, my name is %s', self.name))
   end
}, Thing)

local t = Thing('one')
local p = Person('A')

print(t)
print(p)
p:talk()
print(pcall(t.talk, t))
```

Thoughts, feedback, and contributions are all welcome.