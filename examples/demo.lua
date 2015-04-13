require '../luaclass'

print('1 ------')

local Test = Class({

   var = 5,

   __init__ = function(self, p1, p2, p3)
      --self.var = p1
      self.stuff = {p1, p2, p3}
   end,

   test = function(self)
      print(self.var, self.stuff)
   end

})

local c = Test(1,2,3)
c:test()

local c2 = Test(4,5,6)
c2:test()

c.var = 6
c:test()
c2:test()

print('2 ------')

local Test2 = Class({ __init__ = function(self, ...) print(...) end })
local ct2 = Test2(1,2,3)
ct2.test = 5
print(ct2)

print('3 ------')

local Test3 = Class({

   t = {},
   t2 = {{}, {}},

   __init__ = function(self)
   end

})

local ct3_1 = Test3()
local ct3_2 = Test3()
ct3_1.t = 5
print(ct3_1, ct3_2)

print('4 ------')

local Test4 = Class({})
print(Test4)
Test4.test = 5
Test4.f = function(self, ...)
   print(...)
end
print(Test4)
print(Test4:f(1,2,3))