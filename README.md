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

`proxy` exports the following values in both lowercase and uppercase (`HTTP_PROXY`, `HTTPS_PROXY`, `ALL_PROXY`, and `NO_PROXY`).

```bash
http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
all_proxy=socks5://127.0.0.1:7890
no_proxy=localhost,127.0.0.1,::1,.local,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,fc00::/7,.xiaojukeji.com,.didistatic.com,.didichuxing.com,.yunxuetang.cn
```

`proxy off` unsets all eight variables in the current shell.

## Files

```text
proxy.bash    # proxy function and completion
install.sh    # curl | bash installer
publish.sh    # GitHub publishing helper
```
