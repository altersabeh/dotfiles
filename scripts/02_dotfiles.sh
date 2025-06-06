#!/usr/bin/env bash

THIS_SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
CUSTOM_CONFIG_DIR="${THIS_SCRIPT_DIR}/../config"

# Define a variable to track the last modification time of this script
DOTFILES_SH_LAST_MODIFIED_VAR="DOTFILES_SH_LAST_MODIFIED"
DOTFILES_SH_PATH="${THIS_SCRIPT_DIR}/02_dotfiles.sh"
# Get the current modification time of this script
current_mod_time=$(stat -c %Y "$DOTFILES_SH_PATH")

# Check if the script has been sourced before and if it has been updated
if [ -z "${!DOTFILES_SH_LAST_MODIFIED_VAR}" ] || [ "${!DOTFILES_SH_LAST_MODIFIED_VAR}" -lt "$current_mod_time" ]; then
  # echo "Sourcing the script"
  # Update the environment variable with the current modification time
  export $DOTFILES_SH_LAST_MODIFIED_VAR="$current_mod_time"
  unset DOTFILES_SH_ALREADY_SOURCED
fi

if [ -n "${DOTFILES_SH_ALREADY_SOURCED}" ]; then
  # echo "The script has already been sourced"
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

# PROFILE ======================================================================
ORIG_PROFILE_CONFIG="${HOME}/.profile"
CUSTOM_PROFILE_CONFIG="${CUSTOM_CONFIG_DIR}/shell/profile"
if [ "${ORIG_PROFILE_CONFIG}" != "${CUSTOM_PROFILE_CONFIG}" ]; then
  [ -f "${ORIG_PROFILE_CONFIG}" ] && rm "${ORIG_PROFILE_CONFIG}" # remove the existing .profile
  ln -s "${CUSTOM_PROFILE_CONFIG}" "${ORIG_PROFILE_CONFIG}"
fi

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
export HISTCONTROL="ignoreboth"
export HISTFILE="${XDG_STATE_HOME}/${item}/history"
export HISTFILESIZE=-1
export HISTSIZE=-1
mkdir -p "${XDG_STATE_HOME}/${item}"
### BASH =======================================================================
if [ "${SHELL}" = "/bin/bash" ]; then
  HOME_BASHRC_PATH="${HOME}/.bashrc"
  ORIG_BASHRC_PATH="${XDG_CONFIG_HOME}/bash/bashrc"
  CUSTOM_BASHRC_PATH="${CUSTOM_CONFIG_DIR}/shell/bashrc"
  if [ ! -f "${ORIG_BASHRC_PATH}" ]; then
    [ -f "${HOME_BASHRC_PATH}" ] && rm "${HOME_BASHRC_PATH}" # remove the existing .bashrc
    mkdir -p "${XDG_CONFIG_HOME}/bash"
    ln -s "${CUSTOM_BASHRC_PATH}" "${ORIG_BASHRC_PATH}"
  fi
fi
#
# if you want to use the original location of the .bashrc file in the home
# directory then uncomment the following block of code and comment the block
# of code above
#
# ORIG_BASHRC_PATH="${HOME}/.bashrc"
# CUSTOM_BASHRC_PATH="${CUSTOM_CONFIG_DIR}/bash/bashrc"
# if [ "$(realpath "${ORIG_BASHRC_PATH}")" != "${CUSTOM_BASHRC_PATH}" ]; then
#   [ -f ${ORIG_BASHRC_PATH} ] && rm "${ORIG_BASHRC_PATH}" # remove the existing .bashrc
#   ln -s "${CUSTOM_BASHRC_PATH}" "${ORIG_BASHRC_PATH}"
# fi
# END SHELL DEVEL ==============================================================

