# podman-demos

## Examples

```
podman build --build-arg PARAM_APP_NAME=boz-ui -t eagle/angular angular
```

```
podman build -t eagle/runner ansible
```

```
podman build -t eagle/sops sops
```

```
podman build \
  --build-arg PARAM_APP_NAME=zimcore \
  --build-arg PARAM_PRIMARY_DOMAIN=bigfleet.dev \
  --build-arg PARAM_SPRINGBOOT_VERSION=2.6.1 \
  -t eagle/springboot-api springboot-api
```