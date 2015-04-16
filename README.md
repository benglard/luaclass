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

I like the style of the last way :) (because of the table-based format). This style is possible because Lua allows for the removal of parentheses in function calls with a single table argument. Behind the scenes, the Class function is fairly simple (only 21 lines of code). All it does is create a metatable for the table argument with __call defined to initiate a class/its parent classes (with their own metatables if applicable).

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

## Larger Example
```lua
require '../luaclass'

local List = Class {
   __init__ = function(self)
      self.l = {}
   end,

   append = function(self, value)
      table.insert(self.l, value)
   end,

   __index = function(self, idx)
      return self.l[idx]
   end,

   collect = function(self) return next, self.l end,

   __tostring = function(self)
      local rv = '['
      local size = #self.l
      for key, val in pairs(self.l) do
         local delim
         if key == size then delim = ''
         else delim = ', ' end
         rv = rv .. tostring(val) .. delim
      end
      rv = rv .. ']'
      return rv
   end,

   __len = function(self) return #self.l end,

   __call = function(self)
      local i, v = next(self.l, self.idx)
      self.idx = i
      return v
   end,

   iter = Generator( -- coroutine
      function(self)
         for key, val in pairs(self.l) do
            yield(val)
         end
      end
   )
}

local l = List()
for i = 1, 5 do l:append(i) end
print(l)
print(l[1], l[2], l[100])

for val in l:collect() do
   print(val)
end

for val in l do
   print(val)
end
print(l()) --restarts at index 1
print(l())

while true do
   local rv = l:iter()
   if rv == nil then break
   else print(rv) end
end
```

Thoughts, feedback, and contributions are all welcome.