## VERSION MANAGERS ============================================================
### AQUA =======================================================================
export AQUA_ROOT_DIR="${XDG_DATA_HOME}/aqua"
prepend_to_path "${AQUA_ROOT_DIR}/bin"
### ASDF =======================================================================
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
source_if_exists "${ASDF_DATA_HOME}/asdf.sh"
if command_exists asdf; then
  if [ ! -f "${ASDF_CONFIG_FILE}" ]; then
    CUSTOM_ASDF_CONFIG_FILE="${CUSTOM_CONFIG_DIR}/asdf/asdfrc"
    mkdir -p "${XDG_CONFIG_HOME}/asdf"
    ln -s "${CUSTOM_ASDF_CONFIG_FILE}" "${ASDF_CONFIG_FILE}"
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
### NEOVIM =====================================================================
if command_exists nvim; then
  CUSTOM_VIMINIT="${CUSTOM_CONFIG_DIR}/nvim/init.vim"
  ORIG_VIMINIT="${XDG_CONFIG_HOME}/nvim/init.vim"
  if [ ! -f "${ORIG_VIMINIT}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/nvim"
    ln -s "${CUSTOM_VIMINIT}" "${ORIG_VIMINIT}"
  fi
fi
## END TEXT EDITORS/IDE ========================================================

# ADA DEVEL ====================================================================
## ADA PACKAGE MANAGERS ========================================================
### ALIRE ======================================================================
export ALIRE_SETTINGS_DIR="${XDG_CONFIG_DIR}/alire"
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
# prepend_to_cpath "${X86_64_LIB_PATH}/include"
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
    CUSTOM_EM_CONFIG="${CUSTOM_CONFIG_DIR}/emscripten/config"
    mkdir -p "${XDG_CONFIG_HOME}/emscripten"
    ln -s "${CUSTOM_EM_CONFIG}" "${EM_CONFIG}"
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
export CONAN_HOME="${XDG_CONFIG_HOME}" # conan >= 2.0
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
# prepend_to_cpath "${CLING_HOME}/lib/clang/18/include"
### GNUSTEP ====================================================================
# prepend_to_cpath "/usr/include/GNUstep"
### UNCRUSTIFY =================================================================
export UNCRUSTIFY_CONFIG="${XDG_CONFIG_HOME}/uncrustify/uncrustify.cfg"
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
# del_if_exists "${HOME}/.dart-tool"
# END DART DEVEL ===============================================================

# DOTNET DEVEL =================================================================
## DOTNET PACKAGE MANAGERS =====================================================
### DOTNET =====================================================================
export DOTNET_BUNDLE_EXTRACT_BASE_DIR="${XDG_CACHE_HOME}/dotnet/bundle"
export DOTNET_CLI_HOME="${XDG_DATA_HOME}/dotnet"
export DOTNET_ROLL_FORWARD="major"
if command_exists dotnet; then
  mkdir -p "${DOTNET_CLI_HOME}"
  if [ ! -L "${DOTNET_CLI_HOME}/tools" ]; then
    ln -s "${DOTNET_CLI_HOME}/.dotnet/tools" "${DOTNET_CLI_HOME}/tools"
  fi
fi
prepend_to_path "${DOTNET_CLI_HOME}/tools"
del_if_exists "${HOME}/.dotnet"
del_if_exists "${HOME}/.ServiceHub"
### DNVM =======================================================================
export DNVM_HOME="${XDG_DATA_HOME}/dnvm"
source_if_exists "${DNVM_HOME}/env"
### NUGET ======================================================================
export NUGET_HTTP_CACHE_PATH="${XDG_CACHE_HOME}/nuget/cache"
export NUGET_PACKAGES="${XDG_CACHE_HOME}/nuget/packages"
export NUGET_PLUGINS_CACHE_PATH="${XDG_CACHE_HOME}/nuget/plugins"
## DOTNET TOOLS ================================================================
### MONO =======================================================================
# export MONO_REGISTRY_PATH="${XDG_CACHE_HOME}/mono/registry"
export MONO_PATH="${XDG_DATA_HOME}/mono"
export MONO_GAC_PATH="${XDG_DATA_HOME}/mono/gac"
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
  EVM_ERLANG_PATH="${EVM_HOME}/versions/${ERLANG_VERSION}"
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
  KIEX_ELIXIR_VERSION="$(elixir --short-version)"
  KIEX_ELIXIR_PATH="${KIEX_HOME}/elixirs/elixir-${KIEX_ELIXIR_VERSION}"
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
### HEX ========================================================================
export HEX_HOME="${XDG_CACHE_HOME}/hex"
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
  # prepend_to_path "${GOENV_GO_PATH}/bin"
fi
## GO PACKAGE MANAGERS =========================================================
### MAGE =======================================================================
export MAGEFILE_CACHE="${XDG_CACHE_HOME}/magefile"
## GO TOOLS ====================================================================
### GO =========================================================================
export GOBIN="${XDG_DATA_HOME}/go/bin"
export GOCACHE="${XDG_CACHE_HOME}/go/build"
export GOENV="${XDG_DATA_HOME}/go/env"
export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"
export GOTELEMETRYDIR="${XDG_CACHE_HOME}/go/telemetry"
if command_exists go; then
  if [ ! -d "${XDG_DATA_HOME}/go" ]; then
    mkdir -p "${XDG_DATA_HOME}/go"
    mkdir -p "${XDG_DATA_HOME}/go/bin"
  fi
fi
prepend_to_gopath "${XDG_DATA_HOME}/go"
prepend_to_path "${GOBIN}"
### GOLANGCI-LINT ==============================================================
export GOLANGCI_LINT_CACHE="${XDG_CACHE_HOME}/golangci-lint"
### GOPLS ======================================================================
export GOPLSCACHE="${XDG_CACHE_HOME}/gopls"
# END GO DEVEL =================================================================

# HASKELL DEVEL ================================================================
## HASKELL VERSION MANAGERS ====================================================
### GHCUP ======================================================================
# export GHCUP_INSTALL_BASE_PREFIX="${XDG_DATA_HOME}"
export GHCUP_USE_XDG_DIRS=1
source_if_exists "${XDG_DATA_HOME}/ghcup/env"
# if command_exists ghc; then
#   GHC_VERSION="$(ghc --numeric-version)"
#   GHCUP_GHC_PATH="${XDG_DATA_HOME}/ghcup/ghc/${GHC_VERSION}"
#   prepend_to_manpath "${GHCUP_GHC_PATH}/share/man"
# fi
## HASKELL PACKAGE MANAGERS ====================================================
### CABAL ======================================================================
# export CABAL_CONFIG="${XDG_CONFIG_HOME}/cabal/config"
export CABAL_DIR="${XDG_DATA_HOME}/cabal"
prepend_to_path "${CABAL_DIR}/bin"
# if command_exists cabal; then
#   if [ ! -f "${CABAL_CONFIG}" ]; then
#     CUSTOM_CABAL_CONFIG="${CUSTOM_CONFIG_DIR}/cabal/config"
#     mkdir -p "${XDG_CONFIG_HOME}/cabal"
#     ln -s "${CUSTOM_CABAL_CONFIG}" "${CABAL_CONFIG}"
#   fi
# fi
### STACK ======================================================================
export STACK_XDG=1
# export STACK_CONFIG_YAML="${XDG_CONFIG_HOME}/stack/config.yaml"
if command_exists stack; then
  if [ ! -d "${XDG_DATA_HOME}/stack/hooks" ]; then
    CUSTOM_STACK_HOOKS="${CUSTOM_CONFIG_DIR}/stack/hooks"
    mkdir -p "${XDG_DATA_HOME}/stack"
    ln -s "${CUSTOM_STACK_HOOKS}" "${XDG_DATA_HOME}/stack/hooks"
  fi
#  if [ ! -f "${STACK_CONFIG_YAML}" ]; then
#    CUSTOM_STACK_CONFIG_YAML="${CUSTOM_CONFIG_DIR}/stack/config.yaml"
#    mkdir -p "${XDG_CONFIG_HOME}/stack"
#    ln -s "${CUSTOM_STACK_CONFIG_YAML}" "${STACK_CONFIG_YAML}"
#  fi
fi
### GHC ========================================================================
if command_exists ghc; then
  if [ ! -d "${XDG_DATA_HOME}/ghc" ]; then
    mkdir -p "${XDG_DATA_HOME}/ghc"
  fi
fi
prepend_to_ghc_package_path "${XDG_DATA_HOME}/ghc:"
del_if_exists "${HOME}/.ghc"
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
  # if [ ! -f "${NODENV_ROOT}/default-packages" ]; then
  #   CUSTOM_NODENV_DEFAULT_PACKAGES="${CUSTOM_CONFIG_DIR}/xxenv/nodenv/default-packages"
  #   ORIG_NODENV_DEFAULT_PACKAGES="${NODENV_ROOT}/default-packages"
  #   ln -s "${CUSTOM_NODENV_DEFAULT_PACKAGES}" "${ORIG_NODENV_DEFAULT_PACKAGES}"
  # fi
  NODENV_NODE_PATH="$NODENV_ROOT/versions/$(nodenv global)"
  # prepend_to_path "${NODENV_NODE_PATH}/bin"
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
export BUN_CREATE_DIR="${XDG_CACHE_HOME}/bun/create"
export BUN_INSTALL="${XDG_DATA_HOME}/bun"
export BUN_INSTALL_CACHE_DIR="${XDG_CACHE_HOME}/bun/cache"
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
    CUSTOM_NPM_CONFIG_USERCONFIG="${CUSTOM_CONFIG_DIR}/npm/npmrc"
    mkdir -p "${XDG_CONFIG_HOME}/npm"
    ln -s "${CUSTOM_NPM_CONFIG_USERCONFIG}" "${NPM_CONFIG_USERCONFIG}"
  fi
fi
### PNPM =======================================================================
export PNPM_HOME="${XDG_DATA_HOME}/pnpm"
prepend_to_path "${PNPM_HOME}"
### YARN =======================================================================
export YARN_GLOBAL_FOLDER="${XDG_CACHE_HOME}/yarn/berry"
## JS AND TS TOOLS =============================================================
### COREPACK ===================================================================
export COREPACK_HOME="${XDG_CACHE_HOME}/corepack"
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
export JULIA_HISTORY="${XDG_STATE_HOME}/julia/history"
if command_exists julia; then
  if [ ! -d "${XDG_DATA_HOME}/julia" ]; then
    mkdir -p "${XDG_DATA_HOME}/julia"
  fi
fi
prepend_to_julia_depot_path "${XDG_DATA_HOME}/julia:"
del_if_exists "${HOME}/.julia"
# END JULIA DEVEL ==============================================================

# JVM DEVEL ====================================================================
## JVM VERSION MANAGERS ========================================================
### COURSIER ===================================================================
export COURSIER_ARCHIVE_CACHE="${XDG_CACHE_HOME}/coursier/archive"
export COURSIER_CACHE="${XDG_CACHE_HOME}/coursier/cache"
export COURSIER_CONFIG_DIR="${XDG_CONFIG_HOME}/coursier"
export COURSIER_INSTALL_DIR="${XDG_DATA_HOME}/coursier/bin"
export COURSIER_MIRRORS="${COURSIER_CONFIG_DIR}/mirror.properties"
prepend_to_path "${COURSIER_INSTALL_DIR}"
if command_exists cs; then
  if [ ! -d "${COURSIER_CONFIG_DIR}" ]; then
    CUSTOM_COURSIER_MIRRORS="${CUSTOM_CONFIG_DIR}/coursier/mirror.properties"
    mkdir -p "${COURSIER_CONFIG_DIR}"
    ln -s "${CUSTOM_COURSIER_MIRRORS}" "${COURSIER_MIRRORS}"
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
add_to_java_options "-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java"
add_to_java_options "-Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"
prepend_to_classpath "."
del_if_exists "${HOME}/.java"
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
export MAVEN_CONFIG="${XDG_CONFIG_HOME}/maven/settings.xml" # custom environment variable
export MAVEN_REPOSITORY="${XDG_CACHE_HOME}/maven/repository" # custom environment variable
export MAVEN_USER_HOME="${XDG_DATA_HOME}/maven" # for maven wrapper
add_to_maven_opts "-Dmaven.repo.local=${MAVEN_REPOSITORY}"
if command_exists mvn; then
  if [ ! -f "${MAVEN_CONFIG}" ]; then
    CUSTOM_MAVEN_CONFIG="${CUSTOM_CONFIG_DIR}/maven/settings.xml"
    mkdir -p "${XDG_CONFIG_HOME}/maven"
    ln -s "${CUSTOM_MAVEN_CONFIG}" "${MAVEN_CONFIG}"
  fi
  if [ ! -d "${MAVEN_REPOSITORY}" ]; then
    mkdir -p "${MAVEN_REPOSITORY}"
  fi
fi
### SBT ========================================================================
add_to_sbt_opts "-Dsbt.global.base=${XDG_CACHE_HOME}/sbt"
add_to_sbt_opts "-Dsbt.ivy.home=${XDG_CACHE_HOME}/ivy2"
add_to_sbt_opts "-Dsbt.boot.directory=${XDG_CACHE_HOME}/sbt/boot"
## OTHER JVM TOOLS =============================================================
### BLOOP ======================================================================
export SCALA_CLI_EXTRA_TIMEOUT="60.seconds"
### GITER8 =====================================================================
del_if_exists "${HOME}/.g8"
### JBANG ======================================================================
export JBANG_CACHE_DIR="${XDG_CACHE_HOME}/jbang"
export JBANG_DIR="${XDG_DATA_HOME}/jbang"
prepend_to_path "${JBANG_DIR}/bin"
### KSCRIPT ====================================================================
export KSCRIPT_CACHE_DIR="${XDG_CACHE_HOME}/kscript"
### METALS =====================================================================
del_if_exists "${HOME}/.bloop"
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
    CUSTOM_LEIN_PROFILES="${CUSTOM_CONFIG_DIR}/lein/profiles.clj"
    ORIG_LEIN_PROFILES="${LEIN_HOME}/profiles.clj"
    mkdir -p "${LEIN_HOME}"
    ln -s "${CUSTOM_LEIN_PROFILES}" "${ORIG_LEIN_PROFILES}"
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
  # if [ ! -f "${LUAENV_ROOT}/default-rocks" ]; then
  #   CUSTOM_LUAENV_DEFAULT_ROCKS="${CUSTOM_CONFIG_DIR}/xxenv/luaenv/default-rocks"
  #   ORIG_LUAENV_DEFAULT_ROCKS="${LUAENV_ROOT}/default-rocks"
  #   ln -s "${CUSTOM_LUAENV_DEFAULT_ROCKS}" "${ORIG_LUAENV_DEFAULT_ROCKS}"
  # fi
  LUAENV_LUA_PATH="$LUAENV_ROOT/versions/$(luaenv global)"
  # prepend_to_path "${LUAENV_LUA_PATH}/bin"
  prepend_to_manpath "${LUAENV_LUA_PATH}/share/man"
fi
## LUA PACKAGE MANAGERS ========================================================
### LUAROCKS ===================================================================
export LUAROCKS_CONFIG="${XDG_CONFIG_HOME}/luarocks/config.lua"
export LUAROCKS_TREE="${XDG_DATA_HOME}/luarocks"
if command_exists luarocks; then
  if [ ! -f "${LUAROCKS_CONFIG}" ]; then
    CUSTOM_LUAROCKS_CONFIG="${CUSTOM_CONFIG_DIR}/luarocks/config.lua"
    mkdir -p "${XDG_CONFIG_HOME}/luarocks"
    ln -s "${CUSTOM_LUAROCKS_CONFIG}" "${LUAROCKS_CONFIG}"
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
    CUSTOM_OCAML_INIT_FILE="${CUSTOM_CONFIG_DIR}/ocaml/init.ml"
    mkdir -p "${XDG_CONFIG_HOME}/ocaml"
    ln -s "${CUSTOM_OCAML_INIT_FILE}" "${OCAML_INIT_FILE}"
  fi
fi
# END OCAML DEVEL ==============================================================

# PERL DEVEL ===================================================================
## PERL VERSION MANAGERS =======================================================
### PERLBREW ===================================================================
export PERLBREW_ROOT="${XDG_DATA_HOME}/perlbrew"
source_if_exists "${PERLBREW_ROOT}/etc/bashrc"
### PLENV ======================================================================
export PLENV_ROOT="${XDG_DATA_HOME}/plenv"
prepend_to_path "${PLENV_ROOT}/bin"
eval_if_exists plenv "init - bash"
if command_exists plenv; then
  PLENV_PERL_PATH="${PLENV_ROOT}/versions/$(plenv global)"
  # prepend_to_path "${PLENV_PERL_PATH}/bin"
  prepend_to_manpath "${PLENV_PERL_PATH}/man"
fi
## PERL TOOLS ==================================================================
### CPANM ======================================================================
prepend_to_path "${XDG_DATA_HOME}/perl/bin"
export PERL_CPANM_HOME="${XDG_CACHE_HOME}/cpanm"
export PERL_CPANM_OPT="--prompt --reinstall --notest -l ${XDG_DATA_HOME}/perl"
### PERL
export PERL_LOCAL_LIB_ROOT="${XDG_DATA_HOME}/perl${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base ${XDG_DATA_HOME}/perl"
export PERL_MM_OPT="INSTALL_BASE=${XDG_DATA_HOME}/perl"
export PERL5LIB="${XDG_DATA_HOME}/perl/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
### PERLCRITIC =================================================================
export PERLCRITIC="${XDG_CONFIG_HOME}/perlcritic/perlcriticrc"
if command_exists perlcritic; then
  if [ ! -f "${PERLCRITIC}" ]; then
    CUSTOM_PERLCRITIC="${CUSTOM_CONFIG_DIR}/perlcritic/perlcriticrc"
    mkdir -p "${XDG_CONFIG_HOME}/perlcritic"
    ln -s "${CUSTOM_PERLCRITIC}" "${PERLCRITIC}"
  fi
fi
### PERLTIDY ===================================================================
export PERLTIDY="${XDG_CONFIG_HOME}/perltidy/perltidyrc"
if command_exists perltidy; then
  if [ ! -f "${PERLTIDY}" ]; then
    CUSTOM_PERLTIDY="${CUSTOM_CONFIG_DIR}/perltidy/perltidyrc"
    mkdir -p "${XDG_CONFIG_HOME}/perltidy"
    ln -s "${CUSTOM_PERLTIDY}" "${PERLTIDY}"
  fi
fi
### REPLY ======================================================================
alias_if_exists "reply --cfg ${XDG_CONFIG_HOME}/reply/replyrc" "reply"
# END PERL DEVEL ===============================================================

# PHP DEVEL ====================================================================
## PHP VERSION MANAGERS ========================================================
### PHPBREW ====================================================================
export PHPBREW_ROOT="${XDG_DATA_HOME}/phpbrew"
export PHPBREW_HOME="${XDG_DATA_HOME}/phpbrew"
source_if_exists "${PHPBREW_HOME}/bashrc"
### PHPENV =====================================================================
export PHPENV_ROOT="${XDG_DATA_HOME}/phpenv"
prepend_to_path "${PHPENV_ROOT}/bin"
eval_if_exists phpenv "init - --no-rehash bash"
if command_exists phpenv; then
  PHPENV_PHP_PATH="${PHPENV_ROOT}/versions/$(phpenv global)"
  # prepend_to_path "${PHPENV_PHP_PATH}/bin"
  prepend_to_manpath "${PHPENV_PHP_PATH}/share/man"
fi
## PHP PACKAGE MANAGERS ========================================================
### COMPOSER ===================================================================
export COMPOSER_HOME="${XDG_DATA_HOME}/composer"
export COMPOSER_CACHE_DIR="${XDG_CACHE_HOME}/composer"
prepend_to_path "${COMPOSER_HOME}/bin"
prepend_to_path "${COMPOSER_HOME}/vendor/bin"
## PHP TOOLS ===================================================================
### PHIVE ======================================================================
export PHIVE_HOME="${XDG_DATA_HOME}/phive"
### PHP ========================================================================
export PHP_DTRACE=yes
export PHP_INI_SCAN_DIR="${PHP_INI_SCAN_DIR}:${XDG_CONFIG_HOME}/php/etc"
export PHP_HISTFILE="${XDG_STATE_HOME}/php/history" # php >= 8.4
export PHPRC="${XDG_CONFIG_HOME}/php/php.ini"
if command_exists php; then
  mkdir -p "${XDG_STATE_HOME}/php"
  if [ ! -d "${XDG_CONFIG_HOME}/php" ]; then
    CUSTOM_PHP_CONFIG_DIR="${CUSTOM_CONFIG_DIR}/php"
    ln -s "${CUSTOM_PHP_CONFIG_DIR}" "${XDG_CONFIG_HOME}/php"
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
    CUSTOM_CONDARC="${CUSTOM_CONFIG_DIR}/conda/condarc"
    mkdir -p "${XDG_CONFIG_HOME}/conda"
    ln -s "${CUSTOM_CONDARC}" "${CONDARC}"
  fi
  for item in $( # creates .nv/ComputeCache for some unknown reason
    get_conda_envs
  ); do
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
  # if [ ! -f "${PYENV_ROOT}/default-packages" ]; then
  #   CUSTOM_PYENV_DEFAULT_PACKAGES="${CUSTOM_CONFIG_DIR}/xxenv/pyenv/default-packages"
  #   ORIG_PYENV_DEFAULT_PACKAGES="${PYENV_ROOT}/default-packages"
  #   ln -s "${CUSTOM_PYENV_DEFAULT_PACKAGES}" "${ORIG_PYENV_DEFAULT_PACKAGES}"
  # fi
  PYENV_PYTHON_PATH="${PYENV_ROOT}/versions/$(pyenv global)"
  # prepend_to_path "${PYENV_PYTHON_PATH}/bin"
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
## PYTHON SETTINGS =============================================================
export PYTHON_COLORS=1
export PYTHON_HISTORY="${XDG_STATE_HOME}/python/history" # python >= 3.13
export PYTHON_JIT=1
export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME}/python"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export PYTHONUSERBASE="${XDG_DATA_HOME}/python"
if command_exists python; then
  mkdir -p "${XDG_STATE_HOME}/python"
  if [ ! -f "${PYTHONSTARTUP}" ]; then
    mkdir -p "${XDG_CONFIG_HOME}/python"
    ln -s "${CUSTOM_CONFIG_DIR}/python/pythonrc" "${PYTHONSTARTUP}"
  fi
