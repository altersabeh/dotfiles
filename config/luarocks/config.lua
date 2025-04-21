rocks_trees = {
<<<<<<< HEAD
  { root = os.getenv("LUAROCKS_TREE") },
=======
  { root = os_getenv("LUAROCKS_TREE") },
>>>>>>> a92bd4db2b740038ac00b232e90f10972e7ac8dd
}
lua_interpreter = "lua";
variables = {
  LUA_DIR = os_getenv("LUAENV_ROOT") .. "/versions/current",
  LUA_INCDIR = os_getenv("LUAENV_ROOT") .. "/versions/current/include",
  LUA_BINDIR = os_getenv("LUAENV_ROOT") .. "/versions/current/bin",
}
