# always execute this commands even if the file is sourced already
if [ -n "${DOTFILES_SH_ALREADY_SOURCED}" ]; then
  source "${XDG_DATA_HOME}/blesh/ble.sh" # needs to be loaded first

  eval_if_exists conda "shell.bash hook"
  eval_if_exists oh-my-posh "init bash --config ${CUSTOM_POSHTHEME}"
  eval_if_exists direnv "hook bash"
  eval_if_exists mise "activate bash"
  eval_if_exists goenv "init - --no-rehash bash"
  eval_if_exists nodenv "init - --no-rehash bash"
  eval_if_exists phpenv "init - --no-rehash bash"
  eval_if_exists plenv "init - bash"
  eval_if_exists pyenv "init - --no-rehash bash"
  eval_if_exists rakubrew "init Bash"
  eval_if_exists rbenv "init - --no-rehash bash"
  eval_if_exists renv "init - --no-rehash bash"
  eval_if_exists zoxide "init bash --cmd cd"

  # alias_if_exists "dust" "du"
  alias_if_exists "R" "r"
  alias_if_exists "reply --cfg ${XDG_CONFIG_HOME}/reply/replyrc" "reply"
  alias_if_exists "Rscript" "rscript"
  alias_if_exists "scilab-cli -scihome ${SCIHOME}" "scilab"
  alias_if_exists "scilab-cli -scihome ${SCIHOME}" "scilab-cli"
  alias_if_exists "svn --config-dir ${XDG_CONFIG_HOME}/subversion" "svn"
  alias_if_exists "lsd -A" "ls"
  alias_if_exists "z" "cd"

  source_if_exists "${EVM_HOME}/scripts/evm"
  source_if_exists "${SDKMAN_DIR}/bin/sdkman-init.sh"
  source_if_exists "${OPAMROOT}/opam-init/init.sh"

  del_if_exists "${HOME}/.bloop"
  # do not delete when using dart in vscode
  # del_if_exists "${HOME}/.dart-tool"
  del_if_exists "${HOME}/.dotnet"
  del_if_exists "${HOME}/.ghc"
  del_if_exists "${HOME}/.g8"
  del_if_exists "${HOME}/.metals"
  del_if_exists "${HOME}/.ServiceHub"
  del_if_exists "${HOME}/.sourcekit-lsp"
  del_if_exists "${HOME}/.java"
  del_if_exists "${HOME}/.julia"
  del_if_exists "${HOME}/.vscode-R"
fi

export DOTFILES_SH_ALREADY_SOURCED=1