fi
## PYTHON PACKAGE MANAGERS =====================================================
### PDM ========================================================================
export PDM_CACHE_DIR="${XDG_CACHE_HOME}/pdm"
export PDM_HOME="${XDG_DATA_HOME}/pdm"
export PDM_LOG_DIR="${XDG_STATE_HOME}/pdm/logs"
prepend_to_path "${PDM_HOME}/bin"
### PIP ========================================================================
PIP_CONFIG_FILE="${XDG_CONFIG_HOME}/pip/pip.conf"
export PIP_CACHE_DIR="${XDG_CACHE_HOME}/pip"
prepend_to_path "${PYTHONUSERBASE}/bin"
if command_exists pip; then
  if [ ! -f "${PIP_CONFIG_FILE}" ]; then
    CUSTOM_PIP_CONFIG_FILE="${CUSTOM_CONFIG_DIR}/pip/pip.conf"
    mkdir -p "${XDG_CONFIG_HOME}/pip"
    ln -s "${CUSTOM_PIP_CONFIG_FILE}" "${PIP_CONFIG_FILE}"
  fi
fi
### POETRY =====================================================================
export POETRY_CACHE_DIR="${XDG_CACHE_HOME}/poetry"
export POETRY_CONFIG_DIR="${XDG_CONFIG_HOME}/poetry"
export POETRY_HOME="${XDG_DATA_HOME}/poetry"
export POETRY_VIRTUALENVS_IN_PROJECT=1
prepend_to_path "${POETRY_HOME}/bin"
### UV =========================================================================
export UV_CACHE_DIR="${XDG_CACHE_HOME}/uv"
export UV_CONFIG_FILE="${XDG_CONFIG_HOME}/uv/uv.toml"
export UV_INSTALL_DIR="${XDG_DATA_HOME}/uv"
export UV_TOOL_DIR="${XDG_DATA_HOME}/uv/tools"
export UV_TOOL_BIN_DIR="${UV_TOOL_DIR}/bin"
prepend_to_path "${UV_TOOL_BIN_DIR}"
source_if_exists "${UV_INSTALL_DIR}/env"
if command_exists uv; then
  if [ ! -f "${UV_CONFIG_FILE}" ]; then
    CUSTOM_UV_CONFIG_FILE="${CUSTOM_CONFIG_DIR}/uv/uv.toml"
    mkdir -p "${XDG_CONFIG_HOME}/uv"
    ln -s "${CUSTOM_UV_CONFIG_FILE}" "${UV_CONFIG_FILE}"
  fi
