# The Galalem Containers Library

Popular applications, provided by Galalem, containerized and ready to launch.

## Supported tags

### `galalem/laravel`

| PHP  | Debian (default) | Alpine              | Aliases                              |
| ---- | ---------------- | ------------------- | ------------------------------------ |
| 8.4  | `8.4-fpm`, `8.4` | `8.4-fpm-alpine`    | `latest`, `fpm`, `fpm-alpine`        |
| 8.3  | `8.3-fpm`, `8.3` | `8.3-fpm-alpine`    |                                      |
| 8.2  | `8.2-fpm`, `8.2` | `8.2-fpm-alpine`    |                                      |

Every variant ships `pdo_mysql`, `pdo_pgsql`, `mbstring`, `exif`, `pcntl`, `bcmath`, `gd`, `zip`, `opcache`, and bundles nginx.

### `galalem/nginx`

| Nginx | Base   | Tags                                     |
| ----- | ------ | ---------------------------------------- |
| 1.27  | Alpine | `1.27-alpine`, `1.27`, `latest`, `alpine` |

## Tag policy

- `<version>-<variant>` tags are stable — the digest may change (rebuilds pick up base-image CVEs), the meaning does not. Safe to pin.
- `<version>` aliases point at that version's default variant.
- `latest` follows the newest supported version's default variant. Expect it to jump majors.
- EOL versions stop being rebuilt but existing tags stay on the registry.

## Adding a version or variant

1. Add a `Dockerfile` under `galalem/<image>/<version>/<variant>/`.
2. Register it in `galalem/<image>/versions.json`.
3. That's it — the workflow reads `versions.json` and builds the matrix.

Set `"latest": true` on exactly one version per image to control which one owns the floating aliases.
