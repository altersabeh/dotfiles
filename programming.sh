#!/usr/bin/env sh

# DOTNET =============================================================
export DOTNET_ROOT=/usr/share/dotnet

# PYTHONZ ============================================================
export PYTHONZ_ROOT="$XDG_DATA_HOME/pythonz"
export PYTHONZ_HOME="$XDG_DATA_HOME/pythonz"
source "$PYTHONZ_ROOT/etc/bashrc"

# PYTHONBREW =========================================================
export PYTHONBREW_ROOT="$XDG_DATA_HOME/pythonbrew"
export PYTHONBREW_HOME="$XDG_DATA_HOME/pythonbrew"
eval "$(pythonbrew init)"

# PERLBREW ===========================================================
export PERLBREW_ROOT="$XDG_DATA_HOME/perlbrew"
source "$PERLBREW_ROOT/etc/bashrc"

# PHPBREW ============================================================
export BOX_REQUIREMENT_CHECKER=0
export PHPBREW_ROOT="$XDG_DATA_HOME/phpbrew"
export PHPBREW_HOME="$XDG_DATA_HOME/phpbrew"
source "$PHPBREW_HOME/bashrc"

# RVM (ruby) =========================================================
export PATH="$PATH:$XDG_DATA_HOME/rvm/bin"
source "$XDG_DATA_HOME/rvm/scripts/rvm"

# NVM (node) =========================================================
export NVM_DIR="$XDG_DATA_HOME/nvm"
source "$NVM_DIR/nvm.sh"
source "$NVM_DIR/bash_completion"

# ZVM (zig) ==========================================================
export ZVM_INSTALL="$XDG_DATA_HOME/zvm/self"
export PATH="$XDG_DATA_HOME/zvm/bin:$PATH"
export PATH="$PATH:$ZVM_INSTALL"

# NVIDIA CUDA ========================================================
export CUDA_PATH="/usr/local/cuda"
export PATH="$CUDA_PATH/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_PATH/lib64:$LD_LIBRARY_PATH"

# INTEL ONEAPI =======================================================
source /opt/intel/oneapi/setvars.sh > /dev/null 2> /dev/null

# REPLY (perl) =======================================================
alias reply="reply --cfg "$XDG_CONFIG_HOME/reply/replyrc""

# JAVA ===============================================================
# export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java"

# ZEF ================================================================
export ZEF_CONFIG_STOREDIR="$XDG_DATA_HOME/zef/store"
export ZEF_CONFIG_TEMPDIR="$XDG_CACHE_HOME/zef/temp"

# OCAML ==============================================================
mkdir -p "$XDG_CONFIG_HOME/ocaml"
touch "$XDG_CONFIG_HOME/ocaml/init.ml"

# NUTS (java) ========================================================
source "$XDG_DATA_HOME/nuts/apps/default-workspace/id/net/thevpc/nuts/nuts/0.8.3/inc/.nuts-init.sh"

# FOUNDRY ============================================================
export FOUNDRY_DIR="$XDG_DATA_HOME/foundry"
export PATH="$FOUNDRY_DIR/bin:$PATH"

# MINT (swift) =======================================================
export MINT_PATH="$XDG_DATA_HOME/mint"
export MINT_LINK_PATH="$MINT_PATH/bin"
export PATH="$PATH:$MINT_LINK_PATH"

# PIXI ===============================================================
export PIXI_DIR="$XDG_DATA_HOME/pixi"
export PATH="$PATH:$PIXI_DIR"
eval "$(pixi completion --shell bash)"

# BUN ================================================================
export BUN_INSTALL="$XDG_DATA_HOME/bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# OX CONSOLE =========================================================
alias oxl=oxl64

# AZUL ZING ==========================================================
export PATH="/opt/zing/zing-jdk19/bin:$PATH"