fi
## PYTHON TOOLS ================================================================
### BLACK ======================================================================
export BLACK_CACHE_DIR="${XDG_CACHE_HOME}/black"
### IPYTHON ====================================================================
if command_exists ipython; then
  mkdir -p "${XDG_CONFIG_HOME}/ipython"
fi
### JUPYTER ====================================================================
export JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
export JUPYTER_CONFIG_FILE="$JUPYTER_CONFIG_DIR/config.py"
export JUPYTER_DATA_DIR="${XDG_DATA_HOME}/jupyter"
if command_exists jupyter; then
  if [ ! -d "${JUPYTER_DATA_DIR}/kernels" ]; then
    CUSTOM_JUPYTER_KERNELS_DIR="${CUSTOM_CONFIG_DIR}/jupyter/kernels"
    ORIG_JUPYTER_KERNELS_DIR="${JUPYTER_DATA_DIR}/kernels"
    mkdir -p "${JUPYTER_DATA_DIR}"
    ln -s "${CUSTOM_JUPYTER_KERNELS_DIR}" "${ORIG_JUPYTER_KERNELS_DIR}"
  fi
  if [ ! -f "${JUPYTER_CONFIG_FILE}" ]; then
    CUSTOM_JUPYTER_CONFIG_FILE="${CUSTOM_CONFIG_DIR}/jupyter/config.py"
    mkdir -p "${JUPYTER_CONFIG_DIR}"
    ln -s "${CUSTOM_JUPYTER_CONFIG_FILE}" "${JUPYTER_CONFIG_FILE}"
  fi
