#!/usr/bin/env sh

# CUBRID
# source "$XDG_CONFIG_HOME/cubrid.sh"

# IBM ==-- ===========================================================
export INFORMIXDIR="/opt/ibm/informix"
# source "$HOME/sqllib/db2profile"

# AWS ================================================================
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_DATA_HOME/aws/shared-credentials"

# STARSHIP ===========================================================
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"

# SUBVERSION =========================================================
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

# TERRAFORM ==========================================================
export TF_HOME_DIR="$XDG_DATA_HOME/terraform"

# VAGRANT ============================================================
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME/vagrant/aliases"

# DOCKER =============================================================
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# SCILAB =============================================================
export SCIHOME="$XDG_DATA_HOME/scilab"
alias scilab="scilab-cli -scihome $SCIHOME"
alias scilab-cli="scilab-cli -scihome $SCIHOME"

# XORG ===============================================================
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# RLWRAP =============================================================
export RLWRAP_HOME="$XDG_DATA_HOME/rlwrap"

# WINE ===============================================================
export WINEPREFIX="$XDG_DATA_HOME/wine"

# ZSH ================================================================
export ZDOTDIR="$XDG_CONFIG_HOME/.config/zsh"

# WGET ===============================================================
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

# VMODULE ============================================================
export VMODULES="$XDG_DATA_HOME/vmodules"

# SOLARGRAPH =========================================================
export SOLARGRAPH_CACHE="$XDG_CACHE_HOME/solargraph"

# OMNISHARP ==========================================================
export OMNISHARPHOME="$XDG_CONFIG_HOME/omnisharp"

# NUGET ==============================================================
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

# LESS ===============================================================
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# ICONS ==============================================================
export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"

# GTK ================================================================
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# GRADLE =============================================================
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# GNUPG ==============================================================
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
alias gpg="gpg --homedir $XDG_DATA_HOME/gnupg"

# BASH (history) =====================================================
export HISTFILE="$XDG_STATE_HOME/bash/history"

# AZURE ==============================================================
export AZURE_CONFIG_DIR="$XDG_DATA_HOME/azure"

# ATOM ===============================================================
export ATOM_HOME="$XDG_DATA_HOME/atom"

# PGSQL ==============================================================
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

# CONAN ==============================================================
export CONAN_USER_HOME="$XDG_CONFIG_HOME"

# TEXLIVE ============================================================
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"

# ANSIBLE ============================================================
export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="$XDG_CACHE_HOME/ansible/galaxy_cache"

# CALC ===============================================================
export CALCHISTFILE="$XDG_CACHE_HOME/calc_history"

# GNATSTUDIO =========================================================
export GNATSTUDIO_HOME="$XDG_DATA_HOME/gnatstudio"

# OCTAVE =============================================================
export OCTAVE_HISTFILE="$XDG_CACHE_HOME/octave-hsts"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"

# DENO JS ============================================================
export DENO_INSTALL="$XDG_DATA_HOME/deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# FACTOR =============================================================
export PATH="$XDG_DATA_HOME/factor:$PATH"

# PROCESSING =========================================================
export PROCESSING_JAVA="$XDG_DATA_HOME/processing/processing-java"
export PATH="$XDG_DATA_HOME/processing:$PATH"

# BALLERINA ==========================================================
export PATH="$XDG_DATA_HOME/ballerina/bin:$PATH"

# CLEAN ==============================================================
export CLEAN_HOME="$XDG_DATA_HOME/clean"
export PATH="$CLEAN_HOME/bin:$PATH"

# ZEEK ===============================================================
export PATH="/opt/zeek/bin:$PATH"

# KIEX (elixir) ======================================================
export KIEX_HOME="$XDG_DATA_HOME/kiex"
source "$KIEX_HOME/scripts/kiex"

# MIX ================================================================
export MIX_HOME="$XDG_DATA_HOME/mix"
export MIX_XDG=1
export PATH="$MIX_HOME/escripts:$PATH"

# EVM (erlang) =======================================================
export EVM_HOME="$XDG_DATA_HOME/evm"
source "$EVM_HOME/scripts/evm"

# ERLANG =============================================================
export PATH="$XDG_CACHE_HOME/rebar3/bin:$PATH"

# RAKUBREW (raku) ====================================================
export RAKUBREW_HOME="$XDG_DATA_HOME/rakubrew"
eval "$($RAKUBREW_HOME/bin/rakubrew init Bash)"

# RUST ===============================================================
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
source "$CARGO_HOME/env"

# LEIN (clojure) =====================================================
export LEIN_HOME="$XDG_DATA_HOME/lein"
export PATH="$LEIN_HOME/bin:$PATH"
export PATH="$XDG_DATA_HOME/clojure/bin:$PATH"

# RED ================================================================
export PATH="$XDG_DATA_HOME/red/bin:$PATH"

# PONYUP (pony) ======================================================
export PATH="$XDG_DATA_HOME/ponyup/bin:$PATH"

# EMSCRIPTEN =========================================================
export EMSDK_QUIET=1
source "/home/josh/.local/share/emsdk/emsdk_env.sh"
export EM_CONFIG="$XDG_CONFIG_HOME/emscripten/config"
export EM_CACHE="$XDG_CACHE_HOME/emscripten/cache"
export EM_PORTS="$XDG_DATA_HOME/emscripten/cache"

# FVM (flutter) (dart) ===============================================
export FVM_HOME="$XDG_DATA_HOME/fvm"
export PATH="$FVM_HOME/default/bin:$PATH"

