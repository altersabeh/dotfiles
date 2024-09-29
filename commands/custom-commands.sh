#!/usr/bin/env bash

# custom functions for updating paths
homebrew() {
    # Set PATH, MANPATH, etc., for homebrew.
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export HOMEBREW_NO_AUTO_UPDATE=1
}

# ibm() {
#     export IBM="/opt/IBM/Informix_Client-SDK/bin"
#     if [ "$1" = "activate" ]; then
#         export PATH="$IBM:${PATH}"
#     elif [ "$1" = "deactivate" ]; then
#         export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$IBM" | tr "\n" ":" |  sed 's/:*$//')"
#     else
#         echo "please specify whether to activate or deactivate"
#     fi
#     unset IBM
# }

# adacore() {
#     export ADA="/opt/GNAT/2021/bin"
#     if [ "$1" = "activate" ]; then
#         export PATH="$ADA:${PATH}"
#     elif [ "$1" = "deactivate" ]; then
#         export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$ADA" | tr "\n" ":" |  sed 's/:*$//')"
#     else
#         echo "please specify whether to activate or deactivate"
#     fi
#     unset ADA
# }

lein() {
    ln -s "${MAVEN_CUSTOM_REPO}" "${HOME}/.m2"
    command lein "$@"
    rm "${HOME}/.m2"
}

function v() {
    local OLD_CPATH="${CPATH}"
    unset CPATH
    command v "$@"
    export CPATH="${OLD_CPATH}"
}

function kotlin() {
    mkdir -p "${XDG_STATE_HOME}/kotlin"
    touch "${XDG_STATE_HOME}/kotlin/history"
    ln -s "${XDG_STATE_HOME}/kotlin/history" "${HOME}/.kotlinc_history"
    command kotlin "$@"
    rm "${HOME}/.kotlinc_history"
}

function scala() {
    mkdir -p "${XDG_STATE_HOME}/dotty"
    touch "${XDG_STATE_HOME}/dotty/history"
    ln -s "${XDG_STATE_HOME}/dotty/history" "${HOME}/.dotty_history"
    command scala "$@"
    rm "${HOME}/.dotty_history"
}

function groovysh() {
    mkdir -p "${XDG_STATE_HOME}/groovy"
    touch "${XDG_STATE_HOME}/groovy/history"
    mkdir -p "${HOME}/.groovy"
    ln -s "${XDG_STATE_HOME}/groovy" "${HOME}/.groovy"
    command groovysh "$@"
    rm "${HOME}/.groovy"
}

function swift() {
    mkdir -p "${XDG_STATE_HOME}/swift"
    touch "${XDG_STATE_HOME}/swift/history"
    mkdir -p "${HOME}/.lldb"
    ln -s "${XDG_STATE_HOME}/swift/history" "${HOME}/.lldb/lldb-repl-widehistory"
    command swift "$@"
    rm -rf "${HOME}/.lldb"
}

function ghci() {
    mkdir -p "${XDG_STATE_HOME}/ghci"
    touch "${XDG_STATE_HOME}/ghci/history"
    mkdir -p "${XDG_CONFIG_HOME}/ghc"
    ln -s "${XDG_STATE_HOME}/ghci/history" "${XDG_CONFIG_HOME}/ghc/ghci_history"
    command ghci "$@"
    rm "${XDG_CONFIG_HOME}/ghc/ghci_history"
}

function coffee() {
    mkdir -p "${XDG_STATE_HOME}/coffee"
    touch "${XDG_STATE_HOME}/coffee/history"
    ln -s "${XDG_STATE_HOME}/coffee/history" "${XDG_CACHE_HOME}/.coffee_history"
    command coffee "$@"
    rm "${XDG_CACHE_HOME}/.coffee_history"
}

function amm() {
    mkdir -p "${XDG_STATE_HOME}/ammonite"
    touch "${XDG_STATE_HOME}/ammonite/history"
    ln -s "${XDG_STATE_HOME}/ammonite" "${HOME}/.ammonite"
    command amm "$@"
    rm "${HOME}/.ammonite"
}