fi
### MYPY =======================================================================
export MYPY_CACHE_DIR="${XDG_CACHE_HOME}/mypy"
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
    CUSTOM_PYLINTRC="${CUSTOM_CONFIG_DIR}/pylint/pylintrc"
    mkdir -p "${XDG_CONFIG_HOME}/pylint"
    ln -s "${CUSTOM_PYLINTRC}" "${PYLINTRC}"
  fi
fi
### RUFF =======================================================================
export RUFF_CACHE_DIR="${XDG_CACHE_HOME}/ruff"
# END PYTHON DEVEL =============================================================

# R DEVEL ======================================================================
## R VERSION MANAGERS ==========================================================
### RENV =======================================================================
export RENV_ROOT="${XDG_DATA_HOME}/renv"
prepend_to_path "${RENV_ROOT}/bin"
eval_if_exists renv "init - --no-rehash bash"
if command_exists renv; then
  RENV_R_PATH="${RENV_ROOT}/versions/$(renv global)"
  # prepend_to_path "${RENV_R_PATH}/bin"
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
    CUSTOM_R_PROFILE_USER="${CUSTOM_CONFIG_DIR}/r/profile"
    mkdir -p "${XDG_CONFIG_HOME}/r/"
    ln -s "${CUSTOM_R_PROFILE_USER}" "${R_PROFILE_USER}"
  fi