# PUB ================================================================
export PUB_CACHE="$XDG_DATA_HOME/pub-cache"
export PATH="$PATH:$PUB_CACHE/bin"

# DART ===============================================================
export ANALYZER_STATE_LOCATION_OVERIDE="$XDG_CACHE_HOME/dartServer"

# GHCUP (haskell) ====================================================
export GHCUP_INSTALL_BASE_PREFIX="$XDG_DATA_HOME"
source "$GHCUP_INSTALL_BASE_PREFIX/ghcup/env"

# CABAL ==============================================================
export CABAL_DIR="$XDG_DATA_HOME/cabal"
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export PATH="$CABAL_DIR/bin:$PATH"

# STACK ==============================================================
export STACK_ROOT="$XDG_DATA_HOME/stack"

# JULIA ==============================================================
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export PATH="$XDG_DATA_HOME/juliaup/bin:$PATH"

# NIMBLE (nim) =======================================================
export NIMBLE_DIR="$XDG_DATA_HOME/nimble"
export PATH="$NIMBLE_DIR/bin:$PATH"

# V ==================================================================
export PATH="$XDG_DATA_HOME/v:$PATH"

# D ==================================================================
export DUB_HOME="$XDG_DATA_HOME/dub"

# OPAM (ocaml) =======================================================
export OPAMROOT="$XDG_DATA_HOME/opam"
source "$OPAMROOT/opam-init/init.sh" > /dev/null 2> /dev/null || true

# SWIFTENV (swift) ===================================================
export SWIFTENV_ROOT="$XDG_DATA_HOME/swiftenv"
export PATH="$SWIFTENV_ROOT/bin:$PATH"
eval "$(swiftenv init -)"

# CRENV (crystal) ====================================================
export CRENV_ROOT="$XDG_DATA_HOME/crenv"
export PATH="$CRENV_ROOT/bin:$PATH"
eval "$(crenv init -)"

# PHPENV (php) =======================================================
export PHPENV_ROOT="$XDG_DATA_HOME/phpenv"
export PATH="$PHPENV_ROOT/bin:${PATH}"
eval "$(phpenv init -)"

# PHP ================================================================
export PHP_DTRACE=yes
export PHP_INI_SCAN_DIR="$XDG_CONFIG_HOME/php:"
alias pear="pear -c $XDG_CONFIG_HOME/pearrc"
alias pecl="pecl -c $XDG_CONFIG_HOME/pearrc"

# COMPOSER ===========================================================
export COMPOSER_HOME="$XDG_CONFIG_HOME/composer"
export PATH="$COMPOSER_HOME/vendor/bin:$PATH"

# NODENV (node) ======================================================
export NODENV_ROOT="$XDG_DATA_HOME/nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"
eval "$(nodenv init -)"

# NODE ===============================================================
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"

# GOENV ==============================================================
export GOENV_ROOT="$XDG_DATA_HOME/goenv"
export GOENV_GOPATH_PREFIX="$XDG_DATA_HOME/go"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"

# GO =================================================================
export CGO_ENABLED=1
export PATH="$GOPATH/bin:$PATH"

# LUAENV (lua) =======================================================
export LUAENV_ROOT="$XDG_DATA_HOME/luaenv"
export PATH="$LUAENV_ROOT/bin:$PATH"
eval "$(luaenv init - )"

# PLENV (perl) =======================================================
export PLENV_ROOT="$XDG_DATA_HOME/plenv"
export PATH="$PLENV_ROOT/bin:$PATH"
eval "$(plenv init -)"

# CPANM ==============================================================
export PERL_CPANM_HOME="$XDG_CACHE_HOME/cpanm"
export PERL_CPANM_OPT="--prompt --notest"

# RENV (r) ===========================================================
export RENV_ROOT="$XDG_DATA_HOME/renv"
export PATH="$RENV_ROOT/bin:$PATH"
eval "$(renv init -)"

# R ==================================================================
export R_PROFILE_USER="$XDG_CONFIG_HOME/Rprofile"
export R_HISTFILE="$XDG_CACHE_HOME/Rhistory"
alias r="R"
alias rscript="Rscript"

# SCALAENV (scala) ===================================================
export SCALAENV_ROOT="$XDG_DATA_HOME/scalaenv"
export PATH="$SCALAENV_ROOT/bin:$PATH"
eval "$(scalaenv init -)"

# COURSIER (scala) ===================================================
export CS_HOME="$XDG_DATA_HOME/coursier"
export PATH="$CS_HOME/bin:$PATH"

# PYENV (python) =====================================================
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# PYTHON =============================================================
export PYTHONSTARTUP="/home/josh/.config/pythonrc"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"

# RBENV (ruby) =======================================================
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# RUBY ===============================================================
export GEMRC="$XDG_CONFIG_HOME/gemrc"
export IRBRC="$XDG_CONFIG_HOME/irb/irbrc"
export BUNDLE_USER_HOME="$XDG_DATA_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle/plugins"

# SDKMAN =============================================================
export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"
source "$SDKMAN_DIR/bin/sdkman-init.sh"

# GRAALVM (java) =====================================================
export GRAALVM_HOME="$SDKMAN_DIR/candidates/java/enterprise-grl"
export GRAAL_EE_DOWNLOAD_TOKEN="RjA4NEJCREEwN0U1OUZDMUUwNTMxODE4MDAwQTdGMTk6Y2RlMDUzNjg5YTRlZWI1OWM5ZDJkNzQ3Mjc4ZDIzM2RkZjMwYjM1ZA" #Friday, 30 December, 2022 05:46:28 PM PST
