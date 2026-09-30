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

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# LM Studio
add_to_path "$HOME/.lmstudio/bin"

eval "$(mise activate zsh)"