fi
alias_if_exists "R" "r"
alias_if_exists "Rscript" "rscript"
### RADIAN =====================================================================
export RADIAN_CONFIG_FILE="${XDG_CONFIG_HOME}/radian/profile"
if command_exists radian; then
  if [ ! -f "${RADIAN_CONFIG_FILE}" ]; then
    CUSTOM_RADIAN_CONFIG_FILE="${CUSTOM_CONFIG_DIR}/radian/profile"
    mkdir -p "${XDG_CONFIG_HOME}/radian"
    ln -s "${CUSTOM_RADIAN_CONFIG_FILE}" "${RADIAN_CONFIG_FILE}"
  fi
fi
### RLANGSERVER ================================================================
del_if_exists "${HOME}/.vscode-R"
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
  # if [ ! -f "${RBENV_ROOT}/default-gems" ]; then
  #   CUSTOM_RBENV_DEFAULT_GEMS="${CUSTOM_CONFIG_DIR}/xxenv/rbenv/default-gems"
  #   ORIG_RBENV_DEFAULT_GEMS="${RBENV_ROOT}/default-gems"
  #   ln -s "${CUSTOM_RBENV_DEFAULT_GEMS}" "${ORIG_RBENV_DEFAULT_GEMS}"
  # fi
  RBENV_RUBY_PATH="${RBENV_ROOT}/versions/$(rbenv global)"
  # prepend_to_path "${RBENV_RUBY_PATH}/bin"
  prepend_to_manpath "${RBENV_RUBY_PATH}/share/man"
fi
### RVM ========================================================================
# prepend_to_path "${XDG_DATA_HOME}/rvm/bin"
# source_if_exists "${XDG_DATA_HOME}/rvm/scripts/rvm"
## RUBY PACKAGE MANAGERS =======================================================
### BUNDLER ====================================================================
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle/config"
export BUNDLE_USER_HOME="${XDG_DATA_HOME}/bundle"
export BUNDLE_USER_PLUGIN="${BUNDLE_USER_HOME}/plugins"
if command_exists bundle; then
  mkdir -p "${BUNDLE_USER_HOME}" "${BUNDLE_USER_CACHE}"
  if [ ! -f "${BUNDLE_USER_CONFIG}" ]; then
    CUSTOM_BUNDLE_USER_CONFIG="${CUSTOM_CONFIG_DIR}/bundle/config"
    mkdir -p "${XDG_CONFIG_HOME}/bundle"
    ln -s "${CUSTOM_BUNDLE_USER_CONFIG}" "${BUNDLE_USER_CONFIG}"
  fi
fi
## RUBY TOOLS ==================================================================
### IRB ========================================================================
export IRBRC="${XDG_CONFIG_HOME}/irb/irbrc"
if command_exists irb; then
  mkdir -p "${XDG_STATE_HOME}/irb"
  if [ ! -f "${IRBRC}" ]; then
    CUSTOM_IRBRC="${CUSTOM_CONFIG_DIR}/irb/irbrc"
    mkdir -p "${XDG_CONFIG_HOME}/irb"
    ln -s "${CUSTOM_IRBRC}" "${IRBRC}"
  fi
