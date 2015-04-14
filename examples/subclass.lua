require '../luaclass'

local Thing = Class
{
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
print(p) -- overriden __tostring
p:talk()
print(pcall(t.talk, t))