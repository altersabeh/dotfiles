#!/usr/bin/env sh
# ====================================================================
# ================ PRELIMINARIES =====================================
# ====================================================================
# XDG DIRS ===========================================================
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# LOCAL BIN ==========================================================
export LOCAL_BIN_DIR="$HOME/.local/bin"
if [ -d "$LOCAL_BIN_DIR" ] ; then
  PATH="$LOCAL_BIN_DIR:$PATH"
fi


# ====================================================================
# ================ PROGRAMS ==========================================
# ====================================================================
# ADA ================================================================
if [ -d "/usr/lib/x86_64-linux-gnu/ada/adalib" ]; then
  for i in /usr/lib/x86_64-linux-gnu/ada/adalib/*; do
    export ADA_OBJECTS_PATH="$i${ADA_OBJECTS_PATH:+:$ADA_OBJECTS_PATH}"
  done
fi

if [ -d "/usr/share/ada/adainclude" ]; then
  for i in /usr/share/ada/adainclude/*; do
    export ADA_INCLUDE_PATH="$i${ADA_INCLUDE_PATH:+:$ADA_INCLUDE_PATH}"
  done
fi

# ALIRE ==============================================================
export PATH="$XDG_DATA_HOME/alire/bin:$PATH"

# ANSIBLE ============================================================
export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"
export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="$XDG_CACHE_HOME/ansible/galaxy_cache"

# ATOM ===============================================================
# export ATOM_HOME="$XDG_DATA_HOME/atom"

# AWS ================================================================
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"

# AZURE ==============================================================
export AZURE_CONFIG_DIR="$XDG_DATA_HOME/azure"

# BALLERINA ==========================================================
export BALLERINA_HOME="$XDG_DATA_HOME/ballerina"
export PATH="$BALLERINA_HOME/bin:$PATH"

# BASH (history) =====================================================
export HISTFILE="$XDG_STATE_HOME/bash/history"

if [ ! -d "$XDG_STATE_HOME/bash" ]; then
  mkdir -p "$XDG_STATE_HOME/bash"
fi

# BUN ================================================================
export BUN_INSTALL="$XDG_DATA_HOME/bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# BUNDLER ============================================================
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_HOME="$XDG_DATA_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle/plugins"

# C ==================================================================
export GCC_MAJOR_VERSION=$(gcc --version | grep gcc | awk '{ print $3 }' | cut -d. -f1)
export CPATH="/usr/lib/gcc/x86_64-linux-gnu/$GCC_MAJOR_VERSION/include${CPATH:+:$CPATH}"
# export C_INCLUDE_PATH

# C++ ================================================================
# export CPLUS_INCLUDE_PATH

# CABAL ==============================================================
export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
export CABAL_DIR="$XDG_DATA_HOME/cabal"
export PATH="$CABAL_DIR/bin:$PATH"

if [ ! -f "$CABAL_CONFIG" ]; then
  mkdir -p "$XDG_CONFIG_HOME/cabal"
  ln -s "$(dirname "$BASH_SOURCE")/../config/cabal/config" "$CABAL_CONFIG"
fi

# CALC ===============================================================
export CALCHISTFILE="$XDG_STATE_HOME/calc/history"

if [ ! -d "$XDG_STATE_HOME/calc" ]; then
  mkdir -p "$XDG_STATE_HOME/calc"
fi

# CLASSPATH ==========================================================
export CLASSPATH=".${CLASSPATH:+:$CLASSPATH}"

# CLEAN ==============================================================
export CLEAN_HOME="$XDG_DATA_HOME/clean"
export PATH="$CLEAN_HOME/bin:$PATH"

# CLING ==============================================================
export CLING_HISTFILE="$XDG_STATE_HOME/cling/history"
export CLING_NOHISTORY=true

if [ ! -d "$XDG_STATE_HOME/cling" ]; then
  mkdir -p "$XDG_STATE_HOME/cling"
fi

# CLOJURE ============================================================
export GITLIBS="$XDG_CACHE_HOME/clojure-gitlibs"
export PATH="$XDG_DATA_HOME/clojure/bin:$PATH"

# COCOAPODS
export CP_HOME_DIR="$XDG_CACHE_HOME/cocoapods"

# COMPOSER ===========================================================
export COMPOSER_HOME="$XDG_DATA_HOME/composer"
export PATH="$COMPOSER_HOME/bin:$PATH"
export PATH="$COMPOSER_HOME/vendor/bin:$PATH"

# CONAN ==============================================================
export CONAN_USER_HOME="$XDG_CONFIG_HOME"

# CONDA ==============================================================
export CONDA_AUTO_ACTIVATE_BASE=false
export CONDARC="$XDG_CONFIG_HOME/conda/condarc"
eval "$($XDG_DATA_HOME/conda/bin/conda shell.bash hook)"

if [ ! -f "$CONDARC" ]; then
  mkdir -p "$XDG_CONFIG_HOME/conda"
  ln -s "$(dirname "$BASH_SOURCE")/../config/conda/condarc" "$CONDARC"
fi

for i in $(conda env list | grep -oP '^\w+' | grep -v '^base$'); do
   export PATH="$PATH:$(conda info --root)/envs/$i/bin"
done

# COURSIER ===========================================================
export CS_HOME="$XDG_DATA_HOME/coursier"
export PATH="$CS_HOME/bin:$PATH"

# CPANM ==============================================================
export PERL_CPANM_HOME="$XDG_CACHE_HOME/cpanm"
export PERL_CPANM_OPT="--prompt --notest"

# CRENV ==============================================================
# export CRENV_ROOT="$XDG_DATA_HOME/crenv"
# export PATH="$CRENV_ROOT/bin:$PATH"
# eval "$(crenv init -)"

# DART ===============================================================
export DART_CONFIG_DIR="$XDG_CONFIG_HOME/dart"
export ANALYZER_STATE_LOCATION_OVERRIDE="$XDG_CACHE_HOME/dartserver"

# D ==================================================================
export DUB_HOME="$XDG_DATA_HOME/dub"

# DENO JS ============================================================
export DENO_DIR="$XDG_CACHE_HOME/deno"
export DENO_INSTALL="$XDG_DATA_HOME/deno"
export DENO_REPL_HISTORY="$XDG_STATE_HOME/deno/history"
export PATH="$DENO_INSTALL/bin:$PATH"

# DIRENV =============================================================
eval "$(direnv hook bash)"

# DOCKER =============================================================
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# DOTNET =============================================================
export DOTNET_ROOT="/usr/share/dotnet"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export PATH="$PATH:$DOTNET_CLI_HOME/.dotnet/tools"

# EMSCRIPTEN =========================================================
EMSDK_QUIET=1 source "$XDG_DATA_HOME/emsdk/emsdk_env.sh"
export EM_CACHE="$XDG_CACHE_HOME/emscripten/cache"
export EM_CONFIG="$XDG_CONFIG_HOME/emscripten/config"
export EM_PORTS="$XDG_DATA_HOME/emscripten/cache"

# ERLANG =============================================================
if [ ! -d "$XDG_CONFIG_HOME/erlang" ]; then
  mkdir -p "$XDG_CONFIG_HOME/erlang"
fi

# EVM ================================================================
export EVM_HOME="$XDG_DATA_HOME/evm"
source "$EVM_HOME/scripts/evm"

# FACTOR =============================================================
export PATH="$XDG_DATA_HOME/factor:$PATH"

# FOUNDRY ============================================================
export FOUNDRY_DIR="$XDG_DATA_HOME/foundry"
export PATH="$FOUNDRY_DIR/bin:$PATH"

# FVM ================================================================
# export FVM_HOME="$XDG_DATA_HOME/fvm"
# export PATH="$FVM_HOME/default/bin:$PATH"

# GEM ================================================================
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export GEMRC="$XDG_CONFIG_HOME/gem/gemrc"

# GHCUP ==============================================================
export GHCUP_INSTALL_BASE_PREFIX="$XDG_DATA_HOME"
source "$GHCUP_INSTALL_BASE_PREFIX/.ghcup/env"

# GIT ================================================================
export GIT_CONFIG="$XDG_CONFIG_HOME/git/config"

if [ ! -f $GIT_CONFIG ]; then
  mkdir -p "$XDG_CONFIG_HOME/git"
  ln -s $(dirname "$BASH_SOURCE")/../config/git/config $GIT_CONFIG
fi

# GNUSTEP ============================================================
export CPATH="/usr/include/GNUstep${CPATH:+:$CPATH}"

# GO =================================================================
export CGO_ENABLED=1
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export GOPATH="$XDG_DATA_HOME/go"
export PATH="$GOPATH/bin:$PATH"

# GOENV ==============================================================
export GOENV_GOPATH_PREFIX="$GOPATH"
export GOENV_PREPEND_GOPATH=1
export GOENV_ROOT="$XDG_DATA_HOME/goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init - --no-rehash bash)"

# GNUPG ==============================================================
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
alias gpg="gpg --homedir $XDG_DATA_HOME/gnupg"

# GRADLE =============================================================
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# GTK ================================================================
export GTK_RC_FILES="$XDG_CONFIG_HOME/gtk-1.0/gtkrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# IBM ================================================================
# export INFORMIXDIR="/opt/ibm/informix"
# source "$HOME/sqllib/db2profile"

# ICONS ==============================================================
# export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"

# IPYTHON ============================================================
if [ ! -d "$XDG_CONFIG_HOME/ipython" ]; then
  mkdir -p "$XDG_CONFIG_HOME/ipython"
fi

# INSTANTCLIENT
export INSTANTCLIENT=$XDG_DATA_HOME/oracle/instantclient
export LD_LIBRARY_PATH="$INSTANTCLIENT${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

# INTEL ONEAPI =======================================================
source /opt/intel/oneapi/setvars.sh > /dev/null 2> /dev/null

# IRB ================================================================
export IRBRC="$XDG_CONFIG_HOME/irb/irbrc"

if [ ! -f "$IRBRC" ]; then
  mkdir -p "$XDG_CONFIG_HOME/irb"
  ln -s "$(dirname "$BASH_SOURCE")/../config/irb/irbrc" "$IRBRC"
fi

# JAVA ===============================================================
export  _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# JETBRAINS ==========================================================
# export VMOPTIONSDIR="$XDG_CONFIG_HOME/vmoptions"
# export JETBRAINSCLIENT_VM_OPTIONS="$VMOPTIONSDIR/jetbrainsclient.vmoptions"
# export GOLAND_VM_OPTIONS="$VMOPTIONSDIR/goland.vmoptions"
# export WEBSTORM_VM_OPTIONS="$VMOPTIONSDIR/webstorm.vmoptions"
# export PHPSTORM_VM_OPTIONS="$VMOPTIONSDIR/phpstorm.vmoptions"
# export WEBIDE_VM_OPTIONS="$VMOPTIONSDIR/webide.vmoptions"
# export GATEWAY_VM_OPTIONS="$VMOPTIONSDIR/gateway.vmoptions"
# export DATASPELL_VM_OPTIONS="$VMOPTIONSDIR/dataspell.vmoptions"
# export APPCODE_VM_OPTIONS="$VMOPTIONSDIR/appcode.vmoptions"
# export IDEA_VM_OPTIONS="$VMOPTIONSDIR/idea.vmoptions"
# export STUDIO_VM_OPTIONS="$VMOPTIONSDIR/studio.vmoptions"
# export CLION_VM_OPTIONS="$VMOPTIONSDIR/clion.vmoptions"
# export DATAGRIP_VM_OPTIONS="$VMOPTIONSDIR/datagrip.vmoptions"
# export RIDER_VM_OPTIONS="$VMOPTIONSDIR/rider.vmoptions"
# export JETBRAINS_CLIENT_VM_OPTIONS="$VMOPTIONSDIR/jetbrains_client.vmoptions"
# export PYCHARM_VM_OPTIONS="$VMOPTIONSDIR/pycharm.vmoptions"
# export RUBYMINE_VM_OPTIONS="$VMOPTIONSDIR/rubymine.vmoptions"
# export DEVECOSTUDIO_VM_OPTIONS="$VMOPTIONSDIR/devecostudio.vmoptions"

# JULIA ==============================================================
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export JULIA_HISTORY="$XDG_STATE_HOME/julia/history"
export JULIAUP_DEPOT_PATH="$XDG_DATA_HOME/julia"
export PATH="$XDG_DATA_HOME/juliaup/bin:$PATH"

# JUPYTER ============================================================
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_CONFIG_FILE="$JUPYTER_CONFIG_DIR/jupyter_notebook_config.py"

if [ ! -f "$JUPYTER_CONFIG_FILE" ]; then
  mkdir -p "$JUPYTER_CONFIG_DIR"
  ln -s "$(dirname "$BASH_SOURCE")/../config/jupyter/config.py" "$JUPYTER_CONFIG_FILE"
fi

# KERL ===============================================================
export KERL_BASE_DIR="$XDG_DATA_HOME/kerl"
export KERL_CONFIG="$XDG_CONFIG_HOME/kerl/kerlrc"
export KERL_DEFAULT_INSTALL_DIR="$KERL_BASE_DIR/versions"
export KERL_DOC_TARGETS="man"
export KERL_BUILD_DOCS=yes

# KIEX ===============================================================
export KIEX_HOME="$XDG_DATA_HOME/kiex"
source "$KIEX_HOME/scripts/kiex"

# LEIN ===============================================================
export LEIN_HOME="$XDG_DATA_HOME/lein"
export PATH="$LEIN_HOME/bin:$PATH"

# LESS ===============================================================
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

if [ ! -d "$XDG_STATE_HOME/less" ]; then
  mkdir -p "$XDG_STATE_HOME/less"
fi

# LUAENV =============================================================
export LUAENV_ROOT="$XDG_DATA_HOME/luaenv"
export PATH="$LUAENV_ROOT/bin:$PATH"
eval "$(luaenv init - --no-rehash)"

# MAGEFILE ===========================================================
export MAGEFILE_CACHE="$XDG_CACHE_HOME/magefile"

# MAVEN ==============================================================
export MAVEN_OPTS="-Dmaven.repo.local=$XDG_CACHE_HOME/maven/repository"

# MINT ===============================================================
export MINT_PATH="$XDG_DATA_HOME/mint"
export MINT_LINK_PATH="$XDG_DATA_HOME/mint/bin"
export PATH="$MINT_LINK_PATH:$PATH"

# MIX ================================================================
export MIX_HOME="$XDG_DATA_HOME/mix"
export MIX_XDG=1
export PATH="$MIX_HOME/escripts:$PATH"

# MOJO ===============================================================
export MODULAR_HOME="$XDG_DATA_HOME/modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

# MONO ===============================================================
# export MONO_REGISTRY_PATH="$XDG_CACHE_HOME/mono/registry"

# NIMBLE =============================================================
export NIMBLE_DIR="$XDG_DATA_HOME/nimble"
export PATH="$NIMBLE_DIR/bin:$PATH"

# NODE ===============================================================
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node/history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

if [ ! -f "$NPM_CONFIG_USERCONFIG" ]; then
  mkdir -p "$XDG_CONFIG_HOME/npm"
  ln -s "$(dirname "$BASH_SOURCE")/../config/npm/npmrc" "$NPM_CONFIG_USERCONFIG"
fi

# NODENV (node) ======================================================
export NODENV_ROOT="$XDG_DATA_HOME/nodenv"
export PATH="$NODENV_ROOT/bin:$PATH"
eval "$(nodenv init -)"

# NUGET ==============================================================
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

# NVIDIA CUDA ========================================================
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export CUDA_PATH="/usr/local/cuda"
export NVCC_PREPEND_FLAGS="-allow-unsupported-compiler"
export PATH="$CUDA_PATH/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_PATH/lib64:$LD_LIBRARY_PATH"

# NVM ================================================================
# export NVM_DIR="$XDG_DATA_HOME/nvm"
# source "$NVM_DIR/nvm.sh"
# source "$NVM_DIR/bash_completion"

# OBJECTIVE-C ========================================================
# OBJC_INCLUDE_PATH
# OBJCPLUS_INCLUDE_PATH

# OCAML ==============================================================
export OCAML_INIT_FILE="$XDG_CONFIG_HOME/ocaml/init.ml"

if [ ! -f "$OCAML_INIT_FILE" ]; then
  mkdir -p "$XDG_CONFIG_HOME/ocaml"
  ln -s "$(dirname "$BASH_SOURCE")/../config/ocaml/init.ml" "$OCAML_INIT_FILE"
fi

# OCTAVE =============================================================
export OCTAVE_HISTFILE="$XDG_STATE_HOME/octave/history"
export OCTAVE_SITE_INITFILE="$XDG_CONFIG_HOME/octave/octaverc"

if [ ! -f $OCTAVE_SITE_INITFILE ]; then
  mkdir -p "$XDG_CONFIG_HOME/octave"
  ln -s "$(dirname "$BASH_SOURCE")/../config/octave/octaverc" "$OCTAVE_SITE_INITFILE"
fi

# OMNISHARP ==========================================================
export OMNISHARPHOME="$XDG_CONFIG_HOME/omnisharp"

# OPAM ===============================================================
export OPAMROOT="$XDG_DATA_HOME/opam"
export OPAMSOLVERTIMEOUT=1000
source "$OPAMROOT/opam-init/init.sh"

# PERLBREW ===========================================================
# export PERLBREW_ROOT="$XDG_DATA_HOME/perlbrew"
# source "$PERLBREW_ROOT/etc/bashrc"

# PEX ================================================================
export PEX_ROOT="$XDG_CACHE_HOME/pex"

# PGSQL ==============================================================
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_STATE_HOME/psql/history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"

if [ ! -d "$XDG_CONFIG_HOME/pg" ]; then
  mkdir -p "$XDG_CONFIG_HOME/pg"
fi

if [ ! -d "$XDG_STATE_HOME/psql" ]; then
  mkdir -p "$XDG_STATE_HOME/psql"
fi

# PHP ================================================================
export PHP_DTRACE=yes
export PHP_INI_SCAN_DIR="$XDG_CONFIG_HOME/php"

if [ ! -d "$PHP_INI_SCAN_DIR" ]; then
  ln -s "$(dirname "$BASH_SOURCE")/../config/php" "$PHP_INI_SCAN_DIR"
fi

# PHPBREW ============================================================
# export BOX_REQUIREMENT_CHECKER=0
# export PHPBREW_ROOT="$XDG_DATA_HOME/phpbrew"
# export PHPBREW_HOME="$XDG_DATA_HOME/phpbrew"
# source "$PHPBREW_HOME/bashrc"

# PHPENV =============================================================
export PHPENV_ROOT="$XDG_DATA_HOME/phpenv"
export PATH="$PHPENV_ROOT/bin:${PATH}"
eval "$(phpenv init - --no-rehash)"

# PLENV ==============================================================
export PLENV_ROOT="$XDG_DATA_HOME/plenv"
export PATH="$PLENV_ROOT/bin:$PATH"
eval "$(plenv init -)"

# PONYUP =============================================================
export PATH="$XDG_DATA_HOME/ponyup/bin:$PATH"

# PROCESSING =========================================================
# export PROCESSING_JAVA="$XDG_DATA_HOME/processing/processing-java"
# export PATH="$XDG_DATA_HOME/processing:$PATH"

# PUB ================================================================
export PUB_CACHE="$XDG_DATA_HOME/pub-cache"
export PATH="$PATH:$PUB_CACHE/bin"

# PYENV ==============================================================
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - --no-rehash bash)"

# PYTHON =============================================================
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"
export PYTHONPYCACHEPREFIX="/tmp/pycache"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"

if [ ! -f $PYTHONSTARTUP ]; then
  mkdir -p "$XDG_CONFIG_HOME/python"
  ln -s "$(dirname "$BASH_SOURCE")/../config/python/pythonrc" "$PYTHONSTARTUP"
fi

if [ ! -d "$XDG_STATE_HOME/python" ]; then
  mkdir -p "$XDG_STATE_HOME/python"
fi

# PYTHONBREW =========================================================
# export PYTHONBREW_ROOT="$XDG_DATA_HOME/pythonbrew"
# export PYTHONBREW_HOME="$XDG_DATA_HOME/pythonbrew"
# eval "$(pythonbrew init)"

# PYTHONZ ============================================================
# export PYTHONZ_ROOT="$XDG_DATA_HOME/pythonz"
# export PYTHONZ_HOME="$XDG_DATA_HOME/pythonz"
# source "$PYTHONZ_ROOT/etc/bashrc"

# R ==================================================================
export R_HISTFILE="$XDG_STATE_HOME/R/history"
export R_HOME_USER="$XDG_CONFIG_HOME/R"
export R_LIBS="$XDG_DATA_HOME/R/library"
export R_PROFILE_USER="$R_HOME_USER/profile"

if [ ! -d "$R_HOME_USER" ]; then
  mkdir -p "$R_HOME_USER"
fi

if [ ! -d "$XDG_STATE_HOME/R" ]; then
  mkdir -p "$XDG_STATE_HOME/R"
fi

if [ ! -d "$R_LIBS" ]; then
  mkdir -p "$R_LIBS"
fi

alias r="R"
alias rscript="Rscript"

# RAKU ===============================================================
export RAKUDO_HIST="$XDG_STATE_HOME/rakudo/history"

# RAKUBREW ===========================================================
export RAKUBREW_HOME="$XDG_DATA_HOME/rakubrew"
eval "$($RAKUBREW_HOME/bin/rakubrew init Bash)"

# RBENV ==============================================================
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init - --no-rehash)"

# REBAR3 =============================================================
export PATH="$XDG_CACHE_HOME/rebar3/bin:$PATH"

# RED ================================================================
export PATH="$XDG_DATA_HOME/red/bin:$PATH"

# RENV ===============================================================
export RENV_ROOT="$XDG_DATA_HOME/renv"
export PATH="$RENV_ROOT/bin:$PATH"
eval "$(renv init - --no-rehash)"

# REPLY ==============================================================
alias reply="reply --cfg "$XDG_CONFIG_HOME/reply/replyrc""

# ROSWELL ===========================================================
export ROSWELL_HOME="$XDG_DATA_HOME/roswell"
export PATH="$ROSWELL_HOME/bin:$PATH"

# RUBY ===============================================================

# RUST ===============================================================
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
source "$CARGO_HOME/env"

# RVM ================================================================
# export PATH="$PATH:$XDG_DATA_HOME/rvm/bin"
# source "$XDG_DATA_HOME/rvm/scripts/rvm"

# SBT ================================================================
export SBT_OPTS="-ivy $XDG_DATA_HOME/ivy2 -sbt-dir $XDG_DATA_HOME/sbt"

# SCALA ==============================================================
export SCALA_HISTFILE="$XDG_STATE_HOME/scala/history"

if [ ! -d "$XDG_STATE_HOME/scala" ]; then
  mkdir -p "$XDG_STATE_HOME/scala"
fi

# SCALAENV ===========================================================
# export SCALAENV_ROOT="$XDG_DATA_HOME/scalaenv"
# export PATH="$SCALAENV_ROOT/bin:$PATH"
# eval "$(scalaenv init -)"

# SCILAB =============================================================
export SCIHOME="$XDG_DATA_HOME/scilab"
alias scilab="scilab-cli -scihome $SCIHOME"
alias scilab-cli="scilab-cli -scihome $SCIHOME"

# SDKMAN =============================================================
export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"
source "$SDKMAN_DIR/bin/sdkman-init.sh"

export JAVA_CALLER_JAVA_EXECUTABLE="$JAVA_HOME/bin/java.exe"

# SHENV ==============================================================
# export SHENV_ROOT="$XDG_DATA_HOME/shenv"
# export PATH="$SHENV_ROOT/bin:$PATH"
# eval "$(shenv init -)"

# SOLARGRAPH =========================================================
export SOLARGRAPH_CACHE="$XDG_CACHE_HOME/solargraph"

# STACK ==============================================================
export STACK_ROOT="$XDG_DATA_HOME/stack"

# STARSHIP ===========================================================
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"

# SUBVERSION =========================================================
alias svn="svn --config-dir $XDG_CONFIG_HOME/subversion"

# SWIFTLINT ==========================================================
export LINUX_SOURCEKIT_LIB_PATH="/usr/libexec/swift/lib/libsourcekitdInProc.so"

# SWIFTENV (swift) ===================================================
# export SWIFTENV_ROOT="$XDG_DATA_HOME/swiftenv"
# export PATH="$SWIFTENV_ROOT/bin:$PATH"
# eval "$(swiftenv init -)"

# TERRAFORM ==========================================================
export TF_HOME_DIR="$XDG_DATA_HOME/terraform"

# TEXLIVE ============================================================
export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"

# V ==================================================================
export VCACHE="$XDG_CACHE_HOME/vmodules"
export PATH="$XDG_CONFIG_HOME/v-analyzer/:$PATH"
export PATH="$XDG_DATA_HOME/v:$PATH"


# VAGRANT ============================================================
export VAGRANT_HOME="$XDG_DATA_HOME/vagrant"
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME/vagrant/aliases"

# W3M ================================================================
export W3M_DIR="$XDG_STATE_HOME/w3m"

# WGET ===============================================================
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

if [ ! -f "$WGETRC" ]; then
  mkdir -p "$XDG_CONFIG_HOME/wget"
  ln -s "$(dirname "$BASH_SOURCE")/../config/wget/wgetrc" "$WGETRC"
fi

# XORG ===============================================================
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export XSERVERRC="$XDG_CONFIG_HOME/X11/xserverrc"

# ZEEK ===============================================================
export PATH="/opt/zeek/bin:$PATH"

# ZEF ================================================================
export ZEF_CONFIG_STOREDIR="$XDG_DATA_HOME/zef/store"
export ZEF_CONFIG_TEMPDIR="$XDG_CACHE_HOME/zef/temp"

# ====================================================================
# ================ CUSTOMIZATION =====================================
# ====================================================================
# SET CUSTOM PATH ====================================================
export PATH="$PLENV_ROOT/versions/$(plenv global)/bin:$PATH"
export PATH="$RBENV_ROOT/versions/$(rbenv global)/bin:$PATH"
export PATH="$PYENV_ROOT/versions/$(pyenv global)/bin:$PATH"
export PATH="$GOENV_ROOT/versions/$(goenv global)/bin:$PATH"
export PATH="$PHPENV_ROOT/versions/$(phpenv global)/bin:$PATH"
export PATH="$NODENV_ROOT/versions/$(nodenv global)/bin:$PATH"
export PATH="$RENV_ROOT/versions/$(renv global)/bin:$PATH"
export PATH="$LUAENV_ROOT/versions/$(luaenv global)/bin:$PATH"

# OH MY POSH =========================================================
eval "$(oh-my-posh init bash --config ~/.cache/oh-my-posh/themes/atomic.omp.json)"

# USE WINDOWS BROWSER IN WSL =========================================
if grep -q WSL /proc/version; then
  export BROWSER="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe %s"
fi

# CUSTOM LIBRARY PATHS ===============================================
export LIBRARY_PATH="$LD_LIBRARY_PATH"

# CUSTOM LIMITS
ulimit -n 104857

unset i
