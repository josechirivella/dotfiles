# WSL-specific PATH additions
add_to_path "/usr/local/go/bin"
add_to_path "$GOPATH/bin"
add_to_path "$HOME/.rbenv/bin"

function startServices() {
  services=("mysql" "redis-server" "nginx")
  for service in "${services[@]}"; do
    sudo service $service start
  done
}

# pnpm
export PNPM_HOME="/home/jchirivella/.local/share/pnpm"
add_to_path "$PNPM_HOME"

eval "$(mise activate zsh)"
