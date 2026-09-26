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

# Lazy load Angular CLI autocompletion for faster startup
ng() {
  if ! command -v ng &>/dev/null; then
    echo "Angular CLI not found"
    return 1
  fi

  # Load completions on first use
  if [[ -z "$_NG_COMPLETION_LOADED" ]]; then
    source <(command ng completion script)
    export _NG_COMPLETION_LOADED=1
  fi

  command ng "$@"
}

# bun - only configure if installed
if [[ -d "$HOME/.bun" ]] || command -v bun &>/dev/null; then
  # bun completions
  [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

  # bun
  export BUN_INSTALL="$HOME/.bun"
  add_to_path "$BUN_INSTALL/bin"
fi
export COREPACK_ENABLE_AUTO_PIN=0

# Deduplicate PATH at the end of configuration loading
dedupe_path

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jchirivella/.lmstudio/bin"
# End of LM Studio CLI section


# pnpm
export PNPM_HOME="/Users/jchirivella/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
