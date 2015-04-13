package = 'luaclass'
version = 'scm-1'

source = {
   url = 'git://github.com/benglard/luaclass',
}

description = {
   summary = 'Easy Classes for Lua',
   detailed = 'Easy Classes for Lua',
   homepage = 'https://github.com/benglard/luaclass'
}

dependencies = {
   'lua >= 5.1'
}

build = {
   type = 'builtin',
   modules = {
      ['luaclass.init'] = 'luaclass/init.lua',
   }
}