require '../luaclass'

local Dictionary = Class {
   __init__ = function(self) self.d = {}
   end,

   add = function(self, key, val) self.d[key] = val
   end,
   
   __index = function(self, key) return self.d[key]
   end
}

local DefaultDict = Class({
   __init__ = function(self, default) 
      self.default = default
   end,

   __index = function(self, key)
      return self._parent.d[key] or self.default()
   end,

   __newindex = function(self, key, val)
      if key == 'default' then
         rawset(self, 'default', val)
      else
         self._parent:add(key, val)
      end
   end
}, Dictionary)

local d = Dictionary()
d:add('test', true)
print(d.d)

local dd = DefaultDict(function() return 5 end)
print(dd.test)
dd.test = 10
print(dd.test)
print(dd.test2)