# macOS-specific PATH additions
add_to_path "/opt/homebrew/bin"
add_to_path "/opt/homebrew/sbin"
add_to_path "/usr/local/sbin"
add_to_path "/opt/homebrew/opt/postgresql@18/bin"
add_to_path "/opt/homebrew/opt/openjdk/bin"
export RUBY_YJIT_ENABLE=1
export GOPATH="$HOME/repos/go"
alias fixappstore="rm -r '$TMPDIR/../C/com.apple.appstore/'* && killall -9 appstoreagent"

# direnv - only configure if installed
if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
fi

restartBrewServices() {
  for service in $(brew services list --json | jq '.[].name' | tr -d '"'); do
    brew services restart $service
  done
}

toggleTimeMachineResources() {
  if [ "$(sysctl debug.lowpri_throttle_enabled | awk '{print $NF}')" -eq 1 ]; then
    sudo sysctl debug.lowpri_throttle_enabled=0
  else
    sudo sysctl debug.lowpri_throttle_enabled=1
  fi
}

# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
HOMEBREW_GCLOUD="/opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk"
if [ -f $HOMEBREW_GCLOUD'/path.zsh.inc' ]; then . $HOMEBREW_GCLOUD'/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOMEBREW_GCLOUD'/completion.zsh.inc' ]; then . $HOMEBREW_GCLOUD'/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME/bin:"*) ;;
*) add_to_path "$PNPM_HOME/bin" ;;
esac
# pnpm end

# LM Studio
if [ -d "$HOME/.lmstudio" ]; then
  add_to_path "$HOME/.lmstudio/bin"
fi

# flutter
if [ -d "$HOME/.config/flutter" ]; then
  add_to_path "$HOME/.config/flutter/bin"
fi