fi
### GEM ========================================================================
export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem/specs"
export GEMRC="${XDG_CONFIG_HOME}/gem/gemrc"
prepend_to_path "${GEM_HOME}/bin"
if command_exists gem; then
  prepend_to_path "$(gem env user_gemhome)/bin"
  if [ ! -f "${GEMRC}" ]; then
    CUSTOM_GEMRC="${CUSTOM_CONFIG_DIR}/gem/gemrc"
    mkdir -p "${XDG_CONFIG_HOME}/gem"
    ln -s "${CUSTOM_GEMRC}" "${GEMRC}"
  fi
fi
### PRY ========================================================================
export PRYRC="${XDG_CONFIG_HOME}/pry/pryrc"
if command_exists pry; then
  if [ ! -f "${PRYRC}" ]; then
    CUSTOM_PRYRC="${CUSTOM_CONFIG_DIR}/pry/pryrc"
    mkdir -p "${XDG_CONFIG_HOME}/pry"
    ln -s "${CUSTOM_PRYRC}" "${PRYRC}"
  fi
fi
### RUBOCOP =======================================================================
export RUBOCOP_CACHE_ROOT="${XDG_CACHE_HOME}/rubocop"
### RUBY =======================================================================
### SOLARGRAPH =================================================================
export SOLARGRAPH_CACHE="${XDG_CACHE_HOME}/solargraph"
### TRAVIS =====================================================================
export TRAVIS_CONFIG_PATH="${XDG_CONFIG_HOME}/travis"
# END RUBY DEVEL ===============================================================

# RUST DEVEL ===================================================================
## RUST TOOLS =======================================================
### CARGO ======================================================================
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
source_if_exists "${CARGO_HOME}/env"
### RUSTUP =====================================================================
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
if command_exists rustup; then
  RUSTC_TOOLCHAIN="$(rustup show active-toolchain | awk '{print $1}')"
  RUSTUP_RUSTC_PATH="${RUSTUP_HOME}/toolchains/${RUSTC_TOOLCHAIN}"
  prepend_to_manpath "${RUSTUP_RUSTC_PATH}/share/man"
fi
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
append_to_path "${SWIFTLY_BIN_DIR}"
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

# TERRAFORM DEVEL ==============================================================
## TERRAFORM VERSION MANAGERS ==================================================
### TENV =======================================================================
export TENV_ROOT="${XDG_DATA_HOME}/tenv"
### TFENV ======================================================================
export TFENV_ROOT="${XDG_DATA_HOME}/tfenv"
prepend_to_path "${TFENV_ROOT}/bin"
eval_if_exists tfenv "init -"
### TGENV ======================================================================
export TGENV_ROOT="${XDG_DATA_HOME}/tgenv"
prepend_to_path "${TGENV_ROOT}/bin"
### TOFUENV ====================================================================
export TOFUENV_ROOT="${XDG_DATA_HOME}/tofuenv"
prepend_to_path "${TOFUENV_ROOT}/bin"
eval_if_exists tofuenv "init -"
## TERRAFORM TOOLS =============================================================
### TERRAFORM ==================================================================
export TF_CLI_CONFIG_FILE="${XDG_CONFIG_HOME}/terraform/terraformrc"
export TF_LOG_PATH="${XDG_STATE_HOME}/terraform/terraform.log"
export TF_PLUGIN_CACHE_DIR="${XDG_CACHE_HOME}/terraform/plugins"
if command_exists terraform; then
  mkdir -p "${XDG_STATE_HOME}/terraform"
  mkdir -p "${TF_PLUGIN_CACHE_DIR}"
  if [ ! -f "${TF_CLI_CONFIG_FILE}" ]; then
    CUSTOM_TF_CLI_CONFIG_FILE="${CUSTOM_CONFIG_DIR}/terraform/terraformrc"
    mkdir -p "${XDG_CONFIG_HOME}/terraform"
    ln -s "${CUSTOM_TF_CLI_CONFIG_FILE}" "${TF_CLI_CONFIG_FILE}"
  fi
fi
# END TERRAFORM DEVEL ==========================================================

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
prepend_to_path "${MODULAR_HOME}/bin"
# ODIN =========================================================================
export ODIN_ROOT="${XDG_DATA_HOME}/odin"
prepend_to_path "${ODIN_ROOT}"
# OCTAVE =======================================================================
export OCTAVE_HISTFILE="${XDG_STATE_HOME}/octave/history"
export OCTAVE_SITE_INITFILE="${XDG_CONFIG_HOME}/octave/octaverc"
if command_exists octave; then
  if [ ! -f "${OCTAVE_SITE_INITFILE}" ]; then
    CUSTOM_OCTAVE_SITE_INITFILE="${CUSTOM_CONFIG_DIR}/octave/octaverc"
    mkdir -p "${XDG_CONFIG_HOME}/octave"
    ln -s "${CUSTOM_OCTAVE_SITE_INITFILE}" "${OCTAVE_SITE_INITFILE}"
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

# DEBUGGER =====================================================================
# GDB ==========================================================================
export GDBHISTFILE="${XDG_STATE_HOME}/gdb/history"
# END DEBUGGER =================================================================

