# bash-proxy-toggle
# shellcheck shell=bash

unalias proxy 2>/dev/null || true

proxy() {
  if [ "${1:-}" = "off" ]; then
    unset http_proxy HTTP_PROXY
    unset https_proxy HTTPS_PROXY
    unset all_proxy ALL_PROXY
    unset no_proxy NO_PROXY
    case "$-" in
      *i*) echo "Proxy disabled" ;;
    esac
    return
  fi

  local port="${1:-7890}"

  export http_proxy="http://127.0.0.1:${port}"
  export https_proxy="http://127.0.0.1:${port}"
  export all_proxy="socks5://127.0.0.1:${port}"
  export no_proxy="localhost,127.0.0.1,::1,.local,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,fc00::/7,.xiaojukeji.com,.didistatic.com,.didichuxing.com,.yunxuetang.cn"
  export HTTP_PROXY="$http_proxy"
  export HTTPS_PROXY="$https_proxy"
  export ALL_PROXY="$all_proxy"
  export NO_PROXY="$no_proxy"
  case "$-" in
    *i*) echo "Proxy enabled on port ${port}" ;;
  esac
}

if [ -n "${BASH_VERSION:-}" ]; then
  complete -W "off 7890" proxy 2>/dev/null || true
fi
