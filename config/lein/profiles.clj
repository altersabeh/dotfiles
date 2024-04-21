{:user {:repl-options {:timeout 180000
                       :history-file #=(eval (str (System/getenv "XDG_STATE_HOME") "/lein/history"))}
        :local-repo #=(eval (str (System/getenv "MAVEN_CUSTOM_REPO") "/repository"))
        :plugins [[lein-exec "0.3.7"]]}}