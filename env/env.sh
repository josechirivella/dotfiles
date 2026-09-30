#!/bin/zsh

# PATH Management Utilities
dedupe_path() {
  local path_var="${1:-PATH}"
  local current_path
  eval "current_path=\$$path_var"
  local new_path=""
  local IFS=':'

  for dir in $current_path; do
    if [[ ":$new_path:" != *":$dir:"* ]] && [[ -n "$dir" ]]; then
      if [[ -z "$new_path" ]]; then
        new_path="$dir"
      else
        new_path="$new_path:$dir"
      fi
    fi
  done

  eval "export $path_var=\"$new_path\""
}

add_to_path() {
  local new_dir="$1"
  local path_var="${2:-PATH}"

  local current_path
  eval "current_path=\$$path_var"

  if [[ -d "$new_dir" ]] && [[ ":$current_path:" != *":$new_dir:"* ]]; then
    eval "export $path_var=\"$new_dir:$current_path\""
  fi
}

# Initial PATH setup
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin:$HOME/MyTerminalConfig/bin:/usr/local/opt:$PATH"

# Node Version Manager
if [ -d "$HOME/n" ]; then
  export N_PREFIX="$HOME/n"
  [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin" # Added by n-install (see http://git.io/n-install-repo).
elif [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" #bash_completion
elif [ -d "$HOME/.asdf" ]; then
  # append completions to fpath
  fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
  # initialise completions with ZSH's compinit
  autoload -Uz compinit && compinit
elif [ -d "$HOME/.local/share/mise" ]; then
  eval "$(mise activate zsh)"
else
  echo 'No Node Version Manager has been installed'
fi

# Java
install_java() {
  if [ command java ] &>/dev/null; then
    export JAVA_HOME="$(/usr/libexec/java_home -v 10)"
  fi
}

# Virtual Environment
export PROJECT_HOME=$HOME/MyTerminalConfig/

# Editor
export EDITOR='vim'

# Owner
export USER_NAME=$USER

function clonepersonal() {
  git clone git@github.com:josechirivella/$1
}

function clonefrustrated() {
  git clone git@github.com:frustrateddeveloper/$1
}

function convertImagesToWebp() {
  echo 'Converting all .png, .jpg, and .jpeg files to .webp...'
  for f in $(find . -name '*.png' -or -name '*.jpg' -or -name '*.jpeg'); do
    if [ ! -f "${f%.*}.webp" ]; then
      cwebp -q 60 $f -o ${f%.*}.webp
    fi
  done
}

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME'/google-cloud-sdk/path.zsh.inc' ]; then . $HOME'/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME'/google-cloud-sdk/completion.zsh.inc' ]; then . $HOME'/google-cloud-sdk/completion.zsh.inc'; fi
alias changegcloud="gcloud config configurations activate"

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

# opencode
if [ -d "$HOME/.opencode" ]; then
  add_to_path "$HOME/.opencode/bin"
fi

install_java
