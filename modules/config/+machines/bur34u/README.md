## Proxy

Proxy settings are read from these host-local files:

`/etc/environment.d/90-proxy.conf`
`/etc/gitconfig.d/proxy.conf`
`/etc/xdg/glab-cli/config.yml`

Install them from the current shell environment:

```sh
nix run .#write-runtime-files
```

Expected variables:

```sh
http_proxy=...
https_proxy=...
all_proxy=...
no_proxy=...
HTTP_PROXY=...
HTTPS_PROXY=...
ALL_PROXY=...
NO_PROXY=...
git_proxy=...
GITLAB_HOST=gitlab.example.com
```

For testing from another host:

```sh
DEPLOY_HOST=bur34u nix run .#write-runtime-files
```
