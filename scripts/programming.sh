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
prepend_to_path "${LOCAL_BIN_DIR}"

# MANPATH ============================================================
export MANPATH="/usr/share/man${MANPATH:+:${MANPATH}}"

# ====================================================================
# ================ PROGRAMS ==========================================
# ====================================================================
# ADA ================================================================
if command_exists gnat; then
  for item in /usr/lib/x86_64-linux-gnu/ada/adalib/*; do
    prepend_to_ada_objects_path "${item}"
  done
  for item in /usr/share/ada/adainclude/*; do
    prepend_to_ada_include_path "${item}"
  done
fi

# ALIRE ==============================================================
prepend_to_path "${XDG_DATA_HOME}/alire/bin"

# ANSIBLE ============================================================
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"

# ASDF ===============================================================
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
source_if_exists "${ASDF_DATA_DIR}/asdf.sh"
if command_exists asdf; then
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
prepend_to_path "${BALLERINA_HOME}/bin"

# BASH ===============================================================
item="$(ps -cp "$$" -o command="")"
export HISTFILE="${XDG_STATE_HOME}/${item}/history"
mkdir -p "${XDG_STATE_HOME}/${item}"

# BUN ================================================================
export BUN_INSTALL="${XDG_DATA_HOME}/bun"
prepend_to_path "${BUN_INSTALL}/bin"

# GCC LOCAL ==========================================================
determine_installed_gcc
prepend_to_cpath "${X86_64_LIB_PATH}/include"
prepend_to_ld_library_path "${X86_64_LIB_PATH}"
prepend_to_ld_library_path "${GCC_PATH}/lib64"
prepend_to_ld_library_path "${GCC_PATH}/lib"
prepend_to_path "${GCC_PATH}/bin"

# C++ ================================================================
# CPLUS_INCLUDE_PATH

# CALC ===============================================================
export CALCHISTFILE="${XDG_STATE_HOME}/calc/history"
if command_exists calc; then
  mkdir -p "${XDG_STATE_HOME}/calc"
fi

# CLEAN ==============================================================
export CLEAN_HOME="${XDG_DATA_HOME}/clean"
prepend_to_path "${CLEAN_HOME}/bin"

# CLING ==============================================================
export CLING_HOME="${XDG_DATA_HOME}/cling"
append_to_path "${CLING_HOME}/bin"
export CLING_HISTFILE="${XDG_STATE_HOME}/cling/history"

# CLOJURE ============================================================
export GITLIBS="${XDG_CACHE_HOME}/clojure-gitlibs"
prepend_to_path "${XDG_DATA_HOME}/clojure/bin"

# COCOAPODS
export CP_HOME_DIR="${XDG_CACHE_HOME}/cocoapods"

# COMPOSER ===========================================================
export COMPOSER_HOME="${XDG_DATA_HOME}/composer"
prepend_to_path "${COMPOSER_HOME}/bin"
prepend_to_path "${COMPOSER_HOME}/vendor/bin"

# CONAN ==============================================================
export CONAN_USER_HOME="${XDG_CONFIG_HOME}"

# CONDA ==============================================================
export CONDA_AUTO_ACTIVATE_BASE=false
export CONDARC="${XDG_CONFIG_HOME}/conda/condarc"
prepend_to_path "${XDG_DATA_HOME}/conda/condabin"
eval_if_exists conda "shell.bash hook"
if command_exists conda; then
  if [ ! -f "${CONDARC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/conda"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/conda/condarc" "${CONDARC}"
  fi
  for item in $(conda env list | awk '$1 != "#" && $1 != "base" {print $1}'); do
    CONDA_ROOT="$(conda info --root)"
    append_to_path "${CONDA_ROOT}/envs/${item}/bin"
  done
fi

# CRENV ==============================================================
# export CRENV_ROOT="${XDG_DATA_HOME}/crenv"
# prepend_to_path "$CRENV_ROOT/bin"
# eval_if_exists crenv "init -"

# DART ===============================================================
export DART_CONFIG_DIR="${XDG_CONFIG_HOME}/dart"
export ANALYZER_STATE_LOCATION_OVERRIDE="${XDG_CACHE_HOME}/dartserver"

# D ==================================================================
export DUB_HOME="${XDG_DATA_HOME}/dub"

# DENO JS ============================================================
export DENO_DIR="${XDG_CACHE_HOME}/deno"
export DENO_INSTALL="${XDG_DATA_HOME}/deno"
export DENO_REPL_HISTORY="${XDG_STATE_HOME}/deno/history"
prepend_to_path "${DENO_INSTALL}/bin"

# DIRENV =============================================================
command_exists direnv && eval "$(direnv hook bash)"

# DOCKER =============================================================
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# DOTNET =============================================================
export DOTNET_ROOT="/usr/share/dotnet"
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"
prepend_to_path "${DOTNET_CLI_HOME}"/.dotnet/tools

# EMSCRIPTEN =========================================================
export EMSDK_QUIET=1
source_if_exists "${XDG_DATA_HOME}/emsdk/emsdk_env.sh"
export EM_CACHE="${XDG_CACHE_HOME}/emscripten/cache"
export EM_CONFIG="${XDG_CONFIG_HOME}/emscripten/config"
export EM_PORTS="${XDG_DATA_HOME}/emscripten/cache"

# FACTOR =============================================================
prepend_to_path "${XDG_DATA_HOME}/factor"

# FOUNDRY ============================================================
export FOUNDRY_DIR="${XDG_DATA_HOME}/foundry"
prepend_to_path "${FOUNDRY_DIR}/bin"

# FVM ================================================================
# export FVM_HOME="${XDG_DATA_HOME}/fvm"
# prepend_to_path "$FVM_HOME/default/bin"

# GHCUP ==============================================================
export GHCUP_INSTALL_BASE_PREFIX="${XDG_DATA_HOME}"
source_if_exists "${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/env"
if command_exists ghc; then
  GHC_VERSION="$(ghc --numeric-version)" 
  GHCUP_GHC_PATH="${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/ghc/${GHC_VERSION}"
  MANPATH="${GHCUP_GHC_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# CABAL ==============================================================
export CABAL_CONFIG="${XDG_CONFIG_HOME}/cabal/config"
export CABAL_DIR="${XDG_DATA_HOME}/cabal"
prepend_to_path "${CABAL_DIR}/bin"
if command_exists cabal; then
  if [ ! -f "${CABAL_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/cabal"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/cabal/config" "${CABAL_CONFIG}"
  fi
fi

# STACK ==============================================================
export STACK_XDG=1
export STACK_CONFIG_YAML="${XDG_CONFIG_HOME}/stack/config.yaml"
if command_exists stack; then
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
# Note: ElixirLs does not work when exporting GIT_CONFIG
GIT_CONFIG="${XDG_CONFIG_HOME}/git/config"
if command_exists git; then
  if [ ! -f "${GIT_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/git"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/git/config" "${GIT_CONFIG}"
  fi
fi

# GNUSTEP ============================================================
prepend_to_cpath "/usr/include/GNUstep"

# GOENV ==============================================================
export GOENV_GOPATH_PREFIX="${GOPATH}"
export GOENV_PREPEND_GOPATH=1
export GOENV_ROOT="${XDG_DATA_HOME}/goenv"
prepend_to_path "${GOENV_ROOT}/bin"
# eval_if_exists goenv "init - --no-rehash bash"
if command_exists goenv; then
  GOENV_GO_PATH="$GOENV_ROOT/versions/$(goenv global)"
  prepend_to_path "${GOENV_GO_PATH}/bin"
fi

# GO =================================================================
if command_exists go; then
  export CGO_ENABLED=1
  export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"
  export GOPATH="${XDG_DATA_HOME}/go"
  prepend_to_path "${GOPATH}/bin"
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
# source_if_exists "${HOME}/sqllib/db2profile"

# ICONS ==============================================================
# export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"

# INSTANTCLIENT
export INSTANTCLIENT="${XDG_DATA_HOME}/oracle/instantclient"
prepend_to_ld_library_path "${INSTANTCLIENT}"

# INTEL ONEAPI =======================================================
source_if_exists "/opt/intel/oneapi/setvars.sh"

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

# JULIAUP ============================================================
export JULIAUP_DEPOT_PATH="${XDG_DATA_HOME}/julia"
prepend_to_path "${XDG_DATA_HOME}/juliaup/bin"

# JULIA ==============================================================
export JULIA_DEPOT_PATH="${XDG_DATA_HOME}/julia:${JULIA_DEPOT_PATH}"
export JULIA_HISTORY="${XDG_STATE_HOME}/julia/history"

# EVM ================================================================
export EVM_HOME="${XDG_DATA_HOME}/evm"
source_if_exists "${EVM_HOME}/scripts/evm"
if command_exists erl; then
  ERLANG_VERSION="$(erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), io:fwrite(Version), halt().' -noshell)"
  EVM_ERLANG_PATH="${EVM_HOME}/erlang_versions/otp_src_${ERLANG_VERSION}"
  MANPATH="${EVM_ERLANG_PATH}/lib/erlang/man${MANPATH:+:${MANPATH}}"
fi

# ERLANG =============================================================
export ERL_AFLAGS="-kernel shell_history enabled shell_history_path '\"${XDG_STATE_HOME}/erlang\"'"
if command_exists erlc; then
  mkdir -p "${XDG_CONFIG_HOME}/erlang"
fi

# MIX ================================================================
export MIX_HOME="${XDG_DATA_HOME}/mix"
export MIX_XDG=1
prepend_to_path "${MIX_HOME}/escripts"

# KERL ===============================================================
export KERL_BASE_DIR="${XDG_DATA_HOME}/kerl"
export KERL_CONFIG="${XDG_CONFIG_HOME}/kerl/kerlrc"
export KERL_DEFAULT_INSTALL_DIR="${KERL_BASE_DIR}/versions"
export KERL_DOC_TARGETS=man
export KERL_BUILD_DOCS=yes

# KIEX ===============================================================
export KIEX_HOME="${XDG_DATA_HOME}/kiex"
source_if_exists "${KIEX_HOME}/scripts/kiex"
if command_exists iex; then
  ELIXIR_VERSION="$(iex -v | awk '{print $2}')"
  KIEX_ELIXIR_PATH="${KIEX_HOME}/elixirs/elixir-${ELIXIR_VERSION}"
  MANPATH="${KIEX_ELIXIR_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# ELIXIR =============================================================
export ELIXIR_ERL_OPTIONS="-kernel shell_history enabled shell_history_path '${XDG_STATE_HOME}/elixir'"

# LEIN ===============================================================
export LEIN_HOME="${XDG_DATA_HOME}/lein"
prepend_to_path "${LEIN_HOME}/bin"
if command_exists lein; then
  if [ ! -f "${LEIN_HOME}/profiles.clj" ]; then
    mkdir -p "${LEIN_HOME}"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/lein/profiles.clj" "${LEIN_HOME}/profiles.clj"
  fi
fi

# LESS ===============================================================
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"

# LUAENV =============================================================
export LUAENV_ROOT="${XDG_DATA_HOME}/luaenv"
prepend_to_path "${LUAENV_ROOT}/bin"
# eval_if_exists luaenv "init - --no-rehash"
if command_exists luaenv; then
  # if [ ! -f "${LUAENV_ROOT}/default-rocks" ]; then
  #   ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/luaenv/default-rocks" "${LUAENV_ROOT}/default-rocks"
  # fi
  LUAENV_LUA_PATH="$LUAENV_ROOT/versions/$(luaenv global)"
  prepend_to_path "${LUAENV_LUA_PATH}/bin"
  MANPATH="${LUAENV_LUA_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# LUAROCKS ===========================================================
export LUAROCKS_CONFIG="${XDG_CONFIG_HOME}/luarocks/config.lua"
export LUAROCKS_TREE="${XDG_DATA_HOME}/luarocks"
if command_exists luarocks; then
  if [ ! -f "${LUAROCKS_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/luarocks"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/luarocks/config.lua" "${LUAROCKS_CONFIG}"
  fi
fi
eval_if_exists luarocks "path --bin"

# MAGEFILE ===========================================================
export MAGEFILE_CACHE="${XDG_CACHE_HOME}/magefile"

# MINT ===============================================================
export MINT_PATH="${XDG_DATA_HOME}/mint"
export MINT_LINK_PATH="${XDG_DATA_HOME}/mint/bin"
prepend_to_path "${MINT_LINK_PATH}"

# MOJO ===============================================================
export MODULAR_HOME="${XDG_DATA_HOME}/modular"
prepend_to_path "${MODULAR_HOME}/pkg/packages.modular.com_mojo/bin"

# MONO ===============================================================
# export MONO_REGISTRY_PATH="${XDG_CACHE_HOME}/mono/registry"

# MYSQL ==============================================================
export MYSQL_HISTFILE="${XDG_STATE_HOME}/mysql/history"
if command_exists mysql; then
  mkdir -p "${XDG_STATE_HOME}/mysql"
fi

# NIMBLE =============================================================
export NIMBLE_DIR="${XDG_DATA_HOME}/nimble"
prepend_to_path "${NIMBLE_DIR}/bin"

# NVIDIA CUDA ========================================================
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nv"
export CUDA_PATH="/usr/local/cuda"
export NVCC_PREPEND_FLAGS="-allow-unsupported-compiler"
prepend_to_path "${CUDA_PATH}/bin"
prepend_to_ld_library_path "${CUDA_PATH}/lib64"

# NVM ================================================================
# export NVM_DIR="${XDG_DATA_HOME}/nvm"
# source_if_exists "${NVM_DIR}/nvm.sh"
# source_if_exists "${NVM_DIR}/bash_completion"

# NODENV (node) ======================================================
export NODENV_ROOT="${XDG_DATA_HOME}/nodenv"
prepend_to_path "${NODENV_ROOT}/bin"
# eval_if_exists nodenv "init - --no-rehash"
if command_exists nodenv; then
  if [ ! -f "${NODENV_ROOT}/default-packages" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/nodenv/default-packages" "${NODENV_ROOT}/default-packages"
  fi
  NODENV_NODE_PATH="$NODENV_ROOT/versions/$(nodenv global)"
  prepend_to_path "${NODENV_NODE_PATH}/bin"
  MANPATH="${NODENV_NODE_PATH}/share/man${MANPATH:+:${MANPATH}}"
  MANPATH="${NODENV_NODE_PATH}/lib/node_modules/npm/man${MANPATH:+:${MANPATH}}"
fi

# NODE ===============================================================
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node/history"
if command_exists node; then
  mkdir -p "${XDG_STATE_HOME}/node"
fi

# NPM ================================================================
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NPM_CONFIG_PREFIX="${XDG_DATA_HOME}/npm"
prepend_to_path "${NPM_CONFIG_PREFIX}/bin"
if command_exists npm; then
  mkdir -p "${XDG_DATA_HOME}/node"
  if [ ! -f "${NPM_CONFIG_USERCONFIG}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/npm/npmrc" "${NPM_CONFIG_USERCONFIG}"
    mkdir -p "${XDG_CONFIG_HOME}/npm"
  fi
fi

# NUGET ==============================================================
export NUGET_HTTP_CACHE_PATH="${XDG_CACHE_HOME}/nuget/http-cache"
export NUGET_PACKAGES="${XDG_CACHE_HOME}/nuget/packages"
export NUGET_PLUGINS_CACHE_PATH="${XDG_CACHE_HOME}/nuget/plugins"

# OBJECTIVE-C ========================================================
# OBJC_INCLUDE_PATH
# OBJCPLUS_INCLUDE_PATH

# OCAML ==============================================================
if command_exists ocaml; then
  export OCAML_INIT_FILE="${XDG_CONFIG_HOME}/ocaml/init.ml"
  if [ ! -f "${OCAML_INIT_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/ocaml"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/ocaml/init.ml" "${OCAML_INIT_FILE}"
  fi
fi

# OCTAVE =============================================================
export OCTAVE_HISTFILE="${XDG_STATE_HOME}/octave/history"
export OCTAVE_SITE_INITFILE="${XDG_CONFIG_HOME}/octave/octaverc"
if command_exists octave; then
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
source_if_exists "${OPAMROOT}/opam-init/init.sh"

# PEX ================================================================
export PEX_ROOT="${XDG_CACHE_HOME}/pex"

# PGSQL ==============================================================
export PSQLRC="${XDG_CONFIG_HOME}/pg/psqlrc"
export PSQL_HISTORY="${XDG_STATE_HOME}/psql/history"
export PGPASSFILE="${XDG_CONFIG_HOME}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME}/pg/pg_service.conf"
if command_exists psql; then
  mkdir -p "${XDG_STATE_HOME}/psql"
  if [ ! -d "${XDG_CONFIG_HOME}/pg" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/pg"
  fi
fi

# PHPBREW ============================================================
# export BOX_REQUIREMENT_CHECKER=0
# export PHPBREW_ROOT="${XDG_DATA_HOME}/phpbrew"
# export PHPBREW_HOME="${XDG_DATA_HOME}/phpbrew"
# source_if_exists "${PHPBREW_HOME}/bashrc"

# PHPENV =============================================================
export PHPENV_ROOT="${XDG_DATA_HOME}/phpenv"
prepend_to_path "${PHPENV_ROOT}/bin"
# eval_if_exists phpenv "init - --no-rehash"
if command_exists phpenv; then
  PHPENV_PHP_PATH="${PHPENV_ROOT}/versions/$(phpenv global)"
  prepend_to_path "${PHPENV_PHP_PATH}/bin"
  MANPATH="${PHPENV_PHP_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# PHP ================================================================
export PHP_DTRACE=yes
if command_exists php; then
  export PHP_INI_SCAN_DIR="${XDG_CONFIG_HOME}/php"
  if [ ! -d "${PHP_INI_SCAN_DIR}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/php" "$PHP_INI_SCAN_DIR"
  fi
fi

# PERLBREW ===========================================================
# export PERLBREW_ROOT="${XDG_DATA_HOME}/perlbrew"
# source_if_exists "${PERLBREW_ROOT}/etc/bashrc"

# PLENV ==============================================================
export PLENV_ROOT="${XDG_DATA_HOME}/plenv"
prepend_to_path "${PLENV_ROOT}/bin"
# eval_if_exists plenv "init -"
if command_exists plenv; then
  PLENV_PERL_PATH="${PLENV_ROOT}/versions/$(plenv global)"
  prepend_to_path "${PLENV_PERL_PATH}/bin"
  MANPATH="${PLENV_PERL_PATH}/man${MANPATH:+:${MANPATH}}"
fi

# PERL
prepend_to_path "${XDG_DATA_HOME}/perl/bin"
if command_exists perl; then
  export PERL_LOCAL_LIB_ROOT="${XDG_DATA_HOME}/perl${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
  export PERL_MB_OPT="--install_base ${XDG_DATA_HOME}/perl"
  export PERL_MM_OPT="INSTALL_BASE=${XDG_DATA_HOME}/perl"
  export PERL5LIB="${XDG_DATA_HOME}/perl/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
fi

# CPANM ==============================================================
if command_exists cpanm; then
  export PERL_CPANM_HOME="${XDG_CACHE_HOME}/cpanm"
  export PERL_CPANM_OPT="--prompt --notest -l ${XDG_DATA_HOME}/perl"
fi

# PERLCRITIC =========================================================
export PERLCRITIC="${XDG_CONFIG_HOME}/perlcritic/perlcriticrc"
if command_exists perlcritic; then
  if [ ! -f "${PERLCRITIC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/perlcritic"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/perlcritic/perlcriticrc" "${PERLCRITIC}"
  fi
fi

# PERLTIDY ===========================================================
export PERLTIDY="${XDG_CONFIG_HOME}/perltidy/perltidyrc"
if command_exists perltidy; then
  if [ ! -f "${PERLTIDY}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/perltidy"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/perltidy/perltidyrc" "${PERLTIDY}"
  fi
fi

# REPLY ==============================================================
alias_if_exists "reply --cfg ${XDG_CONFIG_HOME}/reply/replyrc" "reply"

# PONYUP =============================================================
prepend_to_path "${XDG_DATA_HOME}/ponyup/bin"

# PROCESSING =========================================================
# export PROCESSING_JAVA="${XDG_DATA_HOME}/processing/processing-java"
# prepend_to_path "${XDG_DATA_HOME}/processing"

# PUB ================================================================
export PUB_CACHE="${XDG_DATA_HOME}/pub"
append_to_path "${PUB_CACHE}/bin"

# PYTHONBREW =========================================================
# export PYTHONBREW_ROOT="${XDG_DATA_HOME}/pythonbrew"
# export PYTHONBREW_HOME="${XDG_DATA_HOME}/pythonbrew"
# eval "$(pythonbrew init)"

# PYTHONZ ============================================================
# export PYTHONZ_ROOT="${XDG_DATA_HOME}/pythonz"
# export PYTHONZ_HOME="${XDG_DATA_HOME}/pythonz"
# source_if_exists "${PYTHONZ_ROOT}/etc/bashrc"

# PYENV ==============================================================
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
prepend_to_path "${PYENV_ROOT}/bin"
# eval_if_exists pyenv "init - --no-rehash"
if command_exists pyenv; then
  if [ ! -f "${PYENV_ROOT}/default-packages" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/pyenv/default-packages" "${PYENV_ROOT}/default-packages"
  fi
  PYENV_PYTHON_PATH="${PYENV_ROOT}/versions/$(pyenv global)"
  prepend_to_path "${PYENV_PYTHON_PATH}/bin"
  MANPATH="${PYENV_PYTHON_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# PYTHON =============================================================
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history"
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/pycache"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export PYTHONUSERBASE="${XDG_DATA_HOME}/pip"
if command_exists python; then
  mkdir -p "${XDG_STATE_HOME}/python"
  if [ ! -f "${PYTHONSTARTUP}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/python"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/python/pythonrc" "${PYTHONSTARTUP}"
  fi
fi

# POETRY =============================================================
export POETRY_CONFIG_DIR="${XDG_CONFIG_HOME}/poetry"
export POETRY_CACHE_DIR="${XDG_CACHE_HOME}/poetry"
export POETRY_HOME="${XDG_DATA_HOME}/poetry"
prepend_to_path "${POETRY_HOME}/bin"

# PIP ================================================================
PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
prepend_to_path "${PYTHONUSERBASE}/bin"
if command_exists pip; then
  if [ ! -f "${PIP_CONFIG_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/pip"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/pip/pip.conf" "${PIP_CONFIG_FILE}"
  fi
fi

# PYLINT =============================================================
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export PYLINTRC="$XDG_CONFIG_HOME/pylint/pylintrc"
if command_exists pylint; then
  if [ ! -f "${PYLINTRC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/pylint"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/pylint/pylintrc" "${PYLINTRC}"
  fi
fi

# IPYTHON ============================================================
if command_exists ipython; then
  mkdir -p "${XDG_CONFIG_HOME}/ipython"
fi

# JUPYTER ============================================================
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_FILE="$JUPYTER_CONFIG_DIR/jupyter_notebook_config.py"
if command_exists jupyter; then
  if [ ! -f "${JUPYTER_CONFIG_FILE}" ]; then
    mkdir -p "${JUPYTER_CONFIG_DIR}"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/jupyter/config.py" "${JUPYTER_CONFIG_FILE}"
  fi
fi

# PIPX ===============================================================
export PIPX_HOME="${XDG_DATA_HOME}/pipx"
export PIPX_BIN_DIR="${XDG_DATA_HOME}/pipx/bin"
prepend_to_path "${PIPX_BIN_DIR}"

# RENV ===============================================================
export RENV_ROOT="${XDG_DATA_HOME}/renv"
prepend_to_path "${RENV_ROOT}/bin"
# eval_if_exists renv "init - --no-rehash"
if command_exists renv; then
  RENV_R_PATH="${RENV_ROOT}/versions/$(renv global)"
  prepend_to_path "${RENV_R_PATH}/bin"
  MANPATH="${RENV_R_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# R ==================================================================
export R_HISTFILE="${XDG_STATE_HOME}/R/history"
export R_HOME_USER="${XDG_DATA_HOME}/R"
export R_LIBS_USER="${XDG_DATA_HOME}/R/library"
export R_PROFILE_USER="${XDG_CONFIG_HOME}/R/profile"
if command_exists R; then
  mkdir -p "${XDG_STATE_HOME}/R"
  mkdir -p "${R_LIBS_USER}"
  if [ ! -f "${R_PROFILE_USER}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/R/"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/R/profile" "${R_PROFILE_USER}"
  fi
fi

alias_if_exists "R" "r"
alias_if_exists "Rscript" "rscript"

# RADIAN =============================================================
export RADIAN_CONFIG_FILE="${XDG_CONFIG_HOME}/radian/profile"
if command_exists radian; then
  if [ ! -f "${RADIAN_CONFIG_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/radian"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/radian/profile" "${RADIAN_CONFIG_FILE}"
  fi
fi

# RAKUBREW ===========================================================
export RAKUBREW_HOME="${XDG_DATA_HOME}/rakubrew"
prepend_to_path "${RAKUBREW_HOME}/bin"
eval_if_exists rakubrew "init Bash"

# RAKUENV ============================================================
export RAKUENV_ROOT="${XDG_DATA_HOME}/rakuenv"
prepend_to_path "${RAKUENV_ROOT}/bin"
# eval_if_exists rakuenv "init -"

# RAKU ===============================================================
export RAKUDO_HIST="${XDG_STATE_HOME}/rakudo/history"
export RAKULIB="${XDG_CACHE_HOME}/raku${RAKULIB:+:${RAKULIB}}"

# RVM ================================================================
# prepend_to_path "${XDG_DATA_HOME}/rvm/bin"
# source_if_exists "${XDG_DATA_HOME}/rvm/scripts/rvm"

# RBENV ==============================================================
export RBENV_ROOT="${XDG_DATA_HOME}/rbenv"
prepend_to_path "${RBENV_ROOT}/bin"
# eval_if_exists rbenv "init - --no-rehash"
if command_exists rbenv; then
  if [ ! -f "${RBENV_ROOT}/default-gems" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/rbenv/default-gems" "${RBENV_ROOT}/default-gems"
  fi
  RBENV_RUBY_PATH="${RBENV_ROOT}/versions/$(rbenv global)"
  prepend_to_path "${RBENV_RUBY_PATH}/bin"
  MANPATH="${RBENV_RUBY_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# GEM ================================================================
export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"
export GEMRC="${XDG_CONFIG_HOME}/gem/gemrc"
prepend_to_path "${GEM_HOME}/bin"
if command_exists gem; then
  if [ ! -f "${GEMRC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/gem"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/gem/gemrc" "${GEMRC}"
  fi
fi

# BUNDLER ============================================================
export BUNDLE_HOME="${GEM_HOME}"
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle/config"
export BUNDLE_USER_HOME="${XDG_DATA_HOME}/bundle"
export BUNDLE_USER_PLUGIN="${BUNDLE_USER_HOME}/plugins"
if command_exists bundle; then
  mkdir -p "${BUNDLE_USER_HOME}" "${BUNDLE_USER_CACHE}"
  if [ ! -f "${BUNDLE_USER_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/bundle"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/bundle/config" "${BUNDLE_USER_CONFIG}"
  fi
fi

# IRB ================================================================
export IRBRC="${XDG_CONFIG_HOME}/irb/irbrc"
if command_exists irb; then
  mkdir -p "${XDG_STATE_HOME}/irb"
  if [ ! -f "${IRBRC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/irb"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/irb/irbrc" "${IRBRC}"
  fi
fi

# RUBY ===============================================================

# SOLARGRAPH =========================================================
export SOLARGRAPH_CACHE="${XDG_CACHE_HOME}/solargraph"

# REBAR3 =============================================================
prepend_to_path "${XDG_CACHE_HOME}/rebar3/bin"

# RED ================================================================
prepend_to_path "${XDG_DATA_HOME}/red/bin"

# REDIS ==============================================================
export REDISCLI_HISTFILE="${XDG_STATE_HOME}/redis/history"
export REDISCLI_RCFILE="${XDG_CONFIG_HOME}/redis/redisclirc"
if command_exists redis-cli; then
  mkdir -p "${XDG_STATE_HOME}/redis"
fi

# ROSWELL ============================================================
export ROSWELL_HOME="${XDG_DATA_HOME}/roswell"
prepend_to_path "${ROSWELL_HOME}/bin"

# CARGO ==============================================================
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
source_if_exists "${CARGO_HOME}/env"

# RUST ===============================================================
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
if command_exists rustup; then
  RUSTC_TOOLCHAIN="$(rustup show active-toolchain | awk '{print $1}')"
  RUSTUP_RUSTC_PATH="${RUSTUP_HOME}/toolchains/${RUSTC_TOOLCHAIN}"
  MANPATH="${RUSTUP_RUSTC_PATH}/share/man${MANPATH:+:${MANPATH}}"
fi

# SCILAB =============================================================
export SCIHOME="${XDG_STATE_HOME}/scilab"
alias_if_exists "scilab-cli -scihome ${SCIHOME}" "scilab"
alias_if_exists "scilab-cli -scihome ${SCIHOME}" "scilab-cli"

# SDKMAN =============================================================
export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"
source_if_exists "${SDKMAN_DIR}/bin/sdkman-init.sh"

# JAVA ===============================================================
if command_exists java; then
  add_to_java_options "-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
  add_to_java_options "-Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"
  # add_to_java_options "-proc:none"
  prepend_to_classpath "."
fi

# KOTLIN =============================================================
# if [ -n "${KOTLIN_HOME}" ]; then
#  append_to_classpath "${KOTLIN_HOME}/lib/*"
# fi

# SCALA ==============================================================
# if command_exists scala; then
#   if [ -n "${SCALA_HOME}" ]; then
#     append_to_classpath "${SCALA_HOME}/lib/*"
#   fi
# fi

# GROOVY =============================================================
# if [ -n "${GROOVY_HOME}" ]; then
#   append_to_classpath "${GROOVY_HOME}/lib/*"
# fi

# SCALAENV ===========================================================
# export SCALAENV_ROOT="${XDG_DATA_HOME}/scalaenv"
# prepend_to_path "${SCALAENV_ROOT}/bin"
# eval_if_exists scalaenv "init -"

# MAVEN ==============================================================
export MAVEN_CUSTOM_REPO="${XDG_CACHE_HOME}/maven"
export MAVEN_OPTS="-Dmaven.repo.local=${MAVEN_CUSTOM_REPO}/repository"
if command_exists mvn; then
  if [ -f "${MAVEN_HOME}/conf/settings.xml" ]; then
    rm "${MAVEN_HOME}/conf/settings.xml"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/maven/settings.xml" "${MAVEN_HOME}/conf/settings.xml"
  fi
  if [ ! -d "${MAVEN_HOME}/repository" ]; then
    ln -s "${XDG_CACHE_HOME}/maven/repository" "${MAVEN_HOME}/repository"
  fi
fi

# SBT ================================================================
export SBT_OPTS="-ivy ${XDG_DATA_HOME}/ivy2 -sbt-dir ${XDG_DATA_HOME}/sbt"

# COURSIER ===========================================================
export CS_HOME="${XDG_DATA_HOME}/coursier"
export COURSIER_MIRRORS="${XDG_CONFIG_HOME}/coursier/mirror.properties"
prepend_to_path "${CS_HOME}/bin"
if command_exists cs; then
  if [ ! -f "${COURSIER_MIRRORS}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/coursier/mirror.properties" "${COURSIER_MIRRORS}"
  fi
fi


# NODE JAVA CALLER ===================================================
export JAVA_CALLER_JAVA_EXECUTABLE="${JAVA_HOME}/bin/java"

# SDCV ===============================================================
export SDCV_HISTFILE="${XDG_STATE_HOME}/sdcv/history"
export STARDICT_DATA_DIR="${XDG_DATA_HOME}/stardict"

# SHENV ==============================================================
# export SHENV_ROOT="${XDG_DATA_HOME}/shenv"
# prepend_to_path "${SHENV_ROOT}/bin"
# eval_if_exists shenv "init -"

# SQLITE =============================================================
export SQLITE_HISTORY="${XDG_STATE_HOME}/sqlite/history"
if command_exists sqlite3; then
  mkdir -p "${XDG_STATE_HOME}/sqlite"
fi

# STARSHIP ===========================================================
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship.toml"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"

# SUBVERSION =========================================================
alias_if_exists "svn --config-dir ${XDG_CONFIG_HOME}/subversion" "svn"

# SWIFTLINT ==========================================================
export LINUX_SOURCEKIT_LIB_PATH="/usr/libexec/swift/lib/libsourcekitdInProc.so"

# SWIFTENV (swift) ===================================================
# export SWIFTENV_ROOT="${XDG_DATA_HOME}/swiftenv"
# prepend_to_path "${SWIFTENV_ROOT}/bin"
# eval_if_exists swiftenv "init -"

# SWIFTLY ============================================================
export SWIFTLY_HOME_DIR="${XDG_DATA_HOME}/swiftly"
export SWIFTLY_BIN_DIR="${SWIFTLY_HOME_DIR}/bin"
source_if_exists "${SWIFTLY_HOME_DIR}/env.sh"

# TS-NODE ============================================================
export TS_NODE_HISTORY="${XDG_STATE_HOME}/ts-node/history"
if command_exists ts-node; then
  mkdir -p "${XDG_STATE_HOME}/ts-node"
fi

# TERRAFORM ==========================================================
export TF_HOME_DIR="${XDG_DATA_HOME}/terraform"

# TEXLIVE ============================================================
export TEXMFCONFIG="${XDG_CONFIG_HOME}/texlive/texmf-config"
export TEXMFHOME="${XDG_DATA_HOME}/texmf"
export TEXMFVAR="${XDG_CACHE_HOME}/texlive/texmf-var"

# TEALDEER ===========================================================
export TEALDEER_CONFIG_DIR="${XDG_CONFIG_HOME}/tldr"
if command_exists tldr; then
  if [ ! -d "${TEALDEER_CONFIG_DIR}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/tealdeer" "${TEALDEER_CONFIG_DIR}"
  fi
fi

# V ==================================================================
export VCACHE="${XDG_CACHE_HOME}/vmodules"
export VMODULES="${XDG_DATA_HOME}/vmodules"
prepend_to_path "${XDG_DATA_HOME}/v"
prepend_to_path "${XDG_CONFIG_HOME}/v-analyzer/bin"

# VAGRANT ============================================================
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME}/vagrant/aliases"

# W3M ================================================================
export W3M_DIR="${XDG_STATE_HOME}/w3m"

# WGET ===============================================================
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
if command_exists wget; then
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
prepend_to_path "/opt/zeek/bin"

# ZEF ================================================================
export ZEF_CONFIG_STOREDIR="${XDG_DATA_HOME}/zef/store"
export ZEF_CONFIG_TEMPDIR="${XDG_CACHE_HOME}/zef/temp"

# ZOXIDE =============================================================
export _ZO_ECHO=1
eval_if_exists zoxide "init bash"
alias_if_exists "z" "cd"

# LSD ================================================================
alias_if_exists "lsd -A" "ls"

# DUST ===============================================================
alias_if_exists "dust" "du"

# LIBRARY PATHS ======================================================
append_to_library_path "/usr/lib/x86_64-linux-gnu"
append_to_library_path "$LD_LIBRARY_PATH"

# ====================================================================
# ================ CUSTOMIZATION =====================================
# ====================================================================

# OH MY POSH =========================================================
eval_if_exists oh-my-posh "init bash --config ~/.cache/oh-my-posh/themes/night-owl.omp.json"

# USE WINDOWS BROWSER IN WSL =========================================
if grep -q WSL /proc/version; then
  export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe %s"
fi

export ADA_OBJECTS_PATH
export ADA_INCLUDE_PATH
export CLASSPATH
export CPATH
export _JAVA_OPTIONS
export LD_LIBRARY_PATH
export LIBRARY_PATH
export MANPATH
export PATH

# CUSTOM LIMITS
if [ "${SHELL}" = "/bin/bash" ]; then
  ulimit -n 104857
fi

# export no_grpc_proxy=localhost,127.0.0.0/8

unset item