# JETBRAINS ==========================================================
export VMOPTIONSDIR="$XDG_CONFIG_HOME/vmoptions"
# export JETBRAINSCLIENT_VM_OPTIONS="$VMOPTIONSDIR/jetbrainsclient.vmoptions"
export GOLAND_VM_OPTIONS="$VMOPTIONSDIR/goland.vmoptions"
export WEBSTORM_VM_OPTIONS="$VMOPTIONSDIR/webstorm.vmoptions"
export PHPSTORM_VM_OPTIONS="$VMOPTIONSDIR/phpstorm.vmoptions"
export WEBIDE_VM_OPTIONS="$VMOPTIONSDIR/webide.vmoptions"
export GATEWAY_VM_OPTIONS="$VMOPTIONSDIR/gateway.vmoptions"
export DATASPELL_VM_OPTIONS="$VMOPTIONSDIR/dataspell.vmoptions"
export APPCODE_VM_OPTIONS="$VMOPTIONSDIR/appcode.vmoptions"
export IDEA_VM_OPTIONS="$VMOPTIONSDIR/idea.vmoptions"
# export STUDIO_VM_OPTIONS="$VMOPTIONSDIR/studio.vmoptions"
export CLION_VM_OPTIONS="$VMOPTIONSDIR/clion.vmoptions"
export DATAGRIP_VM_OPTIONS="$VMOPTIONSDIR/datagrip.vmoptions"
export RIDER_VM_OPTIONS="$VMOPTIONSDIR/rider.vmoptions"
# export JETBRAINS_CLIENT_VM_OPTIONS="$VMOPTIONSDIR/jetbrains_client.vmoptions"
export PYCHARM_VM_OPTIONS="$VMOPTIONSDIR/pycharm.vmoptions"
export RUBYMINE_VM_OPTIONS="$VMOPTIONSDIR/rubymine.vmoptions"
# export DEVECOSTUDIO_VM_OPTIONS="$VMOPTIONSDIR/devecostudio.vmoptions"

# CUBRID
# source "$XDG_CONFIG_HOME/cubrid.sh"

# IBM ================================================================
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
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

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
export HISTFILE="$XDG_STATE_HOME/bash_history"

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
export OCTAVE_HISTFILE="$XDG_STATE_HOME/octave-history"
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
export BALLERINA_HOME="$XDG_DATA_HOME/ballerina"
export PATH="$BALLERINA_HOME/bin:$PATH"

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

# RAKU ===============================================================
export RAKUDO_HIST="$XDG_STATE_HOME/rakudo_history"

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
export JULIA_HISTORY="$XDG_STATE_HOME/julia_history"
export PATH="$XDG_DATA_HOME/juliaup/bin:$PATH"

# NIMBLE (nim) =======================================================
export NIMBLE_DIR="$XDG_DATA_HOME/nimble"
export PATH="$NIMBLE_DIR/bin:$PATH"
alias choosenim="choosenim --choosenimDir:"$XDG_DATA_HOME"/choosenim"

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
export COMPOSER_HOME="$XDG_DATA_HOME/composer"
export PATH="$COMPOSER_HOME/bin:$PATH"
export PATH="$COMPOSER_HOME/vendor/bin:$PATH"

# NODENV (node) ======================================================
export NODENV_ROOT="$XDG_DATA_HOME/nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"
eval "$(nodenv init -)"

# NODE ===============================================================
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"

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

# COCOAPODS
export CP_HOME_DIR="$XDG_CACHE_HOME/cocoapods"

# CPANM ==============================================================
export PERL_CPANM_HOME="$XDG_CACHE_HOME/cpanm"
export PERL_CPANM_OPT="--prompt --notest"

# RENV (r) ===========================================================
export RENV_ROOT="$XDG_DATA_HOME/renv"
export PATH="$RENV_ROOT/bin:$PATH"
eval "$(renv init -)"

# R ==================================================================
export R_PROFILE_USER="$XDG_CONFIG_HOME/Rprofile"
export R_HISTFILE="$XDG_STATE_HOME/R_history"
alias r="R"
alias rscript="Rscript"

# SCALAENV (scala) ===================================================
export SCALAENV_ROOT="$XDG_DATA_HOME/scalaenv"
export PATH="$SCALAENV_ROOT/bin:$PATH"
eval "$(scalaenv init -)"

# SCALA ==============================================================
export SCALA_HISTFILE="${XDG_STATE_HOME}/scala_history"

# COURSIER (scala) ===================================================
export CS_HOME="$XDG_DATA_HOME/coursier"
export PATH="$CS_HOME/bin:$PATH"

# SHENV (bash)
export SHENV_ROOT="$XDG_DATA_HOME/shenv"
export PATH="$SHENV_ROOT/bin:$PATH"
eval "$(shenv init -)"

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
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"

# SDKMAN =============================================================
export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"
source "$SDKMAN_DIR/bin/sdkman-init.sh"

# GRAALVM (java) =====================================================
export GRAALVM_HOME="$SDKMAN_DIR/candidates/java/enterprise-grl"
export GRAAL_EE_DOWNLOAD_TOKEN="RjA4NEJCREEwN0U1OUZDMUUwNTMxODE4MDAwQTdGMTk6Y2RlMDUzNjg5YTRlZWI1OWM5ZDJkNzQ3Mjc4ZDIzM2RkZjMwYjM1ZA" #Friday, 30 December, 2022 05:46:28 PM PST
