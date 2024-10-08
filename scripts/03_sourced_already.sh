# always execute this commands even if the file is sourced already
if [ -n "${DOTFILES_SH_ALREADY_SOURCED}" ]; then
  eval_if_exists oh-my-posh "init bash --config ${POSHTHEMES}/night-owl.omp.json"
  eval_if_exists zoxide "init bash"

  alias_if_exists "dust" "du"
  alias_if_exists "R" "r"
  alias_if_exists "reply --cfg ${XDG_CONFIG_HOME}/reply/replyrc" "reply"
  alias_if_exists "Rscript" "rscript"
  alias_if_exists "scilab-cli -scihome ${SCIHOME}" "scilab"
  alias_if_exists "scilab-cli -scihome ${SCIHOME}" "scilab-cli"
  alias_if_exists "svn --config-dir ${XDG_CONFIG_HOME}/subversion" "svn"
  alias_if_exists "lsd -A" "ls"
  alias_if_exists "z" "cd"

  del_if_exists "${HOME}/.bloop"
  del_if_exists "${HOME}/.dart-tool"
  del_if_exists "${HOME}/.dotnet"
  del_if_exists "${HOME}/.metals"
  del_if_exists "${HOME}/.sourcekit-lsp"
  del_if_exists "${HOME}/.ServiceHub"
  del_if_exists "${HOME}/.julia"
  del_if_exists "${HOME}/.vscode-R"

  unset DOTFILES_SH_ALREADY_SOURCED
fi
