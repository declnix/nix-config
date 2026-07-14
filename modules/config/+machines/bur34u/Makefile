files := \
	/etc/environment.d/90-proxy.conf \
	/etc/gitconfig.d/proxy.conf

.PHONY: all $(files)
all: $(files)

/etc/environment.d/90-proxy.conf: modules/proxy/90-proxy.conf.in
	@tmp="$$(mktemp)"; \
	trap 'rm -f "$$tmp"' EXIT; \
	http_proxy="$${http_proxy:-$${HTTP_PROXY:-}}" \
	https_proxy="$${https_proxy:-$${HTTPS_PROXY:-$${http_proxy:-$${HTTP_PROXY:-}}}}" \
	all_proxy="$${all_proxy:-$${ALL_PROXY:-}}" \
	no_proxy="$${no_proxy:-$${NO_PROXY:-}}" \
	HTTP_PROXY="$${HTTP_PROXY:-$${http_proxy:-}}" \
	HTTPS_PROXY="$${HTTPS_PROXY:-$${https_proxy:-$${http_proxy:-}}}" \
	ALL_PROXY="$${ALL_PROXY:-$${all_proxy:-}}" \
	NO_PROXY="$${NO_PROXY:-$${no_proxy:-}}" \
	envsubst < "$<" > "$$tmp"; \
	sudo install -D -m 0644 "$$tmp" "$@"

/etc/gitconfig.d/proxy.conf: modules/proxy/gitconfig.conf.in
	@tmp="$$(mktemp)"; \
	trap 'rm -f "$$tmp"' EXIT; \
	git_proxy="$${https_proxy:-$${HTTPS_PROXY:-$${http_proxy:-$${HTTP_PROXY:-}}}}"; \
	if [ -n "$$git_proxy" ]; then \
		git_proxy="$$git_proxy" envsubst < "$<" > "$$tmp"; \
	else \
		: > "$$tmp"; \
	fi; \
	sudo install -D -m 0644 "$$tmp" "$@"
