lua_interpreter = "lua";
local_cache = os_getenv("XDG_CACHE_HOME") .. "/luarocks"
rocks_trees = {
  { root = os_getenv("LUAROCKS_TREE") },
}



variables = {
  LUA_DIR = os_getenv("LUAENV_LUA_PATH"),
  LUA_INCDIR = os_getenv("LUAENV_LUA_PATH") .. "/include",
  LUA_BINDIR = os_getenv("LUAENV_LUA_PATH") .. "/bin",
}
