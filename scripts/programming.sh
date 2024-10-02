#!/usr/bin/env bash

# Define a variable to track the last modification time of this script
PROGRAMMING_SH_LAST_MODIFIED_VAR="PROGRAMMING_SH_LAST_MODIFIED"
PROGRAMMING_SH_PATH="$(dirname "$BASH_SOURCE")/programming.sh"
# Get the current modification time of this script
current_mod_time=$(stat -c %Y "$PROGRAMMING_SH_PATH")
# Check if the script has been sourced before and if it has been updated
if [ -z "${!PROGRAMMING_SH_LAST_MODIFIED_VAR}" ] || [ "${!PROGRAMMING_SH_LAST_MODIFIED_VAR}" -lt "$current_mod_time" ]; then
  # Update the environment variable with the current modification time
  export $PROGRAMMING_SH_LAST_MODIFIED_VAR="$current_mod_time"
else
  return 0
fi

# PRELIMINARIES ================================================================
## XDG DIRS ====================================================================
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
## LOCAL BIN ===================================================================
export LOCAL_BIN_DIR="${HOME}/.local/bin"
prepend_to_path "${LOCAL_BIN_DIR}"
## MANPATH =====================================================================
prepend_to_manpath "/usr/share/man"
# END PRELIMINARY ==============================================================


# SHELL DEVEL ==================================================================
## SHELL VERSION MANAGERS ======================================================
### SHENV ======================================================================
export SHENV_ROOT="${XDG_DATA_HOME}/shenv"
prepend_to_path "${SHENV_ROOT}/bin"
eval_if_exists shenv "init -"
## SHELL TOOLS =================================================================
### BASALT =====================================================================
# export BASALT_GLOBAL_DATA_DIR="${XDG_DATA_HOME}/basalt"
# prepend_to_path "${BASALT_GLOBAL_DATA_DIR}/source/pkg/bin"
# eval_if_exists basalt "global init bash"
### SHELL ======================================================================
item="$(ps -cp "$$" -o command="")"
export HISTFILE="${XDG_STATE_HOME}/${item}/history"
mkdir -p "${XDG_STATE_HOME}/${item}"
### BASH =======================================================================
BASHRC_PATH="${HOME}/.bashrc"
CONFIG_BASHRC_PATH="$(dirname "${BASH_SOURCE[0]}")/../config/bash/bashrc"
if [ "$(realpath "$BASHRC_PATH")" != "$CONFIG_BASHRC_PATH" ]; then
  rm "$BASHRC_PATH" # remove the existing .bashrc
  ln -s "$CONFIG_BASHRC_PATH" "$BASHRC_PATH"
fi
# END SHELL DEVEL ==============================================================


