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

local Animal = Class({
   coldBlooded = false,

   __init__ = function(self, name, coldBlooded)
      self._parent:__init__(name)
      self.name = name
      self.coldBlooded = coldBlooded
   end,

   isColdBlooded = function(self) print(self.coldBlooded) end
}, Thing)

local a = Animal('A', true)
print(a)
a:isColdBlooded()

local Lion = Class({
   __init__ = function(self, options)
      self._parent:__init__('Lion', false)
      local options = options or {}
      self.name = options.name or self._parent.name
      self.gender = options.gender or 'F'
   end,

   rawr = function(self) print('rawwwr!') end
}, Animal)

local femaleLion = Lion()
local maleLion = Lion{gender='M'}
print(femaleLion, maleLion)
maleLion:rawr()
maleLion._parent:isColdBlooded()