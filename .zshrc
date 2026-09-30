export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
source $ZSH/oh-my-zsh.sh
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_DISABLE_COMPFIX=true

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
fi

plugins=(git colorize github brew osx ruby rbenv rails git-flow tmux docker docker-compose ssh-agent zsh_reload encode64 git npm rsync systemd ufw asdf)
. ~/MyTerminalConfig/env/env.sh
. ~/MyTerminalConfig/env/alias.sh

if [[ $DESKTOP_SESSION == "xfce" ]]; then
  . ~/MyTerminalConfig/env/manjaro.sh
fi

if [[ $DESKTOP_SESSION == "ubuntu" ]]; then
  . ~/MyTerminalConfig/env/ubuntu.sh
fi

if [[ $(uname) == "Darwin" ]]; then
  . ~/MyTerminalConfig/env/osx.sh
fi

if [[ $(uname) == "Linux" ]]; then
  . ~/MyTerminalConfig/env/wsl.sh
fi

DEFAULT_USER=$USER
# neofetch

# Deduplicate PATH at the end of configuration loading
dedupe_path
