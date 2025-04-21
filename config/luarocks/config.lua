lua_interpreter = "lua";
rocks_trees = {
  { root = os_etenv("LUAROCKS_TREE") },
}
variables = {
  LUA_DIR = os_getenv("LUAENV_ROOT") .. "/versions/current",
  LUA_INCDIR = os_getenv("LUAENV_ROOT") .. "/versions/current/include",
  LUA_BINDIR = os_getenv("LUAENV_ROOT") .. "/versions/current/bin",
}
