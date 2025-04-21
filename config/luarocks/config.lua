rocks_trees = {
  { root = os_etenv("LUAROCKS_TREE") },
}
lua_interpreter = "lua";
variables = {
  LUA_DIR = os_getenv("LUAENV_ROOT") .. "/versions/current",
  LUA_INCDIR = os_getenv("LUAENV_ROOT") .. "/versions/current/include",
  LUA_BINDIR = os_getenv("LUAENV_ROOT") .. "/versions/current/bin",
}
