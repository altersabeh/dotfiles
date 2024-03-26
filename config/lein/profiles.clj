{:user {:repl-options {:timeout 180000}
        :local-repo #=(eval (str (System/getenv "XDG_CACHE_HOME") "/maven/repository/lein"))
        :plugins [[lein-exec "0.3.7"]]
        :releases {:checksum :ignore}}}