# VERSION CONTROL ==============================================================
# FOSSIL =======================================================================
export FOSSIL_HOME="${XDG_DATA_HOME}/fossil"
# GIT ==========================================================================
GIT_CONFIG="${XDG_CONFIG_HOME}/git/config" # ElixirLs does not work when exporting GIT_CONFIG
if command_exists git; then
  if [ ! -f "${GIT_CONFIG}" ]; then
    CUSTOM_GIT_CONFIG="${CUSTOM_CONFIG_DIR}/git/config"
    mkdir -p "${XDG_CONFIG_HOME}/git"
    ln -s "${CUSTOM_GIT_CONFIG}" "${GIT_CONFIG}"
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
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/config"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy-cache"
# ARDUINO ======================================================================
export ARDUINO_DIRECTORIES_DATA="${XDG_DATA_HOME}/arduino"
export ARDUINO_CONFIG_FILE="${XDG_CONFIG_HOME}/arduino/arduino-cli.yaml"
# AWS ==========================================================================
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
# AZURE ========================================================================
export AZURE_CONFIG_DIR="${XDG_DATA_HOME}/azure"
# BITWARDEN ====================================================================
export BITWARDENCLI_APPDATA_DIR="${XDG_DATA_HOME}/bitwarden"
# CALC =========================================================================
export CALCHISTFILE="${XDG_STATE_HOME}/calc/history"
if command_exists calc; then
  mkdir -p "${XDG_STATE_HOME}/calc"
fi
# CCACHE =======================================================================
export CCACHE_DIR="${XDG_CACHE_HOME}/ccache"
export CCACHE_CONFIGPATH="${XDG_CONFIG_HOME}/ccache/ccache.conf"
if command_exists ccache; then
  if [ ! -f "${CCACHE_CONFIGPATH}" ]; then
    CUSTOM_CCACHE_CONFIG="${CUSTOM_CONFIG_DIR}/ccache/ccache.conf"
    mkdir -p "${XDG_CONFIG_HOME}/ccache"
    ln -s "${CUSTOM_CCACHE_CONFIG}" "${CCACHE_CONFIGPATH}"
  fi
fi
# CHEAT.SH =====================================================================
export CHTSH="${XDG_DATA_HOME}/cht.sh"
export CHTSH_CONFIG="${XDG_CONFIG_HOME}/cht.sh/config"
# DIRENV =======================================================================
eval_if_exists direnv "hook bash"
# DOCKER =======================================================================
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
# DUST =========================================================================
# alias_if_exists "dust" "du"
# FOUNDRY ======================================================================
export FOUNDRY_DIR="${XDG_DATA_HOME}/foundry"
prepend_to_path "${FOUNDRY_DIR}/bin"
# GENOZIP ======================================================================
export GENOZIP_HOME="${XDG_DATA_HOME}/genozip"
if command_exists genozip; then
  if [ ! -d "${GENOZIP_HOME}" ]; then
    ln -s "${CUSTOM_CONFIG_DIR}/genozip" "${GENOZIP_HOME}"
  fi
fi
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
# JFROG =======================================================================
export JFROG_CLI_HOME_DIR="${XDG_DATA_HOME}/jfrog"
# KUBERNETES ===================================================================
export KUBECONFIG="${XDG_CONFIG_HOME}/kube"
export KUBECACHEDIR="${XDG_CACHE_HOME}/kube"
# LESS =========================================================================
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
export LESSHISTSIZE=1000
# LSD ==========================================================================
alias_if_exists "lsd -A" "ls"
# RIPGREP ======================================================================
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/ripgreprc"
if command_exists rg; then
  if [ ! -f "${RIPGREP_CONFIG_PATH}" ]; then
    CUSTOM_RIPGREP_CONFIG="${CUSTOM_CONFIG_DIR}/ripgrep/ripgreprc"
    mkdir -p "${XDG_CONFIG_HOME}/ripgrep"
    ln -s "${CUSTOM_RIPGREP_CONFIG}" "${RIPGREP_CONFIG_PATH}"
  fi
fi
# SDCV =========================================================================
export SDCV_HISTFILE="${XDG_STATE_HOME}/sdcv/history"
export STARDICT_DATA_DIR="${XDG_DATA_HOME}/stardict"
# STARSHIP =====================================================================
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/starship.toml"
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
    CUSTOM_TEALDEER_CONFIG_DIR="${CUSTOM_CONFIG_DIR}/tealdeer"
    ln -s "${CUSTOM_TEALDEER_CONFIG_DIR}" "${TEALDEER_CONFIG_DIR}"
  fi
fi
# VAGRANT ======================================================================
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_CONFIG_HOME}/vagrant/aliases"
# W3M ==========================================================================
export W3M_DIR="${XDG_STATE_HOME}/w3m"
# WGET =========================================================================
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
if command_exists wget; then
  if [ ! -f "$WGETRC" ]; then
    CUSTOM_WGETRC="${CUSTOM_CONFIG_DIR}/wget/wgetrc"
    mkdir -p "${XDG_CONFIG_HOME}/wget"
    ln -s "${CUSTOM_WGETRC}" "$WGETRC"
  fi
fi
# XORG =========================================================================
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
export XSERVERRC="${XDG_CONFIG_HOME}/X11/xserverrc"

# CUSTOMIZATION ================================================================
# CUSTOM LIMITS
if [ "${SHELL}" = "/bin/bash" ]; then
  ulimit -n 104857
fi
# BLE-SH =======================================================================
source "${XDG_DATA_HOME}/blesh/ble.sh" # needs to be sourced directly
# OH MY POSH ===================================================================
export CUSTOM_POSHTHEME="${CUSTOM_CONFIG_DIR}/oh-my-posh/clean-detailed.omp.json"
eval_if_exists oh-my-posh "init bash --config ${CUSTOM_POSHTHEME}"
# USE WINDOWS BROWSER IN WSL ===================================================
if grep -q WSL /proc/version; then
  export BROWSER="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe %s"
fi
# END CUSTOMIZATION ============================================================

# ZOXIDE =======================================================================
export _ZO_DOCTOR=0
export _ZO_ECHO=1
eval_if_exists zoxide "init bash --cmd cd"
# alias_if_exists "z" "cd"
# END UTILITIES ================================================================

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
