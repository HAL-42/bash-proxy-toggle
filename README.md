# bash-proxy-toggle

A tiny Bash helper that provides a `proxy` function for toggling local HTTP/HTTPS/SOCKS5 proxy environment variables.

It uses `127.0.0.1:7890` by default and mirrors the interface of [`fish-proxy-toggle`](https://github.com/HAL-42/fish-proxy-toggle).

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/HAL-42/bash-proxy-toggle/main/install.sh | bash
```

After installing, open a new Bash session or source your Bash startup file:

```bash
source ~/.bashrc
```

## Usage

Enable proxy on the default port `7890`:

```bash
proxy
```

Enable proxy on a custom port:

```bash
proxy 7897
```

Disable proxy:

```bash
proxy off
```

## Behavior

`proxy` sets:

```bash
http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
all_proxy=socks5://127.0.0.1:7890
no_proxy=localhost,127.0.0.1,::1,.local,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,fc00::/7,.xiaojukeji.com,.didistatic.com,.didichuxing.com,.yunxuetang.cn
```

`proxy off` unsets:

```bash
http_proxy
https_proxy
all_proxy
no_proxy
```

## Files

```text
proxy.bash    # proxy function and completion
install.sh    # curl | bash installer
publish.sh    # GitHub publishing helper
```
