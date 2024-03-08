#!/usr/bin/env bash
# ====================================================================
# ================ PRELIMINARIES =====================================
# ====================================================================
# XDG DIRS ===========================================================
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# LOCAL BIN ==========================================================
export LOCAL_BIN_DIR="${HOME}/.local/bin"
if [ -d "${LOCAL_BIN_DIR}" ]; then
  PATH="${LOCAL_BIN_DIR}:${PATH}"
fi

# ====================================================================
# ================ PROGRAMS ==========================================
# ====================================================================
# ADA ================================================================
if command -v gnat >/dev/null 2>&1; then
  for item in /usr/lib/x86_64-linux-gnu/ada/adalib/*; do
    if [ -d "$item" ]; then
      ADA_OBJECTS_PATH+="${ADA_OBJECTS_PATH:+:}${item}"
    fi
  done

  for item in /usr/share/ada/adainclude/*; do
    if [ -d "$item" ]; then
      ADA_INCLUDE_PATH+="${ADA_INCLUDE_PATH:+:}${item}"
    fi
  done
fi

# ALIRE ==============================================================
PATH="${XDG_DATA_HOME}/alire/bin:${PATH}"

# ANSIBLE ============================================================
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"

# ASDF ===============================================================
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"

[ -f "${ASDF_DATA_DIR}/asdf.sh" ] && . "${ASDF_DATA_DIR}/asdf.sh"

if command -v asdf >/dev/null 2>&1; then
  if [ ! -f "${ASDF_CONFIG_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/asdf"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/asdf/asdfrc" "${ASDF_CONFIG_FILE}"
  fi
fi

# ATOM ===============================================================
# export ATOM_HOME="${XDG_DATA_HOME}/atom"

# AWS ================================================================
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"

# AZURE ==============================================================
export AZURE_CONFIG_DIR="${XDG_DATA_HOME}/azure"

# BALLERINA ==========================================================
export BALLERINA_HOME="${XDG_DATA_HOME}/ballerina"
PATH="${BALLERINA_HOME}/bin:${PATH}"

# BASH ===============================================================
item="$(ps -cp "$$" -o command="")"
export HISTFILE="${XDG_STATE_HOME}/${item}/history"

[ ! -f "${HISTFILE}" ] && mkdir -p "${XDG_STATE_HOME}/${item}"

# BUN ================================================================
export BUN_INSTALL="${XDG_DATA_HOME}/bun"
PATH="${BUN_INSTALL}/bin:${PATH}"

# C ==================================================================
if command -v gcc >/dev/null 2>&1; then
  GCC_MAJOR_VERSION="$(gcc --version | awk '/gcc/ { print $3 }' | cut -d. -f1)"
  X86_64_LIB_PATH="/usr/lib/gcc/x86_64-linux-gnu"
  # CPATH="${X86_64_LIB_PATH}/${GCC_MAJOR_VERSION}/include${CPATH:+:${CPATH}}"
  LIBRARY_PATH="/usr/lib/x86_64-linux-gnu${LIBRARY_PATH:+:${LIBRARY_PATH}}"
#  C_INCLUDE_PATH
fi

# C++ ================================================================
# CPLUS_INCLUDE_PATH

# CALC ===============================================================
export CALCHISTFILE="${XDG_STATE_HOME}/calc/history"

if command -v calc >/dev/null 2>&1; then
  mkdir -p "${XDG_STATE_HOME}/calc"
fi

# CLEAN ==============================================================
export CLEAN_HOME="${XDG_DATA_HOME}/clean"
PATH="${CLEAN_HOME}/bin:${PATH}"

# CLING ==============================================================
export CLING_HISTFILE="${XDG_STATE_HOME}/cling/history"
export CLING_NOHISTORY=true

if command -v cling >/dev/null 2>&1; then
  mkdir -p "${XDG_STATE_HOME}/cling"
fi

# CLOJURE ============================================================
export GITLIBS="${XDG_CACHE_HOME}/clojure-gitlibs"
PATH="${XDG_DATA_HOME}/clojure/bin:${PATH}"

# COCOAPODS
export CP_HOME_DIR="${XDG_CACHE_HOME}/cocoapods"

# COMPOSER ===========================================================
export COMPOSER_HOME="${XDG_DATA_HOME}/composer"
PATH="${COMPOSER_HOME}/bin:${PATH}"
PATH="${COMPOSER_HOME}/vendor/bin:${PATH}"

# CONAN ==============================================================
export CONAN_USER_HOME="${XDG_CONFIG_HOME}"

# CONDA ==============================================================
export CONDA_AUTO_ACTIVATE_BASE=false
export CONDARC="${XDG_CONFIG_HOME}/conda/condarc"
PATH="${XDG_DATA_HOME}/conda/condabin:${PATH}"

if command -v conda >/dev/null 2>&1; then
  eval "$(conda shell.bash hook)"

  if [ ! -f "${CONDARC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/conda"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/conda/condarc" "${CONDARC}"
  fi

  for item in $(conda env list | awk '$1 != "#" && $1 != "base" {print $1}'); do
    CONDA_ROOT="$(conda info --root)"
    PATH="${PATH}:${CONDA_ROOT}/envs/${item}/bin"
  done
fi

# COURSIER ===========================================================
export CS_HOME="${XDG_DATA_HOME}/coursier"
PATH="${CS_HOME}/bin:${PATH}"

# CRENV ==============================================================
# export CRENV_ROOT="${XDG_DATA_HOME}/crenv"
# PATH="$CRENV_ROOT/bin:${PATH}"
# eval "$(crenv init -)"

# DART ===============================================================
export DART_CONFIG_DIR="${XDG_CONFIG_HOME}/dart"
export ANALYZER_STATE_LOCATION_OVERRIDE="${XDG_CACHE_HOME}/dartserver"

# D ==================================================================
export DUB_HOME="${XDG_DATA_HOME}/dub"

# DENO JS ============================================================
export DENO_DIR="${XDG_CACHE_HOME}/deno"
export DENO_INSTALL="${XDG_DATA_HOME}/deno"
export DENO_REPL_HISTORY="${XDG_STATE_HOME}/deno/history"
PATH="${DENO_INSTALL}/bin:${PATH}"

# DIRENV =============================================================
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook bash)"

# DOCKER =============================================================
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# DOTNET =============================================================
export DOTNET_ROOT="/usr/share/dotnet"
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"
PATH="${PATH}:${DOTNET_CLI_HOME}/.dotnet/tools"

# EMSCRIPTEN =========================================================
export EMSDK_QUIET=1

[ -f "${XDG_DATA_HOME}/emsdk/emsdk_env.sh" ] && . "${XDG_DATA_HOME}/emsdk/emsdk_env.sh"

export EM_CACHE="${XDG_CACHE_HOME}/emscripten/cache"
export EM_CONFIG="${XDG_CONFIG_HOME}/emscripten/config"
export EM_PORTS="${XDG_DATA_HOME}/emscripten/cache"

# EVM ================================================================
export EVM_HOME="${XDG_DATA_HOME}/evm"

[ -f "${EVM_HOME}/scripts/evm" ] && . "${EVM_HOME}/scripts/evm"

# ERLANG =============================================================
if command -v erl >/dev/null 2>&1; then
  mkdir -p "${XDG_CONFIG_HOME}/erlang"
fi

# FACTOR =============================================================
PATH="${XDG_DATA_HOME}/factor:${PATH}"

# FOUNDRY ============================================================
export FOUNDRY_DIR="${XDG_DATA_HOME}/foundry"
PATH="${FOUNDRY_DIR}/bin:${PATH}"

# FVM ================================================================
# export FVM_HOME="${XDG_DATA_HOME}/fvm"
# PATH="$FVM_HOME/default/bin:${PATH}"

# GHCUP ==============================================================
export GHCUP_INSTALL_BASE_PREFIX="${XDG_DATA_HOME}"

[ -f "${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/env" ] && . "${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/env"

# CABAL ==============================================================
export CABAL_CONFIG="${XDG_CONFIG_HOME}/cabal/config"
export CABAL_DIR="${XDG_DATA_HOME}/cabal"
PATH="${CABAL_DIR}/bin:${PATH}"

if command -v cabal >/dev/null 2>&1; then
  if [ ! -f "${CABAL_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/cabal"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/cabal/config" "${CABAL_CONFIG}"
  fi
fi

# STACK ==============================================================
export STACK_XDG=1
export STACK_CONFIG_YAML="${XDG_CONFIG_HOME}/stack/config.yaml"

if command -v stack >/dev/null 2>&1; then
  if [ ! -d "${XDG_DATA_HOME}/stack/hooks" ]; then
    mkdir -p "${XDG_DATA_HOME}/stack"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/stack/hooks" "${XDG_DATA_HOME}/stack/hooks"
  fi

  if [ ! -f "${STACK_CONFIG_YAML}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/stack"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/stack/config.yaml" "${STACK_CONFIG_YAML}"
  fi
fi

# GIT ================================================================
export GIT_CONFIG="${XDG_CONFIG_HOME}/git/config"

if command -v git >/dev/null 2>&1; then
  if [ ! -f "${GIT_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/git"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/git/config" "${GIT_CONFIG}"
  fi
fi

# GNUSTEP ============================================================
if [ -d "/usr/include/GNUstep" ]; then
  CPATH="/usr/include/GNUstep${CPATH:+:$CPATH}"
fi

# GOENV ==============================================================
export GOENV_GOPATH_PREFIX="${GOPATH}"
export GOENV_PREPEND_GOPATH=1
export GOENV_ROOT="${XDG_DATA_HOME}/goenv"
PATH="${GOENV_ROOT}/bin:${PATH}"

command -v goenv >/dev/null 2>&1 && eval "$(goenv init - --no-rehash bash)"

PATH="$GOENV_ROOT/versions/$(goenv global)/bin:${PATH}"

# GO =================================================================
if command -v go >/dev/null 2>&1; then
  export CGO_ENABLED=1
  export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"
  export GOPATH="${XDG_DATA_HOME}/go"
  PATH="${GOPATH}/bin:${PATH}"
fi

# GNUPG ==============================================================
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

if [ ! -d "${GNUPGHOME}" ]; then
  mkdir -p "${GNUPGHOME}"
  chmod 700 "${GNUPGHOME}"
fi

# GRADLE =============================================================
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# GTK ================================================================
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"

# IBM ================================================================
# export INFORMIXDIR="/opt/ibm/informix"
# . "${HOME}/sqllib/db2profile"

# ICONS ==============================================================
# export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"

# INSTANTCLIENT
export INSTANTCLIENT="${XDG_DATA_HOME}/oracle/instantclient"

LD_LIBRARY_PATH="${INSTANTCLIENT}${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"

# INTEL ONEAPI =======================================================
[ -f "/opt/intel/oneapi/setvars.sh" ] && . "/opt/intel/oneapi/setvars.sh" >/dev/null 2>&1

# JETBRAINS ==========================================================
# export VMOPTIONSDIR="${XDG_CONFIG_HOME}/vmoptions"
# export JETBRAINSCLIENT_VM_OPTIONS="${VMOPTIONSDIR}/jetbrainsclient.vmoptions"
# export GOLAND_VM_OPTIONS="${VMOPTIONSDIR}/goland.vmoptions"
# export WEBSTORM_VM_OPTIONS="${VMOPTIONSDIR}/webstorm.vmoptions"
# export PHPSTORM_VM_OPTIONS="${VMOPTIONSDIR}/phpstorm.vmoptions"
# export WEBIDE_VM_OPTIONS="${VMOPTIONSDIR}/webide.vmoptions"
# export GATEWAY_VM_OPTIONS="${VMOPTIONSDIR}/gateway.vmoptions"
# export DATASPELL_VM_OPTIONS="${VMOPTIONSDIR}/dataspell.vmoptions"
# export APPCODE_VM_OPTIONS="${VMOPTIONSDIR}/appcode.vmoptions"
# export IDEA_VM_OPTIONS="${VMOPTIONSDIR}/idea.vmoptions"
# export STUDIO_VM_OPTIONS="${VMOPTIONSDIR}/studio.vmoptions"
# export CLION_VM_OPTIONS="${VMOPTIONSDIR}/clion.vmoptions"
# export DATAGRIP_VM_OPTIONS="${VMOPTIONSDIR}/datagrip.vmoptions"
# export RIDER_VM_OPTIONS="${VMOPTIONSDIR}/rider.vmoptions"
# export JETBRAINS_CLIENT_VM_OPTIONS="${VMOPTIONSDIR}/jetbrains_client.vmoptions"
# export PYCHARM_VM_OPTIONS="${VMOPTIONSDIR}/pycharm.vmoptions"
# export RUBYMINE_VM_OPTIONS="${VMOPTIONSDIR}/rubymine.vmoptions"
# export DEVECOSTUDIO_VM_OPTIONS="${VMOPTIONSDIR}/devecostudio.vmoptions"

# JULIA ==============================================================
export JULIA_DEPOT_PATH="${XDG_DATA_HOME}/julia:${JULIA_DEPOT_PATH}"
export JULIA_HISTORY="${XDG_STATE_HOME}/julia/history"
export JULIAUP_DEPOT_PATH="${XDG_DATA_HOME}/julia"
PATH="${XDG_DATA_HOME}/juliaup/bin:${PATH}"

# KERL ===============================================================
export KERL_BASE_DIR="${XDG_DATA_HOME}/kerl"
export KERL_CONFIG="${XDG_CONFIG_HOME}/kerl/kerlrc"
export KERL_DEFAULT_INSTALL_DIR="${KERL_BASE_DIR}/versions"
export KERL_DOC_TARGETS=man
export KERL_BUILD_DOCS=yes

# KIEX ===============================================================
export KIEX_HOME="${XDG_DATA_HOME}/kiex"

[ -f "${KIEX_HOME}/scripts/kiex" ] && . "${KIEX_HOME}/scripts/kiex"

# LEIN ===============================================================
export LEIN_HOME="${XDG_DATA_HOME}/lein"
PATH="${LEIN_HOME}/bin:${PATH}"

# LESS ===============================================================
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"

if command -v less >/dev/null 2>&1; then
  mkdir -p "${XDG_STATE_HOME}/less"
fi

# LUAENV =============================================================
export LUAENV_ROOT="${XDG_DATA_HOME}/luaenv"
PATH="${LUAENV_ROOT}/bin:${PATH}"

if command -v luarocks >/dev/null 2>&1; then
  eval "$(luaenv init - --no-rehash)"

  if [ ! -f "${LUAENV_ROOT}/default-rocks" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/luaenv/default-rocks" "${LUAENV_ROOT}/default-rocks"
  fi

  LUAENV_LUA_PATH="$LUAENV_ROOT/versions/$(luaenv global)"
  PATH="${LUAENV_LUA_PATH}/bin:${PATH}"
  MANPATH="${LUAENV_LUA_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# LUAROCKS ===========================================================
export LUAROCKS_CONFIG="${XDG_CONFIG_HOME}/luarocks/config.lua"
export LUAROCKS_TREE="${XDG_DATA_HOME}/luarocks"

if command -v luarocks >/dev/null 2>&1; then
  if [ ! -f "${LUAROCKS_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/luarocks"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/luarocks/config.lua" "${LUAROCKS_CONFIG}"
  fi

  eval "$(luarocks path --bin)"
fi

# MAGEFILE ===========================================================
export MAGEFILE_CACHE="${XDG_CACHE_HOME}/magefile"

# MAVEN ==============================================================
export MAVEN_OPTS="-Dmaven.repo.local=${XDG_CACHE_HOME}/maven/repository"

# MINT ===============================================================
export MINT_PATH="${XDG_DATA_HOME}/mint"
export MINT_LINK_PATH="${XDG_DATA_HOME}/mint/bin"
PATH="${MINT_LINK_PATH}:${PATH}"

# MIX ================================================================
export MIX_HOME="${XDG_DATA_HOME}/mix"
export MIX_XDG=1
PATH="${MIX_HOME}/escripts:${PATH}"

# MOJO ===============================================================
export MODULAR_HOME="${XDG_DATA_HOME}/modular"
PATH="${MODULAR_HOME}/pkg/packages.modular.com_mojo/bin:${PATH}"

# MONO ===============================================================
# export MONO_REGISTRY_PATH="${XDG_CACHE_HOME}/mono/registry"

# NIMBLE =============================================================
export NIMBLE_DIR="${XDG_DATA_HOME}/nimble"
PATH="${NIMBLE_DIR}/bin:${PATH}"

# NVIDIA CUDA ========================================================
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export CUDA_PATH="/usr/local/cuda"
export NVCC_PREPEND_FLAGS="-allow-unsupported-compiler"
PATH="${CUDA_PATH}/bin:${PATH}"
LD_LIBRARY_PATH="${CUDA_PATH}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"

# NODENV (node) ======================================================
export NODENV_ROOT="${XDG_DATA_HOME}/nodenv"
PATH="${NODENV_ROOT}/bin:${PATH}"

if command -v nodenv >/dev/null 2>&1; then
  eval "$(nodenv init -)"

  if [ ! -f "${NODENV_ROOT}/default-packages" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/nodenv/default-packages" "${NODENV_ROOT}/default-packages"
  fi

  NODENV_NODE_PATH="$NODENV_ROOT/versions/$(nodenv global)"
  PATH="${NODENV_NODE_PATH}/bin:${PATH}"
  MANPATH="${NODENV_NODE_PATH}/share/man${MANPATH:+:${MANPATH}}"
  MANPATH="${NODENV_NODE_PATH}/lib/node_modules/npm/man${MANPATH:+:${MANPATH}}"
fi

# NODE ===============================================================
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node/history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME}/npm"
PATH="${NPM_CONFIG_PREFIX}/bin:${PATH}"

if command -v npm >/dev/null 2>&1; then
  if [ ! -f "${NPM_CONFIG_USERCONFIG}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/npm/npmrc" "${NPM_CONFIG_USERCONFIG}"
    mkdir -p "${XDG_CONFIG_HOME}/npm"
  fi
fi

# NUGET ==============================================================
export NUGET_HTTP_CACHE_PATH="${XDG_CACHE_HOME}/nuget/http-cache"
export NUGET_PACKAGES="${XDG_CACHE_HOME}/nuget/packages"
export NUGET_PLUGINS_CACHE_PATH="${XDG_CACHE_HOME}/nuget/plugins"

# NVM ================================================================
# export NVM_DIR="${XDG_DATA_HOME}/nvm"
# . "${NVM_DIR}/nvm.sh"
# . "${NVM_DIR}/bash_completion"

# OBJECTIVE-C ========================================================
# OBJC_INCLUDE_PATH
# OBJCPLUS_INCLUDE_PATH

# OCAML ==============================================================
if command -v ocaml >/dev/null 2>&1; then
  export OCAML_INIT_FILE="${XDG_CONFIG_HOME}/ocaml/init.ml"

  if [ ! -f "${OCAML_INIT_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/ocaml"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/ocaml/init.ml" "${OCAML_INIT_FILE}"
  fi
fi

# OCTAVE =============================================================
export OCTAVE_HISTFILE="${XDG_STATE_HOME}/octave/history"
export OCTAVE_SITE_INITFILE="${XDG_CONFIG_HOME}/octave/octaverc"

if command -v octave >/dev/null 2>&1; then
  if [ ! -d "${XDG_DATA_HOME}/octave" ]; then
    mkdir -p "${XDG_DATA_HOME}/octave"
  fi

  if [ ! -f "${OCTAVE_SITE_INITFILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/octave"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/octave/octaverc" "${OCTAVE_SITE_INITFILE}"
  fi
fi

# OMNISHARP ==========================================================
export OMNISHARPHOME="${XDG_CONFIG_HOME}/omnisharp"

# OPAM ===============================================================
export OPAMAUTOREMOVE=1
export OPAMROOT="${XDG_DATA_HOME}/opam"
export OPAMSOLVERTIMEOUT=1000

[ -f "${OPAMROOT}/opam-init/init.sh" ] && . "${OPAMROOT}/opam-init/init.sh"

# PERLBREW ===========================================================
# export PERLBREW_ROOT="${XDG_DATA_HOME}/perlbrew"
# . "${PERLBREW_ROOT}/etc/bashrc"

# PEX ================================================================
export PEX_ROOT="${XDG_CACHE_HOME}/pex"

# PGSQL ==============================================================
export PSQLRC="${XDG_CONFIG_HOME}/pg/psqlrc"
export PSQL_HISTORY="${XDG_STATE_HOME}/psql/history"
export PGPASSFILE="${XDG_CONFIG_HOME}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME}/pg/pg_service.conf"

if [ ! -d "${XDG_CONFIG_HOME}/pg" ]; then
  mkdir -p "${XDG_CONFIG_HOME}/pg"
fi

if [ ! -d "${XDG_STATE_HOME}/psql" ]; then
  mkdir -p "${XDG_STATE_HOME}/psql"
fi

# PHPENV =============================================================
export PHPENV_ROOT="${XDG_DATA_HOME}/phpenv"
PATH="${PHPENV_ROOT}/bin:${PATH}"

if command -v phpenv >/dev/null 2>&1; then
  eval "$(phpenv init - --no-rehash)"

  PHPENV_PHP_PATH="${PHPENV_ROOT}/versions/$(phpenv global)"
  PATH="${PHPENV_PHP_PATH}/bin:${PATH}"
  MANPATH="${PHPENV_PHP_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# PHP ================================================================
export PHP_DTRACE=yes

if command -v php >/dev/null 2>&1; then
  export PHP_INI_SCAN_DIR="${XDG_CONFIG_HOME}/php"

  if [ ! -d "${PHP_INI_SCAN_DIR}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/php" "$PHP_INI_SCAN_DIR"
  fi
fi

# PHPBREW ============================================================
# export BOX_REQUIREMENT_CHECKER=0
# export PHPBREW_ROOT="${XDG_DATA_HOME}/phpbrew"
# export PHPBREW_HOME="${XDG_DATA_HOME}/phpbrew"
# . "${PHPBREW_HOME}/bashrc"

# PLENV ==============================================================
export PLENV_ROOT="${XDG_DATA_HOME}/plenv"
PATH="${PLENV_ROOT}/bin:${PATH}"

if command -v plenv >/dev/null 2>&1; then
  eval "$(plenv init -)"

  PLENV_PERL_PATH="${PLENV_ROOT}/versions/$(plenv global)"
  PATH="${PLENV_PERL_PATH}/bin:${PATH}"
  MANPATH="${PLENV_PERL_PATH}/man${MANPATH:+:${MANPATH}}"
fi

# PERL
PATH="${XDG_DATA_HOME}/perl/bin:${PATH}"

if command -v perl >/dev/null 2>&1; then
  export PERL_LOCAL_LIB_ROOT="${XDG_DATA_HOME}/perl${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
  export PERL_MB_OPT="--install_base ${XDG_DATA_HOME}/perl"
  export PERL_MM_OPT="INSTALL_BASE=${XDG_DATA_HOME}/perl"
  export PERL5LIB="${XDG_DATA_HOME}/perl/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
fi

# CPANM ==============================================================
if command -v cpanm >/dev/null 2>&1; then
  export PERL_CPANM_HOME="${XDG_CACHE_HOME}/cpanm"
  export PERL_CPANM_OPT="--prompt --notest -l ${XDG_DATA_HOME}/perl"
fi

# REPLY ==============================================================
if command -v reply >/dev/null 2>&1; then
  alias reply='reply --cfg ${XDG_CONFIG_HOME}/reply/replyrc'
fi

# PONYUP =============================================================
PATH="${XDG_DATA_HOME}/ponyup/bin:${PATH}"

# PROCESSING =========================================================
# export PROCESSING_JAVA="${XDG_DATA_HOME}/processing/processing-java"
# PATH="${XDG_DATA_HOME}/processing:${PATH}"

# PUB ================================================================
export PUB_CACHE="${XDG_DATA_HOME}/pub-cache"
PATH="${PATH}:${PUB_CACHE}/bin"

# PYENV ==============================================================
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
PATH="${PYENV_ROOT}/bin:${PATH}"

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - --no-rehash)"

  if [ ! -f "${PYENV_ROOT}/default-packages" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/pyenv/default-packages" "${PYENV_ROOT}/default-packages"
  fi

  PYENV_PYTHON_PATH="${PYENV_ROOT}/versions/$(pyenv global)"
  PATH="${PYENV_PYTHON_PATH}/bin:${PATH}"
  MANPATH="${PYENV_PYTHON_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# PYTHON =============================================================
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history"
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/pycache"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export PYTHONUSERBASE="${XDG_DATA_HOME}/pip"

if command -v python >/dev/null 2>&1; then
  mkdir -p "${XDG_STATE_HOME}/python"

  if [ ! -f "${PYTHONSTARTUP}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/python"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/python/pythonrc" "${PYTHONSTARTUP}"
  fi
fi

# PIP ================================================================
PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
PATH="${PYTHONUSERBASE}/bin:${PATH}"

if command -v pip >/dev/null 2>&1; then
  if [ ! -f "${PIP_CONFIG_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/pip"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/pip/pip.conf" "${PIP_CONFIG_FILE}"
  fi
fi

# IPYTHON ============================================================
if command -v ipython >/dev/null 2>&1; then
  mkdir -p "${XDG_CONFIG_HOME}/ipython"
fi

# JUPYTER ============================================================
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_FILE="$JUPYTER_CONFIG_DIR/jupyter_notebook_config.py"

if command -v jupyter >/dev/null 2>&1; then
  if [ ! -f "${JUPYTER_CONFIG_FILE}" ]; then
    mkdir -p "${JUPYTER_CONFIG_DIR}"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/jupyter/config.py" "${JUPYTER_CONFIG_FILE}"
  fi
fi

# PIPX ===============================================================
export PIPX_HOME="${XDG_DATA_HOME}/pipx"
export PIPX_BIN_DIR="${XDG_DATA_HOME}/pipx/bin"
PATH="${PIPX_BIN_DIR}:${PATH}"

# PYTHONBREW =========================================================
# export PYTHONBREW_ROOT="${XDG_DATA_HOME}/pythonbrew"
# export PYTHONBREW_HOME="${XDG_DATA_HOME}/pythonbrew"
# eval "$(pythonbrew init)"

# PYTHONZ ============================================================
# export PYTHONZ_ROOT="${XDG_DATA_HOME}/pythonz"
# export PYTHONZ_HOME="${XDG_DATA_HOME}/pythonz"
# . "${PYTHONZ_ROOT}/etc/bashrc"

# RENV ===============================================================
export RENV_ROOT="${XDG_DATA_HOME}/renv"
PATH="${RENV_ROOT}/bin:${PATH}"

if command -v renv >/dev/null 2>&1; then
  eval "$(renv init - --no-rehash)"

  RENV_R_PATH="${RENV_ROOT}/versions/$(renv global)"
  PATH="${RENV_R_PATH}/bin:${PATH}"
  MANPATH="${RENV_R_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# R ==================================================================
export R_HISTFILE="${XDG_STATE_HOME}/R/history"
export R_HOME_USER="${XDG_DATA_HOME}/R"
export R_LIBS_USER="${XDG_DATA_HOME}/R/library"
export R_PROFILE_USER="${XDG_CONFIG_HOME}/R/profile"

if command -v R >/dev/null 2>&1; then
  mkdir -p "${XDG_STATE_HOME}/R"
  mkdir -p "${R_LIBS_USER}"

  if [ ! -f "${R_PROFILE_USER}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/R/"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/R/profile" "${R_PROFILE_USER}"
  fi

  alias r="R"
  alias rscript="Rscript"
fi

# RADIAN =============================================================
export RADIAN_CONFIG_FILE="${XDG_CONFIG_HOME}/radian/profile"

if command -v radian >/dev/null 2>&1; then
  if [ ! -f "${RADIAN_CONFIG_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/radian"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/radian/profile" "${RADIAN_CONFIG_FILE}"
  fi
fi

# RAKUBREW ===========================================================
export RAKUBREW_HOME="${XDG_DATA_HOME}/rakubrew"
PATH="${RAKUBREW_HOME}/bin:${PATH}"

command -v rakubrew >/dev/null 2>&1 && eval "$(rakubrew init Bash)"

# RAKUENV ============================================================
export RAKUENV_ROOT="${XDG_DATA_HOME}/rakuenv"
PATH="${RAKUENV_ROOT}/bin:${PATH}"

command -v rakuenv >/dev/null 2>&1 && eval "$(rakuenv init -)"

# RAKU ===============================================================
if command -v raku >/dev/null 2>&1; then
  export RAKUDO_HIST="${XDG_STATE_HOME}/rakudo/history"
  export RAKULIB="${XDG_CACHE_HOME}/raku${RAKULIB:+:${RAKULIB}}"
fi

# RBENV ==============================================================
export RBENV_ROOT="${XDG_DATA_HOME}/rbenv"
PATH="${RBENV_ROOT}/bin:${PATH}"

if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - --no-rehash)"

  if [ ! -f "${RBENV_ROOT}/default-gems" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/rbenv/default-gems" "${RBENV_ROOT}/default-gems"
  fi

  RBENV_RUBY_PATH="${RBENV_ROOT}/versions/$(rbenv global)"
  PATH="${RBENV_RUBY_PATH}/bin:${PATH}"
  MANPATH="${RBENV_RUBY_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# GEM ================================================================
export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"
export GEMRC="${XDG_CONFIG_HOME}/gem/gemrc"
PATH="${GEM_HOME}/bin:${PATH}"

if command -v gem >/dev/null 2>&1; then
  if [ ! -f "${GEMRC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/gem"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/gem/gemrc" "${GEMRC}"
  fi
fi

# BUNDLER ============================================================
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle/config"
export BUNDLE_USER_HOME="${XDG_DATA_HOME}/bundle"
export BUNDLE_USER_PLUGIN="${BUNDLE_USER_HOME}/plugins"

if command -v bundle >/dev/null 2>&1; then
  mkdir -p "${BUNDLE_USER_HOME}" "${BUNDLE_USER_CACHE}"

  if [ ! -f "${BUNDLE_USER_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/bundle"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/bundle/config" "${BUNDLE_USER_CONFIG}"
  fi
fi

# IRB ================================================================
export IRBRC="${XDG_CONFIG_HOME}/irb/irbrc"

if command -v irb >/dev/null 2>&1; then
  if [ ! -f "${IRBRC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/irb"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/irb/irbrc" "${IRBRC}"
  fi
fi

# RUBY ===============================================================

# SOLARGRAPH =========================================================
export SOLARGRAPH_CACHE="${XDG_CACHE_HOME}/solargraph"

# REBAR3 =============================================================
PATH="${XDG_CACHE_HOME}/rebar3/bin:${PATH}"

# RED ================================================================
PATH="${XDG_DATA_HOME}/red/bin:${PATH}"

# ROSWELL ===========================================================
export ROSWELL_HOME="${XDG_DATA_HOME}/roswell"
PATH="${ROSWELL_HOME}/bin:${PATH}"

# RUST ===============================================================
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

[ -f "${CARGO_HOME}/env" ] && . "${CARGO_HOME}/env"

RUSTC_TOOLCHAIN="$(rustup show active-toolchain | awk '{print $1}')"
RUSTUP_RUSTC_PATH="${RUSTUP_HOME}/toolchains/${RUSTC_TOOLCHAIN}"
MANPATH="${RUSTUP_RUSTC_PATH}/share/man${MANPATH:+:${MANPATH}}"

# RVM ================================================================
# PATH="${PATH}:${XDG_DATA_HOME}/rvm/bin"
# . "${XDG_DATA_HOME}/rvm/scripts/rvm"

# SBT ================================================================
export SBT_OPTS="-ivy ${XDG_DATA_HOME}/ivy2 -sbt-dir ${XDG_DATA_HOME}/sbt"

# SCALAENV ===========================================================
# export SCALAENV_ROOT="${XDG_DATA_HOME}/scalaenv"
# PATH="${SCALAENV_ROOT}/bin:${PATH}"
# eval "$(scalaenv init -)"

# SCILAB =============================================================
export SCIHOME="${XDG_STATE_HOME}/scilab"

if command -v scilab-cli >/dev/null 2>&1; then
  alias scilab='scilab-cli -scihome "${SCIHOME}"'
  alias scilab-cli='scilab-cli -scihome ${SCIHOME}'
fi

# SDKMAN =============================================================
export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"
SDKMAN_INITFILE="${SDKMAN_DIR}/bin/sdkman-init.sh"

[ -f "${SDKMAN_INITFILE}" ] && . "${SDKMAN_INITFILE}"

# JAVA ===============================================================
_JAVA_OPTIONS="${_JAVA_OPTIONS} -Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
_JAVA_OPTIONS="${_JAVA_OPTIONS} -Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"
_JAVA_OPTIONS="${_JAVA_OPTIONS# }"

CLASSPATH=".${CLASSPATH:+:${CLASSPATH}}"

# KOTLIN =============================================================
if [ -n "${KOTLIN_HOME}" ]; then
  CLASSPATH="${CLASSPATH:+${CLASSPATH}:}${KOTLIN_HOME}/lib/*"
fi

# SCALA ==============================================================
export SCALA_HISTFILE="${XDG_STATE_HOME}/scala/history"

if command -v scala >/dev/null 2>&1; then
  mkdir -p "${XDG_STATE_HOME}/scala"
  if [ -n "${SCALA_HOME}" ]; then
    CLASSPATH="${CLASSPATH:+${CLASSPATH}:}${SCALA_HOME}/lib/*"
  fi
fi

# GROOVY =============================================================
if [ -n "${GROOVY_HOME}" ]; then
  CLASSPATH="${CLASSPATH:+${CLASSPATH}:}${GROOVY_HOME}/lib/*"
fi

# NODE JAVA CALLER ===================================================
export JAVA_CALLER_JAVA_EXECUTABLE="${JAVA_HOME}/bin/java.exe"

# SHENV ==============================================================
# export SHENV_ROOT="${XDG_DATA_HOME}/shenv"
# PATH="${SHENV_ROOT}/bin:${PATH}"
# eval "$(shenv init -)"

# STARSHIP ===========================================================
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship.toml"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"

# SUBVERSION =========================================================
if command -v svn >/dev/null 2>&1; then
  alias svn='svn --config-dir ${XDG_CONFIG_HOME}/subversion'
fi

# SWIFTLINT ==========================================================
export LINUX_SOURCEKIT_LIB_PATH="/usr/libexec/swift/lib/libsourcekitdInProc.so"

# SWIFTENV (swift) ===================================================
# export SWIFTENV_ROOT="${XDG_DATA_HOME}/swiftenv"
# PATH="${SWIFTENV_ROOT}/bin:${PATH}"
# eval "$(swiftenv init -)"

# TERRAFORM ==========================================================
export TF_HOME_DIR="${XDG_DATA_HOME}/terraform"

# TEXLIVE ============================================================
export TEXMFCONFIG="${XDG_CONFIG_HOME}/texlive/texmf-config"
export TEXMFHOME="${XDG_DATA_HOME}/texmf"
export TEXMFVAR="${XDG_CACHE_HOME}/texlive/texmf-var"

# TEALDEER ===========================================================
export TEALDEER_CONFIG_DIR="${XDG_CONFIG_HOME}/tldr"

if command -v tldr >/dev/null 2>&1; then
  if [ ! -d "${TEALDEER_CONFIG_DIR}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/tealdeer" "${TEALDEER_CONFIG_DIR}"
  fi

  alias tldr='"${CARGO_HOME}"/bin/tldr'
fi

# V ==================================================================
export VCACHE="${XDG_CACHE_HOME}/vmodules"
export VMODULES="${XDG_DATA_HOME}/vmodules"
PATH="${XDG_CONFIG_HOME}/v-analyzer/bin:${PATH}"
PATH="${XDG_DATA_HOME}/v:${PATH}"

# VAGRANT ============================================================
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME}/vagrant/aliases"

# W3M ================================================================
export W3M_DIR="${XDG_STATE_HOME}/w3m"

# WGET ===============================================================
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"

if command -v wget >/dev/null 2>&1; then
  if [ ! -f "$WGETRC" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/wget"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/wget/wgetrc" "$WGETRC"
  fi
fi

# XORG ===============================================================
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"

# ZEEK ===============================================================
PATH="/opt/zeek/bin:${PATH}"

# ZEF ================================================================
export ZEF_CONFIG_STOREDIR="${XDG_DATA_HOME}/zef/store"
export ZEF_CONFIG_TEMPDIR="${XDG_CACHE_HOME}/zef/temp"

# ZOXIDE =============================================================
export _ZO_ECHO=1

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
  alias cd="z"
fi

# LSD ================================================================
if command -v lsd >/dev/null 2>&1; then
  alias ls="lsd"
fi

# DUST ===============================================================
if command -v dust >/dev/null 2>&1; then
  alias du="dust"
fi

# ====================================================================
# ================ CUSTOMIZATION =====================================
# ====================================================================

# OH MY POSH =========================================================
eval "$(oh-my-posh init bash --config ~/.cache/oh-my-posh/themes/hul10.omp.json)"

# USE WINDOWS BROWSER IN WSL =========================================
if grep -q WSL /proc/version; then
  export BROWSER="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe %s"
fi

export ADA_OBJECTS_PATH
export ADA_INCLUDE_PATH
export CLASSPATH
# export CPATH
export _JAVA_OPTIONS
# export LD_LIBRARY_PATH
export LIBRARY_PATH="$LD_LIBRARY_PATH${LIBRARY_PATH:+:${LIBRARY_PATH}}"
export MANPATH
export PATH

# CUSTOM LIMITS
if [ "${SHELL}" = "bash" ]; then
  ulimit -n 104857
fi

unset item
