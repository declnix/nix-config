## Proxy

Proxy settings are read from `/etc/proxy.env` — evaluated at boot by a systemd service into `/run/nix-proxy.env`. Both the nix daemon and zsh source this generated file. If `/etc/proxy.env` does not exist, proxy is not configured.

Example `/etc/proxy.env`:
```sh
GATEWAY=$(ip route show default | awk '{print $3}')
http_proxy="http://${GATEWAY}:<port>"
https_proxy="http://${GATEWAY}:<port>"
no_proxy="localhost,127.0.0.1,<internal-domain>"
```