function utop() {
    mkdir -p "${XDG_STATE_HOME}/utop"
    touch "${XDG_STATE_HOME}/utop/history"
    touch "${XDG_STATE_HOME}/utop-history"
    ln -s "${XDG_STATE_HOME}/utop/history" "${XDG_STATE_HOME}/utop-history"
    command utop "$@"
    rm "${XDG_STATE_HOME}/utop-history"
}

function evcxr() {
    mkdir -p "${XDG_STATE_HOME}/evcxr"
    touch "${XDG_STATE_HOME}/evcxr/history"
    mkdir "${XDG_CONFIG_HOME}/evcxr/"
    ln -s "${XDG_STATE_HOME}/evcxr/history" "${XDG_CONFIG_HOME}/evcxr/history.txt"
    command evcxr "$@"
    rm "${XDG_CONFIG_HOME}/evcxr/history.txt"
}

function elixir() {
    unset ERL_AFLAGS
    command elixir "$@"
}

function iex() {
    unset ERL_AFLAGS
    command iex "$@"
}

# emscripten() {
#     source "/home/josh/.local/share/emsdk/emsdk_env.sh"
# }

# cccache() {
#     export CCACHE="/usr/lib/ccache"
#     if [ "$1" = "activate" ]; then
#         export PATH="$CCACHE:${PATH}"
#     elif [ "$1" = "deactivate" ]; then
#         export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$CCACHE" | tr "\n" ":" | sed 's/:*$//')"
#     else
#         echo "please specify whether to activate or deactivate"
#     fi
#     unset CCACHE
# }

# nvidia() {
#     # Set PATH, LIB for nvidia cuda
#     if [ -d "/usr/local/cuda" ]; then
#         export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
#         export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#         export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#     else
#         echo "cuda not is yet installed"
#     fi
# }

# intel() {
#     # Set PATH for intel oneApi
#     if [ -d "/opt/intel/oneapi" ]; then
#         source /opt/intel/oneapi/setvars.sh
#     else
#         echo "intel oneapi is not installed yet"
#     fi
# }

# extract() {
#     if [ -f $1 ] ; then
#         case $1 in
#             *.7z)
#                 7z x $1        ;;
#             *.bz2)
#                 bunzip2 $1     ;;
#             *.gz)
#                 gunzip $1      ;;
#             *.rar)
#                 unrar x $1     ;;
#             *.tar)
#                 tar xvf $1     ;;
#             *.tar.bz2 | *.tbz)
#                 tar xvjf $1    ;;
#             *.tar.gz | *.tgz)
#                 tar xvzf $1    ;;
#             *.tar.xz | *.txz)
#                 tar xf $1      ;;
#             *.Z)
#                 uncompress $1  ;;
#             *.zip)
#                 unzip $1       ;;
#             *)
#                 echo "don't know how to extract '$1'..." ;;
#             esac
#     else
#             echo "'$1' is not a valid file!"
#     fi
# }

go-tools-update() {
    command go install golang.org/x/tools/gopls@latest
    command go install golang.org/x/tools/cmd/goimports@latest
    command go install github.com/go-delve/delve/cmd/dlv@latest
    command go install github.com/haya14busa/goplay/cmd/goplay@latest
    command go install github.com/fatih/gomodifytags@latest
    command go install github.com/josharian/impl@latest
    command go install github.com/cweill/gotests/gotests@latest
    command go install honnef.co/go/tools/cmd/staticcheck@latest
    command go install github.com/gopherdata/gophernotes@latest
    command go install github.com/charmbracelet/glow@latest
    command go install github.com/jesseduffield/lazydocker@latest
    command go install mvdan.cc/sh/v3/cmd/shfmt@latest
    command go install github.com/bazelbuild/buildtools/buildifier@latest
    command go install github.com/bazelbuild/buildtools/buildozer@latest
    command go install github.com/magefile/mage@latest
    command go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
}
