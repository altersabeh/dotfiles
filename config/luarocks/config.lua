rocks_trees = {
  { root = os.getenv("LUAROCKS_TREE") },
}
lua_interpreter = "lua";
variables = {
  LUA_DIR = os.getenv("LUAENV_ROOT") .. "/versions/current",
  LUA_INCDIR = os.getenv("LUAENV_ROOT") .. "/versions/current/include",
  LUA_BINDIR = os.getenv("LUAENV_ROOT") .. "/versions/current/bin",
}
