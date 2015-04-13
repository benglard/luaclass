local metamethods = {
   '__index', '__tostring', '__len', '__unm', 
   '__add', '__sub', '__mul', '__div', '__mod',
   '__pow', '__concat', '__eq', '__lt', '__le',
   '__call', '__gc', '__newindex', '__mode'
}

local construct = function(t)
   local rv = {}
   for key, method in pairs(metamethods) do
      rv[method] = t[method]
   end
   return rv
end

Class = function(def)
   setmetatable(def, {
      __call = function(cls, ...)
         local rv = {}
         for key, val in pairs(cls) do
            rv[key] = val
         end
         setmetatable(rv, construct(def))
         def.__init__(rv, ...)
         return rv
      end,
   })
   return def
end