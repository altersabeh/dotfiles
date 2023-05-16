#!/usr/bin/sh
# custom functions for version managers
opamx() {
    if [ $# -gt 0 ] && [ "$1" == "switch" ]; then
        shift
        command opam switch "$@" && eval $(opam env)
    else
        command opam "$@"
    fi
}

erlxenv() {
    if [ "$1" = "install" ]; then
        shift
        evm install "$@" -y "$ERLANG_CONFIGURE_OPTS"
    else
        evm "$@"
    fi
}

plxenv() {
    if [ "$1" == "migrate" ]; then
        shift
        command plenv migrate-modules "$@"
    elif [ "$1" = "install" ]; then
	shift
	command plenv install "$@" --jobs 4 "${PERL_BUILD_CONFIGURE_OPTS[@]}"
    elif [ "$1" = "set" ]; then
        export PL_PATH=$(plenv root)/perls
        if [[ -n "$2" ]]; then
            plxenv unset
            export PATH="$PL_PATH/$2/bin:$PATH"
        else
            plxenv unset
            export PATH="$PL_PATH/$(plenv global)/bin:$PATH"
        fi
        unset PL_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(plenv root)/perls
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$RM_PATH" | tr "\n" ":" |  sed 's/:*$//')"
        unset RM_PATH
    else
        local command;
        command="$1";
        if [ "$#" -gt 0 ]; then
            shift;
        fi;
        case "$command" in
            rehash | shell)
                eval "`plenv "sh-$command" "$@"`"
            ;;
            *)
                command plenv "$command" "$@"
            ;;
        esac
    fi
}

luaxenv() {
    if [ "$1" = "install" ]; then
        shift
        export MAKEOPTS="linux-readline MYCFLAGS=-g"
        command luaenv install "$@"
        export MAKEOPTS="-j4"
    elif [ "$1" = "set" ]; then
        export LUA_PATH=$(luaenv root)/luas
        if [[ -n "$2" ]]; then
            luaxenv unset
            export PATH="$LUA_PATH/$2/bin:$PATH"
        else
            luaxenv unset
            export PATH="$LUA_PATH/$(luaenv global)/bin:$PATH"
        fi
        unset LUA_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(luaenv root)/luas
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$RM_PATH" | tr "\n" ":" |  sed 's/:*$//')"
        unset RM_PATH
    else
        local command;
        command="$1";
        if [ "$#" -gt 0 ]; then
            shift;
        fi;
        case "$command" in
            rehash | shell)
                eval "`luaenv "sh-$command" "$@"`"
            ;;
            *)
                command luaenv "$command" "$@"
            ;;
        esac
    fi
}

rxenv() {
    if [ "$1" = "install" ]; then
        shift
        export CC='gcc' CXX='g++' \
            CFLAGS='-llapack -lblas -g -O2' CXXFLAGS='-llapack -lblas -g -O2' \
            OBJCFLAGS='-llapack -lblas -g -O2' FCFLAGS='-llapack -lblas -g -O2'
        command renv install "$@"
        unset CC CXX CFLAGS CXXFLAGS CPPFLAGS FCFLAGS
    elif [ "$1" = "set" ]; then
        export R_PATH=$(renv root)/R
        if [[ -n "$2" ]]; then
            rxenv unset
            export PATH="$R_PATH/$2/bin:$PATH"
        else
            rxenv unset
            export PATH="$R_PATH/$(renv global)/bin:$PATH"
        fi
        unset R_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(renv root)/R
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$RM_PATH" | tr "\n" ":" |  sed 's/:*$//')"
        unset RM_PATH
    else
        local command;
        command="${1:-}";
        if [ "$#" -gt 0 ]; then
            shift;
        fi;
        case "$command" in
            rehash | shell)
                eval "$(renv "sh-$command" "$@")"
            ;;
            *)
                command renv "$command" "$@"
            ;;
        esac
    fi
}

pyxenv() {
    if [ "$1" = "set" ]; then
        PY_PATH="$(pyenv root)/pythons"
        if [[ -n "$2" ]]; then
            pyxenv unset
            export PATH="$PY_PATH/$2/bin:$PATH"
        else
            pyxenv unset
            export PATH="$PY_PATH/$(pyenv global)/bin:$PATH"
        fi
        unset PY_PATH
    elif [ "$1" = unset ]; then
        RM_PATH=$(pyenv root)/pythons
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$RM_PATH" | tr "\n" ":" |  sed 's/:*$//')"
        unset RM_PATH
    else
        local command;
        command="${1:-}";
        if [ "$#" -gt 0 ]; then
            shift;
        fi;
        case "$command" in
            activate | deactivate | rehash | shell)
                eval "$(pyenv "sh-$command" "$@")"
            ;;
            *)
                command pyenv "$command" "$@"
            ;;
        esac
    fi
}

