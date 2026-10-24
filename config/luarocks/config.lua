lua_interpreter = "lua";
local_cache = os_getenv("XDG_CACHE_HOME") .. "/luarocks"
rocks_trees = {
  { root = os_getenv("LUAROCKS_TREE") },
}

lua_dir = os_getenv("LUAROCKS_LUA_DIR") 
             or os_getenv("LUAENV_LUA_PATH") 
             or os_getenv("LUA_PREFIX") 
             or "/usr/local"

variables = {
  LUA_DIR = lua_dir,
  LUA_INCDIR = lua_dir .. "/include",
  LUA_BINDIR = lua_dir .. "/bin",
}
