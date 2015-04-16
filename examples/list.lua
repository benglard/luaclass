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