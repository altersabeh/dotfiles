#!/usr/bin/env bash
# custom functions for version managers

#nimble() {
#    ln -s $XDG_DATA_HOME/choosenim $HOME/.choosenim
#    command nimble "$@"
#    rm $HOME/.choosenim
#}

lein() {
    ln -s $XDG_DATA_HOME/m2 $HOME/.m2
    command lein "$@"
    rm $HOME/.m2
}

zvm() {
    ln -s $XDG_DATA_HOME/zvm $HOME/.zvm
    command zvm "$@"
    rm $HOME/.zvm
}

opam() {
    if [ $# -gt 0 ] && [ "$1" == "switch" ]; then
        shift
        command opam switch "$@" && eval $(opam env)
    else
        command opam "$@"
    fi
}

sscilab() {
    command scilab-cli -scihome "${SCIHOME}"
}

erlxenv() {
    if [ "$1" = "install" ]; then
        shift
        evm install "$@" -y --with-docs $ERLANG_CONFIGURE_OPTS
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
	    command plenv install "$@" --jobs 12 ${PERL_BUILD_CONFIGURE_OPTS[@]}
    elif [ "$1" = "set" ]; then
        export PL_PATH=$(plenv root)/versions
        if [[ -n "$2" ]]; then
            plxenv unset
            [ -d $PL_PATH/current ] && rm $PL_PATH/current
            ln -s $PL_PATH/$2 $PL_PATH/current
            export PATH="$PL_PATH/current/bin:$PATH"
        else
            plxenv unset
            [ -d $PL_PATH/current ] && rm $PL_PATH/current
            ln -s $PL_PATH/$(plenv global) $PL_PATH/current
            export PATH="$PL_PATH/current/bin:$PATH"
        fi
        unset PL_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(plenv root)/versions/current
        [ -d $RM_PATH ] && rm $RM_PATH
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
        export LUA_PATH=$(luaenv root)/versions
        if [[ -n "$2" ]]; then
            luaxenv unset
            [ -d $LUA_PATH/current ] && rm $LUA_PATH/current
            ln -s $LUA_PATH/$2 $LUA_PATH/current
            export PATH="$LUA_PATH/current/bin:$PATH"
        else
            luaxenv unset
            [ -d $LUA_PATH/current ] && rm $LUA_PATH/current
            ln -s $LUA_PATH/$(luaenv global) $LUA_PATH/current
            export PATH="$LUA_PATH/current/bin:$PATH"
        fi
        unset LUA_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(luaenv root)/versions/current
        [ -d $RM_PATH ] && rm $RM_PATH
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
        export CFLAGS="-g -O2"
        export CXXFLAGS="-g -O2"
        export OBJCFLAGS="-g -O2"
        export FCFLAGS="-g -O2"
        command renv install "$@"
        unset CC CXX CFLAGS CXXFLAGS CPPFLAGS FCFLAGS
    elif [ "$1" = "set" ]; then
        export R_PATH=$(renv root)/versions
        if [[ -n "$2" ]]; then
            rxenv unset
            [ -d $R_PATH/current ] && rm $R_PATH/current
            ln -s $R_PATH/$2 $R_PATH/current
            export PATH="$R_PATH/current/bin:$PATH"
        else
            rxenv unset
            [ -d $R_PATH/current ] && rm $R_PATH/current
            ln -s $R_PATH/$(renv global) $R_PATH/current
            export PATH="$R_PATH/current/bin:$PATH"
        fi
        unset R_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(renv root)/versions/current
        [ -d $RM_PATH ] && rm $RM_PATH
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
        export PY_PATH="$(pyenv root)/versions"
        if [[ -n "$2" ]]; then
            pyxenv unset
            [ -d $PY_PATH/current ] && rm $PY_PATH/current
            ln -s $PY_PATH/$2 $PY_PATH/current
            export PATH="$PY_PATH/current/bin:$PATH"
        else
            pyxenv unset
            [ -d $PY_PATH/current ] && rm $PY_PATH/current
            ln -s $PY_PATH/$(pyenv global) $PY_PATH/current
            export PATH="$PY_PATH/current/bin:$PATH"
        fi
        unset PY_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(pyenv root)/versions/current
        [ -d $RM_PATH ] && rm $RM_PATH
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
        export RB_PATH=$(rbenv root)/versions
        if [[ -n "$2" ]]; then
            rbxenv unset
            [ -d $RB_PATH/current ] && rm $RB_PATH/current
            ln -s $RB_PATH/$2 $RB_PATH/current
            export PATH="$RB_PATH/current/bin:$PATH"
        else
            rbxenv unset
            [ -d $RB_PATH/current ] && rm $RB_PATH/current
            ln -s $RB_PATH/$(rbenv global) $RB_PATH/current
            export PATH="$RB_PATH/current/bin:$PATH"
        fi
    elif [ "$1" = unset ]; then
        export RM_PATH=$(rbenv root)/versions/current
        [ -d $RM_PATH ] && rm $RM_PATH
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
        export PHP_PATH=$(phpenv root)/versions
        if [[ -n "$2" ]]; then
            phpxenv unset
            # export COMPOSER_HOME="$PHP_PATH/$2/composer"
            # export PATH="$PHP_PATH/$2/bin:$COMPOSER_HOME:$COMPOSER_HOME/vendor/bin:$PATH"
            [ -d $PHP_PATH/current ] && rm $PHP_PATH/current
            ln -s $PHP_PATH/$2 $PHP_PATH/current
            export PATH="$PHP_PATH/current/bin:$PATH"
        else
            phpxenv unset
            # export COMPOSER_HOME="$PHP_PATH/$(phpenv global)/composer"
            # export PATH="$PHP_PATH/$(phpenv global)/bin:$COMPOSER_HOME:$COMPOSER_HOME/vendor/bin:$PATH"
            [ -d $PHP_PATH/current ] && rm $PHP_PATH/current
            ln -s $PHP_PATH/$(phpenv global) $PHP_PATH/current
            export PATH="$PHP_PATH/current/bin:$PATH"
        fi
        unset PHP_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(phpenv root)/versions/current
        [ -d $RM_PATH ] && rm $RM_PATH
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
        export NOD_PATH=$(nodenv root)/versions
        if [[ -n "$2" ]]; then
            nodxenv unset
            [ -d $NOD_PATH/current ] && rm $NOD_PATH/current
            ln -s $NOD_PATH/$2 $NOD_PATH/current
            export PATH="$NOD_PATH/current/bin:$PATH"
        else
            nodxenv unset
            [ -d $NOD_PATH/current ] && rm $NOD_PATH/current
            ln -s $NOD_PATH/$(nodenv global) $NOD_PATH/current
            export PATH="$NOD_PATH/current/bin:$PATH"
        fi
        unset NOD_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(nodenv root)/versions/current
        [ -d $RM_PATH ] && rm $RM_PATH
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
        export SW_PATH=$(swiftxenv root)/versions
        if [[ -n "$2" ]]; then
            swiftxenv unset
            [ -d $SW_PATH/current ] && rm $SW_PATH/current
            ln -s $SW_PATH/$2 $SW_PATH/current
            export PATH="$SW_PATH/current/usr/bin:$PATH"
        else
            swiftxenv unset
            [ -d $SW_PATH/current ] && rm $SW_PATH/current
            ln -s $SW_PATH/$(swiftenv global) $SW_PATH/current
            export PATH="$SW_PATH/current/usr/bin:$PATH"
        fi
        unset SW_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(swiftxenv root)/versions/current
        [ -d $RM_PATH ] && rm $RM_PATH
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
        export GO_PATH=$(goenv root)/versions
        if [[ -n "$2" ]]; then
            nodxenv unset
            [ -d $GO_PATH/current ] && rm $GO_PATH/current
            ln -s $GO_PATH/$2 $GO_PATH/current
            export PATH="$GO_PATH/current/bin:$PATH"
        else
            nodxenv unset
            [ -d $GO_PATH/current ] && rm $GO_PATH/current
            ln -s $GO_PATH/$(goenv global) $GO_PATH/current
            export PATH="$GO_PATH/current/bin:$PATH"
        fi
        unset GO_PATH
    elif [ "$1" = unset ]; then
        export RM_PATH=$(goenv root)/versions/current
        [ -d $RM_PATH ] && rm $RM_PATH
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

# set_xglobal