rbxenv() {
    if [ "$1" = "set" ]; then
        export RB_PATH=$(rbenv root)/rubies
        if [[ -n "$2" ]]; then
            rbxenv unset
            export PATH="$RB_PATH/$2/bin:$PATH"
        else
            rbxenv unset
            export PATH="$RB_PATH/$(rbenv global)/bin:$PATH"
        fi
    elif [ "$1" = unset ]; then
        export RM_PATH=$(rbenv root)/rubies
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$RM_PATH" | tr "\n" ":" |  sed 's/:*$//')"
        unset RM_PATH
    else
        local command;
        command="${1:-}";
        if [ "$#" -gt 0 ]; then
            shift;
        fi;
        case "$command" in
            rehash | shell | update | use)
                eval "$(rbenv "sh-$command" "$@")"
            ;;
            *)
                command rbenv "$command" "$@"
            ;;
        esac
    fi
}

phpxenv() {
    if [ "$1" = "set" ]; then
        export PHP_PATH=$(phpenv root)/php
        if [[ -n "$2" ]]; then
            phpxenv unset
            # export COMPOSER_HOME="$PHP_PATH/$2/composer"
            # export PATH="$PHP_PATH/$2/bin:$COMPOSER_HOME:$COMPOSER_HOME/vendor/bin:$PATH"
            export PATH="$PHP_PATH/$2/bin:$PATH"
        else
            phpxenv unset
            # export COMPOSER_HOME="$PHP_PATH/$(phpenv global)/composer"
            # export PATH="$PHP_PATH/$(phpenv global)/bin:$COMPOSER_HOME:$COMPOSER_HOME/vendor/bin:$PATH"
            export PATH="$PHP_PATH/$(phpenv global)/bin:$PATH"
        fi
        unset PHP_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(phpenv root)/php
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$RM_PATH" | tr "\n" ":" |  sed 's/:*$//')"
        # unset COMPOSER_HOME
        unset RM_PATH
    else
    local command;
        command="$1";
        if [ "$#" -gt 0 ]; then
            shift;
        fi;
        case "$command" in
            shell | update | update-all)
                eval `phpenv "sh-$command" "$@"`
            ;;
            *)
                command phpenv "$command" "$@"
            ;;
        esac
    fi
}

nodxenv() {
    if [ "$1" = "set" ]; then
        export ND_PATH=$(nodenv root)/nodes
        if [[ -n "$2" ]]; then
            nodxenv unset
            export PATH="$ND_PATH/$2/bin:$PATH"
        else
            nodxenv unset
            export PATH="$ND_PATH/$(nodenv global)/bin:$PATH"
        fi
        unset ND_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(nodenv root)/nodes
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$RM_PATH" | tr "\n" ":" |  sed 's/:*$//')"
        unset RM_PATH
    else
        local command;
        command="${1:-}";
        if [ "$#" -gt 0 ]; then
            shift;
        fi;
        case "$command" in
            rehash | shell | update)
                eval "$(nodenv "sh-$command" "$@")"
            ;;
            *)
                command nodenv "$command" "$@"
            ;;
        esac
    fi
}

swiftxenv() {
    if [ "$1" = "set" ]; then
        export SW_PATH=$(swiftxenv root)/swifts
        if [[ -n "$2" ]]; then
            swiftxenv unset
            export PATH="$SW_PATH/$2/bin:$PATH"
        else
            swiftxenv unset
            export PATH="$SW_PATH/$(swiftenv global)/usr/bin:$PATH"
        fi
        unset SW_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(swiftxenv root)/swifts
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$RM_PATH" | tr "\n" ":" |  sed 's/:*$//')"
        unset RM_PATH
    elif [ "$1" = root ]; then
        echo $SWIFTENV_ROOT
    else
        command swiftenv "$@"
    fi
}

goxenv() {
    if [ "$1" == "install-tools" ]; then
        shift
        go-tools-update
    elif [ "$1" = "install" ]; then
	shift
	command goenv install "$@"
    elif [ "$1" = "set" ]; then
        export GO_PATH=$(goenv root)/gos
        if [[ -n "$2" ]]; then
            goxenv unset
            export PATH="$GO_PATH/$2/bin:$PATH"
        else
            goxenv unset
            export PATH="$GO_PATH/$(goenv global)/bin:$PATH"
        fi
        unset GO_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(goenv root)/gos
        export PATH="$(echo $PATH | tr ":" "\n" | grep -v "$RM_PATH" | tr "\n" ":" |  sed 's/:*$//')"
        unset RM_PATH
    else
        local command;
        command="$1";
        if [ "$#" -gt 0 ]; then
            shift;
        fi;
        case "$command" in
            rehash | shell | update)
                eval "`goenv "sh-$command" "$@"`"
            ;;
            *)
                command goenv "$command" "$@"
            ;;
        esac
    fi
}

set_xglobal

