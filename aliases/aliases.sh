#!/usr/bin/env bash

# aliases
alias x="nano $(dirname "${BASH_SOURCE[0]}")/../commands/custom-commands.sh"
alias a="nano ${XDG_CONFIG_HOME}/bash/bashrc"

alias vmp="nano $(dirname "${BASH_SOURCE[0]}")/../scripts/02_dotfiles.sh"
alias vpm="nano $(dirname "${BASH_SOURCE[0]}")/../commands/version-manager.sh"
alias vmp-code="code $(dirname "${BASH_SOURCE[0]}")/.."

alias lmp-erlang="nano $(dirname "${BASH_SOURCE[0]}")/../build-opts/01_ERLANG_BUILD"
alias lmp-node="nano $(dirname "${BASH_SOURCE[0]}")/../build-opts/01_NODE_BUILD"
alias lmp-octave="nano $(dirname "${BASH_SOURCE[0]}")/../build-opts/01_OCTAVE_BUILD"
alias lmp-perl="nano $(dirname "${BASH_SOURCE[0]}")/../build-opts/01_PERL_BUILD"
alias lmp-php="nano $(dirname "${BASH_SOURCE[0]}")/../build-opts/01_PHP_BUILD"
alias lmp-python="nano $(dirname "${BASH_SOURCE[0]}")/../build-opts/01_PYTHON_BUILD"
alias lmp-r="nano $(dirname "${BASH_SOURCE[0]}")/../build-opts/01_R_BUILD"
alias lmp-ruby="nano $(dirname "${BASH_SOURCE[0]}")/../build-opts/01_RUBY_BUILD"

alias csc="dotnet /usr/share/dotnet/sdk/8.0.204/Roslyn/bincore/csc.dll"
alias fsc="dotnet /usr/share/dotnet/sdk/8.0.204/FSharp/fsc.dll"
alias vbc="dotnet /usr/share/dotnet/sdk/8.0.204/Roslyn/bincore/vbc.dll"
alias treeg="tree --gitignore -a --dirsfirst"

alias erlenv=erlxenv