## VERSION MANAGERS ============================================================
### AQUA =======================================================================
export AQUA_ROOT_DIR="${XDG_DATA_HOME}/aqua"
prepend_to_path "${AQUA_ROOT_DIR}/bin"
### ASDF =======================================================================
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
source_if_exists "${ASDF_DATA_DIR}/asdf.sh"
if command_exists asdf; then
  if [ ! -f "${ASDF_CONFIG_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/asdf"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/asdf/asdfrc" "${ASDF_CONFIG_FILE}"
  fi
fi
### MISE =======================================================================
export MISE_DATA_DIR="${XDG_DATA_HOME}/mise"
export MISE_INSTALL_PATH="${MISE_DATA_DIR}/bin/mise"
prepend_to_path "${MISE_DATA_DIR}/bin"
eval_if_exists mise "activate bash"
### PIXI =======================================================================
export PIXI_HOME="${XDG_DATA_HOME}/pixi"
prepend_to_path "${PIXI_HOME}/bin"
### PROTO ======================================================================
export PROTO_HOME="${XDG_DATA_HOME}/proto"
prepend_to_path "${PROTO_HOME}/bin"
prepend_to_path "${PROTO_HOME}/shims"
### VMR ========================================================================
source_if_exists "${XDG_DATA_HOME}/vmr/vmr.sh"
## END VERSION MANAGERS =========================================================


## TEXT EDITORS/IDE =============================================================
### ATOM =======================================================================
# export ATOM_HOME="${XDG_DATA_HOME}/atom"
### JETBRAINS ==================================================================
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
## END TEXT EDITORS/IDE ========================================================


# ADA DEVEL ====================================================================
## ADA PACKAGE MANAGERS ========================================================
### ALIRE ======================================================================
prepend_to_path "${XDG_DATA_HOME}/alire/bin"
## ADA TOOLS ===================================================================
### GNAT =======================================================================
if command_exists gnat; then
  for item in /usr/lib/x86_64-linux-gnu/ada/adalib/*; do
    prepend_to_ada_objects_path "${item}"
  done
  for item in /usr/share/ada/adainclude/*; do
    prepend_to_ada_include_path "${item}"
  done
fi
# END ADA DEVEL ================================================================


# C FAMILY DEVEL ===============================================================
## C FAMILY COMPILERS ==========================================================
### GCC ========================================================================
determine_installed_gcc
prepend_to_cpath "${X86_64_LIB_PATH}/include"
prepend_to_ld_library_path "${X86_64_LIB_PATH}"
prepend_to_ld_library_path "${GCC_PATH}/lib64"
prepend_to_ld_library_path "${GCC_PATH}/lib"
prepend_to_path "${GCC_PATH}/bin"
### EMSCRIPTEN =================================================================
source_if_exists "${XDG_DATA_HOME}/emsdk/emsdk_env.sh" # source first to avoid resetting the variables
export EMSDK_QUIET=1
export EM_CACHE="${XDG_CACHE_HOME}/emscripten/cache"
export EM_CONFIG="${XDG_CONFIG_HOME}/emscripten/config"
export EM_PORTS="${XDG_DATA_HOME}/emscripten/cache"
if command_exists emcc; then
  if [ ! -f "${EM_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/emscripten"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/emscripten/config" "${EM_CONFIG}"
  fi
fi
### INTEL ONEAPI ===============================================================
source_if_exists "/opt/intel/oneapi/setvars.sh"
### NVIDIA CUDA ================================================================
# needs to be set before CONDA
export CUDA_CACHE_PATH="${XDG_CACHE_HOME}/nvidia/cuda"
export CUDA_PATH="/usr/local/cuda"
export NVCC_PREPEND_FLAGS="-allow-unsupported-compiler"
prepend_to_path "${CUDA_PATH}/bin"
prepend_to_ld_library_path "${CUDA_PATH}/lib64"
## C FAMILY PACKAGE MANAGERS ===================================================
### CONAN ======================================================================
export CONAN_USER_HOME="${XDG_CONFIG_HOME}"
### VCPKG ======================================================================
export VCPKG_ROOT="${XDG_DATA_HOME}/vcpkg"
export VCPKG_DOWNLOADS="${XDG_CACHE_HOME}/vcpkg/downloads"
export VCPKG_DEFAULT_BINARY_CACHE="${XDG_CACHE_HOME}/vcpkg/archives"
prepend_to_path "${VCPKG_ROOT}"
## C FAMILY TOOLS ==============================================================
### CLING ======================================================================
export CLING_HOME="${XDG_DATA_HOME}/cling"
export CLING_HISTFILE="${XDG_STATE_HOME}/cling/history"
append_to_path "${CLING_HOME}/bin"
### GNUSTEP ====================================================================
prepend_to_cpath "/usr/include/GNUstep"
## C FAMILY INCLUDES ===========================================================
### C++ ========================================================================
# CPLUS_INCLUDE_PATH
### GOBJC ======================================================================
# OBJC_INCLUDE_PATH
# OBJCPLUS_INCLUDE_PATH
## C FAMILY PATHS ==============================================================
### LIBRARY PATHS ==============================================================
append_to_library_path "/usr/lib/x86_64-linux-gnu"
append_to_library_path "${LD_LIBRARY_PATH}"
# END C FAMILY DEVEL ===========================================================


# CRYSTAL DEVEL ================================================================
## CRYSTAL VERSION MANAGERS ====================================================
### CRENV ======================================================================
export CRENV_ROOT="${XDG_DATA_HOME}/crenv"
prepend_to_path "$CRENV_ROOT/bin"
eval_if_exists crenv "init -"
# END CRYSTAL DEVEL ============================================================


# D DEVEL ======================================================================
## D PACKAGE MANAGERS ==========================================================
### DUB ========================================================================
export DUB_HOME="${XDG_DATA_HOME}/dub"
# END D DEVEL ==================================================================


# DART DEVEL ===================================================================
## DART VERSION MANAGERS =======================================================
### DVM ========================================================================
export DVM_ROOT="${XDG_DATA_HOME}/dvm"
source_if_exists "${XDG_DATA_HOME}/dvm/scripts/dvm"
### FVM ========================================================================
export FVM_HOME="${XDG_DATA_HOME}/fvm"
prepend_to_path "$FVM_HOME/default/bin"
## DART PACKAGE MANAGERS =======================================================
### PUB ========================================================================
export PUB_CACHE="${XDG_DATA_HOME}/pub"
append_to_path "${PUB_CACHE}/bin"
## DART TOOLS ==================================================================
### DART =======================================================================
export ANALYZER_STATE_LOCATION_OVERRIDE="${XDG_CACHE_HOME}/dart-server"
del_if_exists "${HOME}/.dart-tool"
# END DART DEVEL ===============================================================


# DOTNET DEVEL =================================================================
## DOTNET PACKAGE MANAGERS =====================================================
### DOTNET =====================================================================
export DOTNET_ROOT="/usr/share/dotnet"
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"
prepend_to_path "${DOTNET_CLI_HOME}"/.dotnet/tools
del_if_exists "${HOME}/.dotnet"
### NUGET ======================================================================
export NUGET_HTTP_CACHE_PATH="${XDG_CACHE_HOME}/nuget/http-cache"
export NUGET_PACKAGES="${XDG_CACHE_HOME}/nuget/packages"
export NUGET_PLUGINS_CACHE_PATH="${XDG_CACHE_HOME}/nuget/plugins"
## DOTNET TOOLS ================================================================
### MONO =======================================================================
# export MONO_REGISTRY_PATH="${XDG_CACHE_HOME}/mono/registry"
### OMNISHARP ==================================================================
export OMNISHARPHOME="${XDG_CONFIG_HOME}/omnisharp"
# END DOTNET DEVEL =============================================================


# ERLANG DEVEL =================================================================
## ERLANG VERSION MANAGERS =====================================================
### EVM ========================================================================
export EVM_HOME="${XDG_DATA_HOME}/evm"
source_if_exists "${EVM_HOME}/scripts/evm"
if command_exists erl; then
  ERLANG_VERSION="$(erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), io:fwrite(Version), halt().' -noshell)"
  EVM_ERLANG_PATH="${EVM_HOME}/erlang_versions/otp_src_${ERLANG_VERSION}"
  prepend_to_manpath "${EVM_ERLANG_PATH}/lib/erlang/man"
fi
### KERL =======================================================================
export KERL_BASE_DIR="${XDG_DATA_HOME}/kerl"
export KERL_CONFIG="${XDG_CONFIG_HOME}/kerl/kerlrc"
export KERL_DEFAULT_INSTALL_DIR="${KERL_BASE_DIR}/versions"
export KERL_DOC_TARGETS=man
export KERL_BUILD_DOCS=yes
## ERLANG PACKAGE MANAGERS =====================================================
### REBAR3 =====================================================================
prepend_to_path "${XDG_CACHE_HOME}/rebar3/bin"
## ERLANG TOOLS ================================================================
### ERLANG =====================================================================
export ERL_AFLAGS="-kernel shell_history enabled shell_history_path '\"${XDG_STATE_HOME}/erlang\"'"
if command_exists erlc; then
  mkdir -p "${XDG_CONFIG_HOME}/erlang"
fi
# END ERLANG DEVEL =============================================================


# ELIXIR DEVEL =================================================================
## ELIXIR VERSION MANAGERS =====================================================
### KIEX =======================================================================
export KIEX_HOME="${XDG_DATA_HOME}/kiex"
source_if_exists "${KIEX_HOME}/scripts/kiex"
if command_exists iex; then
  ELIXIR_VERSION="$(iex -v | awk '{print $2}')"
  KIEX_ELIXIR_PATH="${KIEX_HOME}/elixirs/elixir-${ELIXIR_VERSION}"
  prepend_to_manpath "${KIEX_ELIXIR_PATH}/share/man"
fi
## ELIXIR PACKAGE MANAGERS =====================================================
### MIX ========================================================================
export MIX_HOME="${XDG_DATA_HOME}/mix"
export MIX_XDG=1
prepend_to_path "${MIX_HOME}/escripts"
## ELIXIR TOOLS ================================================================
### ELIXIR =====================================================================
export ELIXIR_ERL_OPTIONS="-kernel shell_history enabled shell_history_path '${XDG_STATE_HOME}/elixir'"
# END ELIXIR DEVEL =============================================================


# GO DEVEL =====================================================================
## GO VERSION MANAGERS =========================================================
### GOENV ======================================================================
export GOENV_GOPATH_PREFIX="${GOPATH}"
export GOENV_PREPEND_GOPATH=1
export GOENV_ROOT="${XDG_DATA_HOME}/goenv"
prepend_to_path "${GOENV_ROOT}/bin"
eval_if_exists goenv "init - --no-rehash bash"
if command_exists goenv; then
  GOENV_GO_PATH="$GOENV_ROOT/versions/$(goenv global)"
  prepend_to_path "${GOENV_GO_PATH}/bin"
fi
## GO PACKAGE MANAGERS =========================================================
### MAGE =======================================================================
export MAGEFILE_CACHE="${XDG_CACHE_HOME}/magefile"
## GO TOOLS ====================================================================
### GO =========================================================================
if command_exists go; then
  export CGO_ENABLED=1
  export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"
  export GOPATH="${XDG_DATA_HOME}/go"
  prepend_to_path "${GOPATH}/bin"
fi
# END GO DEVEL =================================================================


# HASKELL DEVEL ================================================================
## HASKELL VERSION MANAGERS ====================================================
### GHCUP ======================================================================
export GHCUP_INSTALL_BASE_PREFIX="${XDG_DATA_HOME}"
source_if_exists "${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/env"
if command_exists ghc; then
  GHC_VERSION="$(ghc --numeric-version)"
  GHCUP_GHC_PATH="${GHCUP_INSTALL_BASE_PREFIX}/.ghcup/ghc/${GHC_VERSION}"
  prepend_to_manpath "${GHCUP_GHC_PATH}/share/man"
fi
## HASKELL PACKAGE MANAGERS ====================================================
### CABAL ======================================================================
export CABAL_CONFIG="${XDG_CONFIG_HOME}/cabal/config"
export CABAL_DIR="${XDG_DATA_HOME}/cabal"
prepend_to_path "${CABAL_DIR}/bin"
if command_exists cabal; then
  if [ ! -f "${CABAL_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/cabal"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/cabal/config" "${CABAL_CONFIG}"
  fi
fi
### STACK ======================================================================
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
# END HASKELL DEVEL ============================================================


# JS AND TS DEVEL ==============================================================
## JS AND TS VERSION MANAGERS ==================================================
### FNM ========================================================================
export FNM_PATH="${XDG_DATA_HOME}/fnm"
prepend_to_path "${FNM_PATH}"
eval_if_exists fnm "env"
### N ==========================================================================
export N_PREFIX="${XDG_DATA_HOME}/n"
prepend_to_path "${N_PREFIX}/bin"
### NODENV =====================================================================
export NODENV_ROOT="${XDG_DATA_HOME}/nodenv"
prepend_to_path "${NODENV_ROOT}/bin"
eval_if_exists nodenv "init - --no-rehash bash"
if command_exists nodenv; then
  if [ ! -f "${NODENV_ROOT}/default-packages" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/nodenv/default-packages" "${NODENV_ROOT}/default-packages"
  fi
  NODENV_NODE_PATH="$NODENV_ROOT/versions/$(nodenv global)"
  prepend_to_path "${NODENV_NODE_PATH}/bin"
  prepend_to_manpath "${NODENV_NODE_PATH}/share/man"
  prepend_to_manpath "${NODENV_NODE_PATH}/lib/node_modules/npm/man"
fi
### NVM ========================================================================
# export NVM_DIR="${XDG_DATA_HOME}/nvm"
# source_if_exists "${NVM_DIR}/nvm.sh"
# source_if_exists "${NVM_DIR}/bash_completion"
### VOLTA ======================================================================
export VOLTA_HOME="${XDG_DATA_HOME}/volta"
prepend_to_path "${VOLTA_HOME}/bin"
## JS AND TS PACKAGE MANAGERS ==================================================
### BUN ========================================================================
export BUN_INSTALL="${XDG_DATA_HOME}/bun"
prepend_to_path "${BUN_INSTALL}/bin"
### DENO =======================================================================
export DENO_DIR="${XDG_CACHE_HOME}/deno"
export DENO_INSTALL="${XDG_DATA_HOME}/deno"
export DENO_REPL_HISTORY="${XDG_STATE_HOME}/deno/history"
prepend_to_path "${DENO_INSTALL}/bin"
### NPM ========================================================================
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
## JS AND TS TOOLS =============================================================
### NODE =======================================================================
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node/history"
if command_exists node; then
  mkdir -p "${XDG_STATE_HOME}/node"
fi
### TS-NODE ====================================================================
export TS_NODE_HISTORY="${XDG_STATE_HOME}/ts-node/history"
if command_exists ts-node; then
  mkdir -p "${XDG_STATE_HOME}/ts-node"
fi
# END JS AND TS DEVEL ==========================================================


# JULIA DEVEL ==================================================================
## JULIA VERSION MANAGERS ======================================================
### JULIAUP ====================================================================
export JULIAUP_DEPOT_PATH="${XDG_DATA_HOME}/julia"
prepend_to_path "${XDG_DATA_HOME}/juliaup/bin"
## JULIA TOOLS =================================================================
### JULIA ======================================================================
export JULIA_DEPOT_PATH="${XDG_DATA_HOME}/julia:${JULIA_DEPOT_PATH}"
export JULIA_HISTORY="${XDG_STATE_HOME}/julia/history"
# END JULIA DEVEL ==============================================================


# JVM DEVEL ====================================================================
## JVM VERSION MANAGERS ========================================================
### COURSIER ===================================================================
export CS_HOME="${XDG_DATA_HOME}/coursier"
export COURSIER_MIRRORS="${XDG_CONFIG_HOME}/coursier/mirror.properties"
prepend_to_path "${CS_HOME}/bin"
if command_exists cs; then
  if [ ! -f "${COURSIER_MIRRORS}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/coursier/mirror.properties" "${COURSIER_MIRRORS}"
  fi
fi
### JABBA ======================================================================
export JABBA_HOME="${XDG_DATA_HOME}/jabba"
source_if_exists "${JABBA_HOME}/jabba.sh"
### SCALAENV ===================================================================
export SCALAENV_ROOT="${XDG_DATA_HOME}/scalaenv"
prepend_to_path "${SCALAENV_ROOT}/bin"
eval_if_exists scalaenv "init -"
### SDKMAN =====================================================================
export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"
source_if_exists "${SDKMAN_DIR}/bin/sdkman-init.sh"
## JVM LANGUAGES ===============================================================
### BALLERINA ==================================================================
export BALLERINA_HOME="${XDG_DATA_HOME}/ballerina"
prepend_to_path "${BALLERINA_HOME}/bin"
### GROOVY =====================================================================
# if [ -n "${GROOVY_HOME}" ]; then
#   append_to_classpath "${GROOVY_HOME}/lib/*"
# fi
### JAVA =======================================================================
if command_exists java; then
  add_to_java_options "-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
  add_to_java_options "-Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"
  # add_to_java_options "-proc:none"
  prepend_to_classpath "."
fi
### KOTLIN =====================================================================
# if [ -n "${KOTLIN_HOME}" ]; then
#  append_to_classpath "${KOTLIN_HOME}/lib/*"
# fi
### SCALA ======================================================================
# if command_exists scala; then
#   if [ -n "${SCALA_HOME}" ]; then
#     append_to_classpath "${SCALA_HOME}/lib/*"
#   fi
# fi
## JVM BUILD TOOLS =============================================================
### ANT ========================================================================
### GRADLE =====================================================================
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
### MAVEN ======================================================================
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
### SBT ========================================================================
export SBT_OPTS="-ivy ${XDG_DATA_HOME}/ivy2 -sbt-dir ${XDG_DATA_HOME}/sbt"
## OTHER JVM TOOLS =============================================================
### METALS =====================================================================
del_if_exists "${HOME}/.metals"
### NODE JAVA CALLER ===========================================================
export JAVA_CALLER_JAVA_EXECUTABLE="${JAVA_HOME}/bin/java"
# END JVM DEVEL ================================================================


# LEAN DEVEL ===================================================================
## LEAN VERSION MANAGERS =======================================================
### ELAN =======================================================================
export ELAN_HOME="${XDG_DATA_HOME}/elan"
prepend_to_path "${ELAN_HOME}/bin"
# END LEAN DEVEL ===============================================================


# LISP DEVEL ===================================================================
## LISP VERSION MANAGERS =======================================================
## LISP PACKAGE MANAGERS =======================================================
### CLOJURE ====================================================================
export GITLIBS="${XDG_CACHE_HOME}/clojure/gitlibs"
prepend_to_path "${XDG_DATA_HOME}/clojure/bin"
### LEININGEN ==================================================================
export LEIN_HOME="${XDG_DATA_HOME}/lein"
prepend_to_path "${LEIN_HOME}/bin"
if command_exists lein; then
  if [ ! -f "${LEIN_HOME}/profiles.clj" ]; then
    mkdir -p "${LEIN_HOME}"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/lein/profiles.clj" "${LEIN_HOME}/profiles.clj"
  fi
fi
### ROSWELL ====================================================================
export ROSWELL_HOME="${XDG_DATA_HOME}/roswell"
prepend_to_path "${ROSWELL_HOME}/bin"
# END LISP DEVEL ===============================================================


# LUA DEVEL ====================================================================
## LUA VERSION MANAGERS ========================================================
### LUAENV =====================================================================
export LUAENV_ROOT="${XDG_DATA_HOME}/luaenv"
prepend_to_path "${LUAENV_ROOT}/bin"
eval_if_exists luaenv "init - bash"
if command_exists luaenv; then
  if [ ! -f "${LUAENV_ROOT}/default-rocks" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/luaenv/default-rocks" "${LUAENV_ROOT}/default-rocks"
  fi
  LUAENV_LUA_PATH="$LUAENV_ROOT/versions/$(luaenv global)"
  prepend_to_path "${LUAENV_LUA_PATH}/bin"
  prepend_to_manpath "${LUAENV_LUA_PATH}/share/man"
fi
## LUA PACKAGE MANAGERS ========================================================
### LUAROCKS ===================================================================
export LUAROCKS_CONFIG="${XDG_CONFIG_HOME}/luarocks/config.lua"
export LUAROCKS_TREE="${XDG_DATA_HOME}/luarocks"
if command_exists luarocks; then
  if [ ! -f "${LUAROCKS_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/luarocks"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/luarocks/config.lua" "${LUAROCKS_CONFIG}"
  fi
fi
eval_if_exists luarocks "path --bin"
# END LUA DEVEL ================================================================


# NIM DEVEL ====================================================================
## NIM VERSION MANAGERS ========================================================
### CHOOSENIM ==================================================================
## NIM PACKAGE MANAGERS ========================================================
### NIMBLE =====================================================================
export NIMBLE_DIR="${XDG_DATA_HOME}/nimble"
prepend_to_path "${NIMBLE_DIR}/bin"
# END NIM DEVEL ================================================================


# OCAML DEVEL ==================================================================
## OCAML VERSION MANAGERS ======================================================
### OPAM =======================================================================
export OPAMAUTOREMOVE=1
export OPAMROOT="${XDG_DATA_HOME}/opam"
export OPAMSOLVERTIMOUT=1000
source_if_exists "${OPAMROOT}/opam-init/init.sh"
## OCAML PACKAGE MANAGERS ======================================================
### DUNE =======================================================================
## OCAML TOOLS =================================================================
### OCAML ======================================================================
if command_exists ocaml; then
  export OCAML_INIT_FILE="${XDG_CONFIG_HOME}/ocaml/init.ml"
  if [ ! -f "${OCAML_INIT_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/ocaml"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/ocaml/init.ml" "${OCAML_INIT_FILE}"
  fi
fi
# END OCAML DEVEL ==============================================================


# PERL DEVEL ===================================================================
## PERL VERSION MANAGERS =======================================================
### PERLBREW ===================================================================
# export PERLBREW_ROOT="${XDG_DATA_HOME}/perlbrew"
# source_if_exists "${PERLBREW_ROOT}/etc/bashrc"
### PLENV ======================================================================
export PLENV_ROOT="${XDG_DATA_HOME}/plenv"
prepend_to_path "${PLENV_ROOT}/bin"
eval_if_exists plenv "init - bash"
if command_exists plenv; then
  PLENV_PERL_PATH="${PLENV_ROOT}/versions/$(plenv global)"
  prepend_to_path "${PLENV_PERL_PATH}/bin"
  prepend_to_manpath "${PLENV_PERL_PATH}/man"
fi
## PERL TOOLS ==================================================================
### CPANM ======================================================================
if command_exists cpanm; then
  export PERL_CPANM_HOME="${XDG_CACHE_HOME}/cpanm"
  export PERL_CPANM_OPT="--prompt --notest -l ${XDG_DATA_HOME}/perl"
fi
### PERL
prepend_to_path "${XDG_DATA_HOME}/perl/bin"
if command_exists perl; then
  export PERL_LOCAL_LIB_ROOT="${XDG_DATA_HOME}/perl${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
  export PERL_MB_OPT="--install_base ${XDG_DATA_HOME}/perl"
  export PERL_MM_OPT="INSTALL_BASE=${XDG_DATA_HOME}/perl"
  export PERL5LIB="${XDG_DATA_HOME}/perl/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
fi
### PERLCRITIC =================================================================
export PERLCRITIC="${XDG_CONFIG_HOME}/perlcritic/perlcriticrc"
if command_exists perlcritic; then
  if [ ! -f "${PERLCRITIC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/perlcritic"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/perlcritic/perlcriticrc" "${PERLCRITIC}"
  fi
fi
### PERLTIDY ===================================================================
export PERLTIDY="${XDG_CONFIG_HOME}/perltidy/perltidyrc"
if command_exists perltidy; then
  if [ ! -f "${PERLTIDY}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/perltidy"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/perltidy/perltidyrc" "${PERLTIDY}"
  fi
fi
### REPLY ======================================================================
alias_if_exists "reply --cfg ${XDG_CONFIG_HOME}/reply/replyrc" "reply"
# END PERL DEVEL ===============================================================


# PHP DEVEL ====================================================================
## PHP VERSION MANAGERS ========================================================
### PHPBREW ====================================================================
# export BOX_REQUIREMENT_CHECKER=0
# export PHPBREW_ROOT="${XDG_DATA_HOME}/phpbrew"
# export PHPBREW_HOME="${XDG_DATA_HOME}/phpbrew"
# source_if_exists "${PHPBREW_HOME}/bashrc"
### PHPENV =====================================================================
export PHPENV_ROOT="${XDG_DATA_HOME}/phpenv"
prepend_to_path "${PHPENV_ROOT}/bin"
eval_if_exists phpenv "init - --no-rehash bash"
if command_exists phpenv; then
  PHPENV_PHP_PATH="${PHPENV_ROOT}/versions/$(phpenv global)"
  prepend_to_path "${PHPENV_PHP_PATH}/bin"
  prepend_to_manpath "${PHPENV_PHP_PATH}/share/man"
fi
## PHP PACKAGE MANAGERS ========================================================
### COMPOSER ===================================================================
export COMPOSER_HOME="${XDG_DATA_HOME}/composer"
prepend_to_path "${COMPOSER_HOME}/bin"
prepend_to_path "${COMPOSER_HOME}/vendor/bin"
## PHP TOOLS ===================================================================
### PHIVE ======================================================================
export PHIVE_HOME="${XDG_DATA_HOME}/phive"
### PHP ========================================================================
export PHP_DTRACE=yes
if command_exists php; then
  export PHP_INI_SCAN_DIR="${XDG_CONFIG_HOME}/php"
  if [ ! -d "${PHP_INI_SCAN_DIR}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/php" "$PHP_INI_SCAN_DIR"
  fi
fi
# END PHP DEVEL ================================================================


# PONY DEVEL ===================================================================
## PONY VERSION MANAGERS =======================================================
### PONYUP =====================================================================
prepend_to_path "${XDG_DATA_HOME}/ponyup/bin"
# END PONY DEVEL ===============================================================


# PYTHON DEVEL =================================================================
## PYTHON VERSION MANAGERS =====================================================
# CONDA ========================================================================
export CONDA_AUTO_ACTIVATE_BASE=false
export CONDARC="${XDG_CONFIG_HOME}/conda/condarc"
prepend_to_path "${XDG_DATA_HOME}/conda/condabin"
eval_if_exists conda "shell.bash hook"
if command_exists conda; then
  if [ ! -f "${CONDARC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/conda"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/conda/condarc" "${CONDARC}"
  fi
  for item in $(conda env list | awk '$1 != "#" && $1 != "base" {print $1}'); do # creates .nv/ComputeCache for some unknown reason
    CONDA_ROOT="$(conda info --root)"
    append_to_path "${CONDA_ROOT}/envs/${item}/bin"
    prepend_to_manpath "${CONDA_ROOT}/envs/${item}/share/man"
  done
fi
### PYENV ======================================================================
export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
prepend_to_path "${PYENV_ROOT}/bin"
eval_if_exists pyenv "init - --no-rehash bash"
if command_exists pyenv; then
  if [ ! -f "${PYENV_ROOT}/default-packages" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/pyenv/default-packages" "${PYENV_ROOT}/default-packages"
  fi
  PYENV_PYTHON_PATH="${PYENV_ROOT}/versions/$(pyenv global)"
  prepend_to_path "${PYENV_PYTHON_PATH}/bin"
  prepend_to_manpath "${PYENV_PYTHON_PATH}/share/man"
fi
### PYTHONBREW =================================================================
# export PYTHONBREW_ROOT="${XDG_DATA_HOME}/pythonbrew"
# export PYTHONBREW_HOME="${XDG_DATA_HOME}/pythonbrew"
# eval "$(pythonbrew init)"
### PYTHONZ ====================================================================
# export PYTHONZ_ROOT="${XDG_DATA_HOME}/pythonz"
# export PYTHONZ_HOME="${XDG_DATA_HOME}/pythonz"
# source_if_exists "${PYTHONZ_ROOT}/etc/bashrc"
### RYE ========================================================================
export RYE_HOME="${XDG_DATA_HOME}/rye"
source_if_exists "${RYE_HOME}/env"
## PYTHON PACKAGE MANAGERS =====================================================
### PDM ========================================================================
export PDM_HOME="${XDG_DATA_HOME}/pdm"
prepend_to_path "${PDM_HOME}/bin"
### PIP ========================================================================
PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
prepend_to_path "${PYTHONUSERBASE}/bin"
if command_exists pip; then
  if [ ! -f "${PIP_CONFIG_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/pip"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/pip/pip.conf" "${PIP_CONFIG_FILE}"
  fi
fi
### POETRY =====================================================================
export POETRY_CONFIG_DIR="${XDG_CONFIG_HOME}/poetry"
export POETRY_CACHE_DIR="${XDG_CACHE_HOME}/poetry"
export POETRY_HOME="${XDG_DATA_HOME}/poetry"
prepend_to_path "${POETRY_HOME}/bin"
### UV =========================================================================
export UV_INSTALL_DIR="${XDG_DATA_HOME}/uv"
export UV_CACHE_DIR="${XDG_CACHE_HOME}/uv"
export UV_CONFIG_FILE="${XDG_CONFIG_HOME}/uv/uv.toml"
source_if_exists "${UV_INSTALL_DIR}/env"
## PYTHON TOOLS ================================================================
### IPYTHON ====================================================================
if command_exists ipython; then
  mkdir -p "${XDG_CONFIG_HOME}/ipython"
fi
### JUPYTER ====================================================================
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_FILE="$JUPYTER_CONFIG_DIR/jupyter_notebook_config.py"
if command_exists jupyter; then
  if [ ! -f "${JUPYTER_CONFIG_FILE}" ]; then
    mkdir -p "${JUPYTER_CONFIG_DIR}"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/jupyter/config.py" "${JUPYTER_CONFIG_FILE}"
  fi
fi
### PEX ========================================================================
export PEX_ROOT="${XDG_CACHE_HOME}/pex"
### PIPX =======================================================================
export PIPX_HOME="${XDG_DATA_HOME}/pipx"
export PIPX_BIN_DIR="${XDG_DATA_HOME}/pipx/bin"
prepend_to_path "${PIPX_BIN_DIR}"
### PYLINT =====================================================================
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export PYLINTRC="$XDG_CONFIG_HOME/pylint/pylintrc"
if command_exists pylint; then
  if [ ! -f "${PYLINTRC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/pylint"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/pylint/pylintrc" "${PYLINTRC}"
  fi
fi
### PYTHON =====================================================================
export PYTHON_COLORS=1
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history" # python >= 3.13
export PYTHON_JIT=1
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
# END PYTHON DEVEL =============================================================


# R DEVEL ======================================================================
## R VERSION MANAGERS ==========================================================
### RENV =======================================================================
export RENV_ROOT="${XDG_DATA_HOME}/renv"
prepend_to_path "${RENV_ROOT}/bin"
eval_if_exists renv "init - --no-rehash bash"
if command_exists renv; then
  RENV_R_PATH="${RENV_ROOT}/versions/$(renv global)"
  prepend_to_path "${RENV_R_PATH}/bin"
  prepend_to_manpath "${RENV_R_PATH}/share/man"
fi
## R TOOLS =====================================================================
### R ==========================================================================
export R_HISTFILE="${XDG_STATE_HOME}/r/history"
export R_HOME_USER="${XDG_DATA_HOME}/r"
export R_LIBS_USER="${XDG_DATA_HOME}/r/library"
export R_PROFILE_USER="${XDG_CONFIG_HOME}/r/profile"
if command_exists r; then
  mkdir -p "${XDG_STATE_HOME}/r"
  mkdir -p "${R_LIBS_USER}"
  if [ ! -f "${R_PROFILE_USER}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/r/"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/r/profile" "${R_PROFILE_USER}"
  fi
fi
alias_if_exists "R" "r"
alias_if_exists "Rscript" "rscript"
### RADIAN =====================================================================
export RADIAN_CONFIG_FILE="${XDG_CONFIG_HOME}/radian/profile"
if command_exists radian; then
  if [ ! -f "${RADIAN_CONFIG_FILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/radian"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/radian/profile" "${RADIAN_CONFIG_FILE}"
  fi
fi
# END R DEVEL ==================================================================


# RAKU DEVEL ===================================================================
## RAKU VERSION MANAGERS =======================================================
### RAKUBREW ===================================================================
export RAKUBREW_HOME="${XDG_DATA_HOME}/rakubrew"
prepend_to_path "${RAKUBREW_HOME}/bin"
eval_if_exists rakubrew "init Bash"
### RAKUENV ====================================================================
export RAKUENV_ROOT="${XDG_DATA_HOME}/rakuenv"
prepend_to_path "${RAKUENV_ROOT}/bin"
# eval_if_exists rakuenv "init -"
## RAKU PACKAGE MANAGERS =======================================================
### ZEF ========================================================================
export ZEF_CONFIG_STOREDIR="${XDG_DATA_HOME}/zef/store"
export ZEF_CONFIG_TEMPDIR="${XDG_CACHE_HOME}/zef/temp"
## RAKU TOOLS ==================================================================
### RAKU =======================================================================
export RAKUDO_HIST="${XDG_STATE_HOME}/rakudo/history"
export RAKULIB="${XDG_CACHE_HOME}/raku${RAKULIB:+:${RAKULIB}}"
# END RAKU DEVEL ===============================================================


# RUBY DEVEL ===================================================================
## RUBY VERSION MANAGERS =======================================================
### RBENV ======================================================================
export RBENV_ROOT="${XDG_DATA_HOME}/rbenv"
prepend_to_path "${RBENV_ROOT}/bin"
eval_if_exists rbenv "init - --no-rehash bash"
if command_exists rbenv; then
  if [ ! -f "${RBENV_ROOT}/default-gems" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/xxenv/rbenv/default-gems" "${RBENV_ROOT}/default-gems"
  fi
  RBENV_RUBY_PATH="${RBENV_ROOT}/versions/$(rbenv global)"
  prepend_to_path "${RBENV_RUBY_PATH}/bin"
  prepend_to_manpath "${RBENV_RUBY_PATH}/share/man"
fi
### RVM ========================================================================
# prepend_to_path "${XDG_DATA_HOME}/rvm/bin"
# source_if_exists "${XDG_DATA_HOME}/rvm/scripts/rvm"
## RUBY PACKAGE MANAGERS =======================================================
### BUNDLER ====================================================================
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
### GEM ========================================================================
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
## RUBY TOOLS ==================================================================
### IRB ========================================================================
export IRBRC="${XDG_CONFIG_HOME}/irb/irbrc"
if command_exists irb; then
  mkdir -p "${XDG_STATE_HOME}/irb"
  if [ ! -f "${IRBRC}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/irb"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/irb/irbrc" "${IRBRC}"
  fi
fi
### RUBY =======================================================================
### SOLARGRAPH =================================================================
export SOLARGRAPH_CACHE="${XDG_CACHE_HOME}/solargraph"
# END RUBY DEVEL ===============================================================


# RUST DEVEL ===================================================================
## RUST VERSION MANAGERS =======================================================
### RUSTUP =====================================================================
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
if command_exists rustup; then
  RUSTC_TOOLCHAIN="$(rustup show active-toolchain | awk '{print $1}')"
  RUSTUP_RUSTC_PATH="${RUSTUP_HOME}/toolchains/${RUSTC_TOOLCHAIN}"
  prepend_to_manpath "${RUSTUP_RUSTC_PATH}/share/man"
fi
## RUST PACKAGE MANAGERS =======================================================
### CARGO ======================================================================
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
source_if_exists "${CARGO_HOME}/env"
# END RUST DEVEL ===============================================================


# SWIFT DEVEL ==================================================================
## SWIFT VERSION MANAGERS ======================================================
### SWIFTENV ===================================================================
export SWIFTENV_ROOT="${XDG_DATA_HOME}/swiftenv"
prepend_to_path "${SWIFTENV_ROOT}/bin"
eval_if_exists swiftenv "init -"
### SWIFTLY ====================================================================
export SWIFTLY_HOME_DIR="${XDG_DATA_HOME}/swiftly"
export SWIFTLY_BIN_DIR="${SWIFTLY_HOME_DIR}/bin"
source_if_exists "${SWIFTLY_HOME_DIR}/env.sh"
## SWIFT PACKAGE MANAGERS ======================================================
### COCOAPODS ==================================================================
export CP_HOME_DIR="${XDG_CACHE_HOME}/cocoapods"
### MINT =======================================================================
export MINT_PATH="${XDG_DATA_HOME}/mint"
export MINT_LINK_PATH="${XDG_DATA_HOME}/mint/bin"
prepend_to_path "${MINT_LINK_PATH}"
## SWIFT TOOLS =================================================================
### SOURCEKIT LSP ==============================================================
del_if_exists "${HOME}/.sourcekit-lsp"
### SWIFTLINT ==================================================================
export LINUX_SOURCEKIT_LIB_PATH="/usr/libexec/swift/lib/libsourcekitdInProc.so"
# END SWIFT DEVEL ==============================================================


# V DEVEL ======================================================================
## V-TOOLS =====================================================================
### V-ANALYZER =================================================================
prepend_to_path "${XDG_CONFIG_HOME}/v-analyzer/bin"
### V ==========================================================================
export VCACHE="${XDG_CACHE_HOME}/v/cache"
export VMODULES="${XDG_DATA_HOME}/v-modules"
prepend_to_path "${XDG_DATA_HOME}/v"
# END V DEVEL ==================================================================


# PROGRAMMING LANGUAGES ========================================================
# CLEAN ========================================================================
export CLEAN_HOME="${XDG_DATA_HOME}/clean"
prepend_to_path "${CLEAN_HOME}/bin"
# FACTOR =======================================================================
prepend_to_path "${XDG_DATA_HOME}/factor"
# MOJO =========================================================================
export MODULAR_HOME="${XDG_DATA_HOME}/modular"
prepend_to_path "${MODULAR_HOME}/pkg/packages.modular.com_mojo/bin"
# ODIN =========================================================================
export ODIN_ROOT="${XDG_DATA_HOME}/odin"
prepend_to_path "${ODIN_ROOT}"
# OCTAVE =======================================================================
export OCTAVE_HISTFILE="${XDG_STATE_HOME}/octave/history"
export OCTAVE_SITE_INITFILE="${XDG_CONFIG_HOME}/octave/octaverc"
if command_exists octave; then
  if [ ! -f "${OCTAVE_SITE_INITFILE}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/octave"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/octave/octaverc" "${OCTAVE_SITE_INITFILE}"
  fi
fi
# PROCESSING ===================================================================
export PROCESSING_JAVA="${XDG_DATA_HOME}/processing/processing-java"
prepend_to_path "${XDG_DATA_HOME}/processing"
# RED ==========================================================================
prepend_to_path "${XDG_DATA_HOME}/red/bin"
# SCILAB =======================================================================
export SCIHOME="${XDG_STATE_HOME}/scilab"
alias_if_exists "scilab-cli -scihome ${SCIHOME}" "scilab"
alias_if_exists "scilab-cli -scihome ${SCIHOME}" "scilab-cli"
# ZEEK =========================================================================
prepend_to_path "/opt/zeek/bin"
# END PROGRAMMING LANGUAGES ====================================================


# DATABASES ====================================================================
### INSTANTCLIENT ==============================================================
export INSTANTCLIENT="${XDG_DATA_HOME}/oracle/instantclient"
prepend_to_ld_library_path "${INSTANTCLIENT}"
# MYSQL ========================================================================
export MYSQL_HISTFILE="${XDG_STATE_HOME}/mysql/history"
if command_exists mysql; then
  mkdir -p "${XDG_STATE_HOME}/mysql"
fi
# PGSQL ========================================================================
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
# REDIS ========================================================================
export REDISCLI_HISTFILE="${XDG_STATE_HOME}/redis/history"
export REDISCLI_RCFILE="${XDG_CONFIG_HOME}/redis/redisclirc"
if command_exists redis-cli; then
  mkdir -p "${XDG_STATE_HOME}/redis"
fi
# SQLITE3 ======================================================================
export SQLITE_HISTORY="${XDG_STATE_HOME}/sqlite/history"
if command_exists sqlite3; then
  mkdir -p "${XDG_STATE_HOME}/sqlite"
fi
# END DATABASES ================================================================


# VERSION CONTROL ==============================================================
# GIT ==========================================================================
GIT_CONFIG="${XDG_CONFIG_HOME}/git/config" # ElixirLs does not work when exporting GIT_CONFIG
if command_exists git; then
  if [ ! -f "${GIT_CONFIG}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/git"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/git/config" "${GIT_CONFIG}"
  fi
fi
# MERCURIAL ====================================================================
export HGRCPATH="${XDG_CONFIG_HOME}/hg/config"
# SUBVERSION ===================================================================
alias_if_exists "svn --config-dir ${XDG_CONFIG_HOME}/subversion" "svn"
# END VERSION CONTROL ==========================================================


## UTILITIES ===================================================================
# ANSIBLE ======================================================================
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy-cache"
# AWS ==========================================================================
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
# AZURE ========================================================================
export AZURE_CONFIG_DIR="${XDG_DATA_HOME}/azure"
# CALC =========================================================================
export CALCHISTFILE="${XDG_STATE_HOME}/calc/history"
if command_exists calc; then
  mkdir -p "${XDG_STATE_HOME}/calc"
fi
# CHEAT.SH =====================================================================
export CHTSH="${XDG_DATA_HOME}/cht.sh"
export CHTSH_CONFIG="${XDG_CONFIG_HOME}/cht.sh/config"
# DIRENV =======================================================================
eval_if_exists direnv "hook bash"
# DOCKER =======================================================================
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
# DUST =========================================================================
alias_if_exists "dust" "du"
# FOUNDRY ======================================================================
export FOUNDRY_DIR="${XDG_DATA_HOME}/foundry"
prepend_to_path "${FOUNDRY_DIR}/bin"
# GNUPG ========================================================================
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"
if [ ! -d "${GNUPGHOME}" ]; then
  mkdir -p "${GNUPGHOME}"
  chmod 700 "${GNUPGHOME}"
fi
# GTK ==========================================================================
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
# ICONS ========================================================================
# export XCURSOR_PATH="/usr/share/icons:${XDG_DATA_HOME}/icons"
# LESS =========================================================================
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
# LSD ==========================================================================
alias_if_exists "lsd -A" "ls"
# SDCV =========================================================================
export SDCV_HISTFILE="${XDG_STATE_HOME}/sdcv/history"
export STARDICT_DATA_DIR="${XDG_DATA_HOME}/stardict"
# STARSHIP =====================================================================
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship.toml"
export STARSHIP_CACHE="${XDG_CACHE_HOME}/starship"
# TERRAFORM ====================================================================
export TF_HOME_DIR="${XDG_DATA_HOME}/terraform"
# TEXLIVE ======================================================================
export TEXMFCONFIG="${XDG_CONFIG_HOME}/texlive/texmf-config"
export TEXMFHOME="${XDG_DATA_HOME}/texmf"
export TEXMFVAR="${XDG_CACHE_HOME}/texlive/texmf-var"
# TEALDEER =====================================================================
export TEALDEER_CONFIG_DIR="${XDG_CONFIG_HOME}/tldr"
if command_exists tldr; then
  if [ ! -d "${TEALDEER_CONFIG_DIR}" ]; then
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/tealdeer" "${TEALDEER_CONFIG_DIR}"
  fi
fi
# VAGRANT ======================================================================
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME}/vagrant/aliases"
# W3M ==========================================================================
export W3M_DIR="${XDG_STATE_HOME}/w3m"
# WGET =========================================================================
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
if command_exists wget; then
  if [ ! -f "$WGETRC" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/wget"
    ln -s "$(dirname "${BASH_SOURCE[0]}")/../config/wget/wgetrc" "$WGETRC"
  fi
fi
# XORG =========================================================================
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"
# ZOXIDE =======================================================================
export _ZO_ECHO=1
eval_if_exists zoxide "init bash"
alias_if_exists "z" "cd"
# END UTILITIES ================================================================



# CUSTOMIZATION ================================================================
# CUSTOM LIMITS
if [ "${SHELL}" = "/bin/bash" ]; then
  ulimit -n 104857
fi
# OH MY POSH ===================================================================
eval_if_exists oh-my-posh "init bash --config ~/.cache/oh-my-posh/themes/night-owl.omp.json"
# USE WINDOWS BROWSER IN WSL ===================================================
if grep -q WSL /proc/version; then
  export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe %s"
fi
# END CUSTOMIZATION ============================================================


# ENVIRONMENT VARIABLES ========================================================
export _JAVA_OPTIONS
export ADA_INCLUDE_PATH
export ADA_OBJECTS_PATH
export CLASSPATH
export CPATH
export LD_LIBRARY_PATH
export LIBRARY_PATH
export MANPATH
export PATH
# END ENVIRONMENT VARIABLES ====================================================

# export no_grpc_proxy=localhost,127.0.0.0/8

unset item
