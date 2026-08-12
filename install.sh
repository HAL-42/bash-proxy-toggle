#!/usr/bin/env bash
set -euo pipefail

repo="HAL-42/bash-proxy-toggle"
branch="${BASH_PROXY_TOGGLE_BRANCH:-main}"
source_url="${BASH_PROXY_TOGGLE_PROXY_URL:-https://raw.githubusercontent.com/${repo}/${branch}/proxy.bash}"
install_dir="${XDG_DATA_HOME:-$HOME/.local/share}/bash-proxy-toggle"
install_file="${install_dir}/proxy.bash"

start_marker="# >>> bash-proxy-toggle >>>"
end_marker="# <<< bash-proxy-toggle <<<"

download() {
  local url="$1"
  local output="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$output"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$output" "$url"
  else
    echo "curl or wget is required to install bash-proxy-toggle." >&2
    exit 1
  fi
}

write_startup_block() {
  local file="$1"
  local tmp

  mkdir -p "$(dirname "$file")"
  touch "$file"
  tmp="$(mktemp)"

  awk -v start="$start_marker" -v end="$end_marker" '
    $0 == start { skipping = 1; next }
    $0 == end { skipping = 0; next }
    skipping != 1 { print }
  ' "$file" > "$tmp"

  {
    cat "$tmp"
    printf '\n%s\n' "$start_marker"
    printf 'if [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/bash-proxy-toggle/proxy.bash" ]; then\n'
    printf '  . "${XDG_DATA_HOME:-$HOME/.local/share}/bash-proxy-toggle/proxy.bash"\n'
    printf 'fi\n'
    printf '%s\n' "$end_marker"
  } > "$file"

  rm -f "$tmp"
}

main() {
  mkdir -p "$install_dir"
  download "$source_url" "$install_file"

  write_startup_block "$HOME/.bashrc"

  echo "bash-proxy-toggle installed."
  echo "Open a new Bash session, or run:"
  echo "  source ~/.bashrc"
}

main "$@"
