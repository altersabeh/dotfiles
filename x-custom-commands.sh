#!/usr/bin/sh

# aliases
export SCRIPTS_DIR="$HOME/Documents/scripts"
alias x="nano $SCRIPTS_DIR/x-custom-commands.sh"
alias a="nano $HOME/.bashrc"
alias vmp="nano $SCRIPTS_DIR/programming.sh"
alias lmp="nano $SCRIPTS_DIR/language-config.sh"
alias vpm="nano $SCRIPTS_DIR/x-version-manager.sh"
alias erlenv=erlxenv
alias r="R"
alias rscript="Rscript"
# alias gcc="ccache gcc"
# alias g++="ccache g++"
# alias code-insiders="'/mnt/d/Programs/Microsoft VS Code Insiders/bin/code-insiders'"


# custom functions for updating paths
homebrew() {
    # Set PATH, MANPATH, etc., for homebrew.
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export HOMEBREW_NO_AUTO_UPDATE=1
}

ibm() {
    export IBM="/opt/IBM/Informix_Client-SDK/bin"
    if [ "$1" = "activate" ]; then
        export PATH="$IBM:${PATH}"
    elif [ "$1" = "deactivate" ]; then
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$IBM" | tr "\n" ":" |  sed 's/:*$//')"
    else
        echo "please specify whether to activate or deactivate"
    fi
    unset IBM
}

adacore() {
    export ADA="/opt/GNAT/2021/bin"
    if [ "$1" = "activate" ]; then
        export PATH="$ADA:${PATH}"
    elif [ "$1" = "deactivate" ]; then
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$ADA" | tr "\n" ":" |  sed 's/:*$//')"
    else
        echo "please specify whether to activate or deactivate"
    fi
    unset ADA
}


emscripten() {
    source "/home/josh/.local/share/emsdk/emsdk_env.sh"
}

cccache() {
    export CCACHE="/usr/lib/ccache"
    if [ "$1" = "activate" ]; then
        export PATH="$CCACHE:${PATH}"
    elif [ "$1" = "deactivate" ]; then
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$CCACHE" | tr "\n" ":" |  sed 's/:*$//')"
    else
        echo "please specify whether to activate or deactivate"
    fi
    unset CCACHE
}

nvidia() {
    # Set PATH, LIB for nvidia cuda
    if [ -d "/usr/local/cuda" ]; then
        export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
        export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
        export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
    else
        echo "cuda not is yet installed"
    fi
}

intel() {
    # Set PATH for intel oneApi
    if [ -d "/opt/intel/oneapi" ]; then
        source /opt/intel/oneapi/setvars.sh
    else
        echo "intel oneapi is not installed yet"
    fi
}

extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.7z)
                7z x $1        ;;
            *.bz2)
                bunzip2 $1     ;;
            *.gz)
                gunzip $1      ;;
            *.rar)
                unrar x $1     ;;
            *.tar)
                tar xvf $1     ;;
            *.tar.bz2 | *.tbz)
                tar xvjf $1    ;;
            *.tar.gz | *.tgz)
                tar xvzf $1    ;;
            *.tar.xz | *.txz)
                tar xf $1      ;;
            *.Z)
                uncompress $1  ;;
            *.zip)
                unzip $1       ;;
            *)
                echo "don't know how to extract '$1'..." ;;
            esac
    else
            echo "'$1' is not a valid file!"
    fi
}

go-tools-update() {
    command go install golang.org/x/tools/gopls@latest
    command go install golang.org/x/tools/cmd/goimports@latest
    command go install github.com/go-delve/delve/cmd/dlv@latest
    command go install github.com/haya14busa/goplay/cmd/goplay@latest
    command go install github.com/ramya-rao-a/go-outline@latest
    command go install github.com/fatih/gomodifytags@latest
    command go install github.com/josharian/impl@latest
    command go install github.com/cweill/gotests/gotests@latest
    command go install honnef.co/go/tools/cmd/staticcheck@latest
    command go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
    command go install github.com/x-motemen/gore/cmd/gore@latest
    command go install github.com/mdempsky/gocode@latest
    command go install github.com/janpfeifer/gonb@latest
    command go install github.com/gopherdata/gophernotes@latest
    command go install github.com/charmbracelet/glow@latest
    command go install ghostlang.org/x/ghost@latest
    command go install github.com/jesseduffield/lazydocker@latest
}
