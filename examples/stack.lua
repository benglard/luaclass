-- inspired by https://github.com/wojciechz/learning_to_execute/blob/master/utils/stack.lua

require '../luaclass'

local Stack = Class({

   __init__ = function(self, p1, p2, p3)
      self.stack = {}
   end,

   push = function(self, val)
      self.stack[#self.stack + 1] = val
   end,

   pop = function(self, index)
      local index = index or #self.stack
      local rv = self.stack[index]
      self.stack[index] = nil
      return rv
   end,

   is_empty = function(self)
      return #self.stack == 0
   end,

   clean = function(self)
      self.stack = {}
   end,

   clone = function(self)
      local rv = {}
      setmetatable(rv, getmetatable(self))
      for key, val in pairs(self) do
         rv[key] = val
      end
      return rv
   end,

   __index = function(self, key)
      -- This acts as a second indexing function.
      -- The first handles defined variables like self.stack
      -- This handles new keys like self[3]
      return self.stack[key]
   end,

   __add = function(self, other)
      local rv = self:clone()
      for key, val in pairs(other.stack) do
         rv:push(val)
      end
      return rv
   end,

   __eq = function(self, other)
      for key, val in pairs(self.stack) do
         if self.stack[key] ~= other.stack[key] then
            return false
         end
      end
      return true
   end,

   __len = function(self)
      return #self.stack
   end,

   __call = function(self, ...)
      print(...)
   end,

   --[[__tostring = function(self)
      return 'Hi'
   end]]--

})

local s1 = Stack()
for i = 1, 5 do s1:push(i) end
print(s1)
print(s1:is_empty())
s1:pop()
print(s1.stack)
print(s1[3], s1[100])

local s2 = Stack()
s2:push(6)
s1:clean()
print(s2.stack)

for i = 1, 10 do s1:push(i) end
print(s1 + s2)
print(s1 == s2)
local s3 = s1:clone()
print(s1 == s3)
print(#s3)

s3('hi', 1)