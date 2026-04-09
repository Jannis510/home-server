# Security Exceptions – Trivy

This document tracks accepted/ignored Trivy findings where no upstream fix is available yet.
Exceptions are reviewed on new upstream releases.

## Pending upstream image rebuilds

The following CVEs are fixed upstream but not yet included in the affected container images.

### CVE-2025-15467 — OpenSSL RCE/DoS via oversized IV (CRITICAL)
- **Affected image:** `tecnativa/docker-socket-proxy:v0.4.2`
- **Component:** `libcrypto3`, `libssl3` 3.5.1-r0
- **Fix available in:** openssl 3.5.5-r0
- **Rationale:** Awaiting docker-socket-proxy rebuild with updated Alpine 3.22 base layer.

Review trigger: New docker-socket-proxy release based on Alpine 3.22 with openssl >= 3.5.5-r0.

### CVE-2025-58050 — PCRE2 heap-buffer-overflow (CRITICAL)
- **Affected image:** `tecnativa/docker-socket-proxy:v0.4.2`
- **Component:** `pcre2` 10.43-r1
- **Fix available in:** pcre2 10.46-r0
- **Rationale:** Awaiting docker-socket-proxy rebuild with updated Alpine 3.22 base layer.

Review trigger: New docker-socket-proxy release based on Alpine 3.22 with pcre2 >= 10.46-r0.

### CVE-2025-69419 — OpenSSL arbitrary code execution via PKCS#12 (HIGH)
- **Affected image:** `tecnativa/docker-socket-proxy:v0.4.2`
- **Component:** `libcrypto3`, `libssl3` 3.5.1-r0
- **Fix available in:** openssl 3.5.5-r0
- **Rationale:** Awaiting docker-socket-proxy rebuild with updated Alpine 3.22 base layer.

Review trigger: New docker-socket-proxy release based on Alpine 3.22 with openssl >= 3.5.5-r0.

### CVE-2025-69421 — OpenSSL DoS via malformed PKCS#12 (HIGH)
- **Affected image:** `tecnativa/docker-socket-proxy:v0.4.2`
- **Component:** `libcrypto3`, `libssl3` 3.5.1-r0
- **Fix available in:** openssl 3.5.5-r0
- **Rationale:** Awaiting docker-socket-proxy rebuild with updated Alpine 3.22 base layer.

Review trigger: New docker-socket-proxy release based on Alpine 3.22 with openssl >= 3.5.5-r0.

### CVE-2026-22184 — zlib buffer overflow (HIGH)
- **Affected images:** `pihole/pihole:2026.04.0`, `traefik:v3.6.13`, `alpine:3.23.3` (stepca-export), `nicolargo/glances:4.5.3.2`, `ghcr.io/gethomepage/homepage:v1.12.3`
- **Component:** `zlib` 1.3.1-r2
- **Fix available in:** zlib 1.3.2-r0
- **Rationale:** Awaiting image rebuilds with updated Alpine base layer.

Review trigger: New pihole or traefik releases based on Alpine with zlib >= 1.3.2-r0.

### CVE-2025-59343 — tar-fs symlink validation bypass (HIGH)

- **Affected image:** `ghcr.io/gethomepage/homepage:v1.12.3`
- **Component:** `tar-fs` 2.1.3
- **Fix available in:** tar-fs 2.1.4
- **Rationale:** Awaiting homepage release with updated tar-fs dependency.

Review trigger: New homepage release built with tar-fs >= 2.1.4.

### CVE-2026-26318 — systeminformation arbitrary code execution via locate (HIGH)
- **Affected image:** `ghcr.io/gethomepage/homepage:v1.12.3`
- **Component:** `systeminformation` 5.30.8
- **Fix available in:** systeminformation 5.31.0
- **Rationale:** Awaiting homepage release with updated systeminformation dependency.

Review trigger: New homepage release built with systeminformation >= 5.31.0.

### CVE-2026-0994 — protobuf DoS via recursion depth bypass (HIGH)
- **Affected image:** `ghcr.io/c4illin/convertx:v0.17.0` (Python package)
- **Component:** `protobuf` 6.33.4
- **Fix available in:** protobuf 6.33.5
- **Rationale:** Awaiting bentopdf release with updated protobuf dependency.

Review trigger: New bentopdf release built with protobuf >= 6.33.5.

### CVE-2026-25990 — Pillow out-of-bounds write via PSD image (HIGH)
- **Affected image:** `ghcr.io/c4illin/convertx:v0.17.0` (Python package)
- **Component:** `pillow` 12.1.0
- **Fix available in:** pillow 12.1.1
- **Rationale:** Awaiting bentopdf release with updated pillow dependency.

Review trigger: New bentopdf release built with pillow >= 12.1.1.

### CVE-2026-26007 — cryptography subgroup attack via SECT curves (HIGH)
- **Affected image:** `ghcr.io/c4illin/convertx:v0.17.0` (Python package)
- **Component:** `cryptography` 46.0.3
- **Fix available in:** cryptography 46.0.5
- **Rationale:** Awaiting bentopdf release with updated cryptography dependency.

Review trigger: New bentopdf release built with cryptography >= 46.0.5.

### CVE-2026-30837 — Elysia ReDoS via URL format (HIGH)
- **Affected image:** `ghcr.io/c4illin/convertx:v0.17.0` (Node.js package)
- **Component:** `elysia` 1.4.21
- **Fix available in:** elysia 1.4.26
- **Rationale:** Awaiting bentopdf release with updated elysia dependency.

Review trigger: New bentopdf release built with elysia >= 1.4.26.

### CVE-2026-32597 — PyJWT accepts unknown crit header extensions (HIGH)
- **Affected image:** `ghcr.io/c4illin/convertx:v0.17.0` (Python package)
- **Component:** `PyJWT` 2.10.1
- **Fix available in:** PyJWT 2.12.0
- **Rationale:** Awaiting bentopdf release with updated PyJWT dependency.
- **Note:** Also present in `louislam/uptime-kuma:2.2.1-slim` (Debian 12 package, no fix in that context — see "No upstream fix" section).

Review trigger: New bentopdf release built with PyJWT >= 2.12.0.

### CVE-2026-24051 — OpenTelemetry PATH hijacking (HIGH)
- **Affected image:** `louislam/uptime-kuma:2.2.1-slim` (embedded cloudflared binary)
- **Component:** `go.opentelemetry.io/otel/sdk` v1.35.0
- **Fix available in:** otel/sdk v1.40.0
- **Rationale:** Awaiting uptime-kuma release with updated cloudflared binary.

Review trigger: New uptime-kuma release with cloudflared built against otel/sdk >= 1.40.0.

### CVE-2026-33186 — gRPC-Go authorization bypass (CRITICAL)
- **Affected image:** `louislam/uptime-kuma:2.2.1-slim` (embedded cloudflared binary)
- **Component:** `google.golang.org/grpc` v1.72.2
- **Fix available in:** grpc v1.79.3
- **Rationale:** Awaiting uptime-kuma release with updated cloudflared binary.

Review trigger: New uptime-kuma release with cloudflared built against grpc >= 1.79.3.

### CVE-2026-34040 — Moby authorization bypass (HIGH)
- **Affected images:** `traefik:v3.6.13`, `amir20/dozzle:v10.3`
- **Component:** `github.com/docker/docker` v28.5.2
- **Fix available in:** docker v29.3.1
- **Rationale:** Awaiting image releases with updated docker dependency.

Review trigger: New Traefik or Dozzle releases built with docker/docker >= 29.3.1.

### CVE-2026-34986 — go-jose Denial of Service (HIGH)
- **Affected images:** `authelia/authelia:4.39`, `traefik:v3.6.13`, `smallstep/step-ca:0.30.2`, `louislam/uptime-kuma:2.2.1-slim` (embedded cloudflared)
- **Component:** `github.com/go-jose/go-jose/v3` v3.0.4, `github.com/go-jose/go-jose/v4` v4.1.0–v4.1.3
- **Fix available in:** go-jose v3.0.5 / v4.1.4
- **Rationale:** Awaiting image releases with updated go-jose dependency.

Review trigger: New Authelia, Traefik, Step-CA, or uptime-kuma releases built with go-jose/v3 >= 3.0.5 or go-jose/v4 >= 4.1.4.

### CVE-2026-39883 — OpenTelemetry PATH hijacking (HIGH)
- **Affected images:** `traefik:v3.6.13`, `louislam/uptime-kuma:2.2.1-slim` (embedded cloudflared)
- **Component:** `go.opentelemetry.io/otel/sdk` v1.35.0–v1.41.0
- **Fix available in:** otel/sdk v1.43.0
- **Rationale:** Awaiting image releases with updated OpenTelemetry dependency.

Review trigger: New Traefik or uptime-kuma releases built with otel/sdk >= 1.43.0.

### uptime-kuma:2.2.1-slim — Debian 12 base layer, fix available

One OS-level CVE has a fix available in Debian but has not yet been applied to the image:

| CVE | Severity | Component | Fix |
|-----|----------|-----------|-----|
| CVE-2026-28390 | HIGH | `openssl`, `libssl3` 3.0.18 | 3.0.19-1~deb12u2 |

Review trigger: New uptime-kuma release based on Debian 12 with openssl >= 3.0.19.

### uptime-kuma:2.2.1-slim / homepage:v1.12.3 — Node.js dependencies, fixes available

All fixes exist upstream; images have not yet released builds with updated dependencies.
CVEs marked with ¹ also affect `ghcr.io/gethomepage/homepage:v1.12.3`.

| CVE | Severity | Package | Fixed in |
|-----|----------|---------|----------|
| CVE-2026-25896 ¹ | CRITICAL | `fast-xml-parser` 5.2.5 | 5.3.5 / 4.5.4 |
| CVE-2023-39325 | HIGH | `stdlib` (Go 1.20.5 healthcheck) | 1.20.10 |
| CVE-2023-45283 | HIGH | `stdlib` (Go 1.20.5 healthcheck) | 1.20.11 |
| CVE-2023-45288 | HIGH | `stdlib` (Go 1.20.5 healthcheck) | 1.21.9 |
| CVE-2024-24790 | CRITICAL | `stdlib` (Go 1.20.5 healthcheck) | 1.21.11 |
| CVE-2024-34156 | HIGH | `stdlib` (Go 1.20.5 healthcheck) | 1.22.7 |
| CVE-2025-47907 | HIGH | `stdlib` (Go 1.20.5 healthcheck) | 1.23.12 |
| CVE-2025-58183 | HIGH | `stdlib` (Go 1.20.5 healthcheck) | 1.24.8 |
| CVE-2025-61726 | HIGH | `stdlib` (Go 1.20.5 healthcheck) | 1.24.12 |
| CVE-2025-61728 | HIGH | `stdlib` (Go 1.20.5 healthcheck) | 1.24.12 |
| CVE-2025-61729 | HIGH | `stdlib` (Go 1.20.5 healthcheck) | 1.24.11 |
| CVE-2025-64756 | HIGH | `glob` 10.3.16 / 10.4.5 | 10.5.0 |
| CVE-2025-68121 | CRITICAL | `stdlib` (Go 1.20.5 healthcheck) | 1.24.13 |
| CVE-2026-1526 | HIGH | `undici` 6.23.0 | 6.24.0 |
| CVE-2026-1528 | HIGH | `undici` 6.23.0 | 6.24.0 |
| CVE-2026-2229 | HIGH | `undici` 6.23.0 | 6.24.0 |
| CVE-2026-23745 | HIGH | `tar` 6.2.1 / 7.4.3 | 7.5.3 |
| CVE-2026-23950 | HIGH | `tar` 6.2.1 / 7.4.3 | 7.5.4 |
| CVE-2026-24842 | HIGH | `tar` 6.2.1 / 7.4.3 | 7.5.7 |
| CVE-2026-25128 ¹ | HIGH | `fast-xml-parser` 5.2.5 | 5.3.4 |
| CVE-2026-25679 | HIGH | `stdlib` (Go 1.24.13 cloudflared) | 1.25.8 |
| CVE-2026-26278 ¹ | HIGH | `fast-xml-parser` 5.2.5 | 5.3.6 |
| CVE-2026-26960 | HIGH | `tar` 6.2.1 / 7.4.3 | 7.5.8 |
| CVE-2026-26996 | HIGH | `minimatch` 9.0.3 / 9.0.5 | 9.0.6 |
| CVE-2026-27903 | HIGH | `minimatch` 9.0.3 / 9.0.5 | 9.0.7 |
| CVE-2026-27904 | HIGH | `minimatch` 9.0.3 / 9.0.5 | 9.0.7 |
| CVE-2026-29786 | HIGH | `tar` 6.2.1 / 7.4.3 | 7.5.10 |
| CVE-2026-31802 | HIGH | `tar` 6.2.1 / 7.4.3 | 7.5.11 |
| CVE-2026-33036 ¹ | HIGH | `fast-xml-parser` 5.2.5 / 5.4.1 | 5.5.6 |
| CVE-2026-33151 | HIGH | `socket.io-parser` 4.2.5 | 4.2.6 |
| CVE-2026-33671 ¹ | HIGH | `picomatch` 4.0.2–4.0.3 | 4.0.4 |
| CVE-2026-35525 | HIGH | `liquidjs` 10.25.0 | 10.25.3 |
| CVE-2026-4800 | HIGH | `lodash` 4.17.23 | 4.18.0 |
| CVE-2026-4867 | HIGH | `path-to-regexp` 0.1.12 | 0.1.13 |

Review trigger: New uptime-kuma release with updated Node.js dependencies and recompiled Go healthcheck binary.

## No upstream fix available

### CVE-2024-23342 — python-ecdsa Minerva timing attack (HIGH)
- **Affected image:** `nicolargo/glances:4.5.3.2`
- **Component:** `ecdsa` 0.19.2 (Python package)
- **Fix available in:** none — library is unmaintained
- **Rationale:** python-ecdsa has no fix for this timing-side-channel attack and is effectively abandoned. Glances uses it as a dependency; no alternative is available without upstream action.

Review trigger: Glances dropping or replacing the ecdsa dependency.

### convertx:v0.17.0 — Debian 13 base layer, fixes available

All CVEs are in OS-level packages shipped with the Debian 13 base image inside convertx.
No fix action possible without upstream image rebuild.

| CVE | Severity | Component | Fixed in |
|-----|----------|-----------|----------|
| CVE-2025-2152 | CRITICAL | `assimp-utils`, `libassimp5` | no fix |
| CVE-2026-22770 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u5 |
| CVE-2026-23876 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u5 |
| CVE-2026-25897 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u6 |
| CVE-2026-25898 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u6 |
| CVE-2026-25968 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u6 |
| CVE-2026-25971 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u6 |
| CVE-2026-25983 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u6 |
| CVE-2026-25986 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u6 |
| CVE-2026-25987 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u6 |
| CVE-2026-26283 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u6 |
| CVE-2026-26284 | CRITICAL | `imagemagick*`, `libmagick*` | deb13u6 |
| CVE-2026-34873 | CRITICAL | `libmbedcrypto16` | no fix |
| CVE-2026-34875 | CRITICAL | `libmbedcrypto16` | no fix |
| CVE-2026-2781  | CRITICAL | `libnss3` | deb13u1 |
| CVE-2025-66034 | CRITICAL | `python3-fonttools` | deb13u1 |
| CVE-2026-0968  | CRITICAL | `libssh-4` | no fix |
| CVE-2024-48423 | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2025-11275 | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2025-11277 | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2025-15538 | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2025-2151  | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2025-2592  | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2025-2750–2757 | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2025-3015  | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2025-3158–3159 | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2025-5200–5204 | HIGH | `assimp-utils`, `libassimp5` | no fix |
| CVE-2026-23952–26066 (imagemagick) | HIGH | `imagemagick*`, `libmagick*` | deb13u5–u6 |
| CVE-2026-27798–32636 (imagemagick) | HIGH | `imagemagick*`, `libmagick*` | deb13u6–u7 |
| CVE-2026-25635/36/31/64/65/30853 | HIGH | `calibre`, `calibre-bin` | no fix |
| CVE-2026-24882 | HIGH | `gnupg*`, `gpg*`, `dirmngr` | no fix |
| CVE-2026-4111/4424 | HIGH | `libarchive13t64` | no fix |
| CVE-2024-36600 | HIGH | `libcdio19t64` | no fix |
| CVE-2026-33164 | HIGH | `libde265-0` | no fix |
| CVE-2026-5201  | HIGH | `libgdk-pixbuf*` | no fix |
| CVE-2026-23868/26740 | HIGH | `libgif7` | no fix |
| CVE-2026-2921  | HIGH | `libgstreamer-plugins-base1.0-0` | deb13u1 |
| CVE-2025-68431 | HIGH | `libheif*` | no fix |
| CVE-2026-27601 | HIGH | `libjs-underscore` | no fix |
| CVE-2026-1837  | HIGH | `libjxl*` | no fix |
| CVE-2025-2338/50343 | HIGH | `libmatio13` | no fix |
| CVE-2026-34872 | HIGH | `libmbedcrypto16` | no fix |
| CVE-2026-25556 | HIGH | `libmupdf25.1`, `mupdf-tools` | no fix |
| CVE-2025-12495/12839/12840/64181 | HIGH | `libopenexr-3-1-30` | no fix |
| CVE-2026-27622/34379/34543–45/34588 | HIGH | `libopenexr-3-1-30` | no fix |
| CVE-2026-22695/22801/25646/33416/33636 | HIGH | `libpng16-16t64` | deb13u2–u4 |
| CVE-2025-10729 | HIGH | `libqt6svg6`, `libqt6svgwidgets6` | no fix |
| CVE-2026-20884/20889/20911/21413 | HIGH | `libraw23t64` | no fix |
| CVE-2026-24450/24660 | HIGH | `libraw23t64` | no fix |
| CVE-2026-3731  | HIGH | `libssh-4` | no fix |
| CVE-2026-4775  | HIGH | `libtiff6` | deb13u2 |
| CVE-2025-59933/CVE-2026-2913 | HIGH | `libvips*` | no fix |
| CVE-2026-3145/3147/3281–3283 | HIGH | `libvips*` | no fix |
| CVE-2026-2447  | HIGH | `libvpx9` | deb13u1 |
| CVE-2026-23949 | HIGH | `python3-setuptools-whl` | no fix |
| CVE-2022-4055  | HIGH | `xdg-utils` | no fix |
| CVE-2021-30472/CVE-2023-31566/31567 | HIGH | `libpodofo0.9.8t64` | no fix |

Review trigger: New convertx release based on updated Debian 13 base image.

### uptime-kuma:2.2.1-slim — Debian 12 base layer, no fix available

The following CVEs have no fix in Debian 12 (status: `affected` or `will_not_fix`).
They will only be resolved by a base image upgrade or a Debian security update.

| CVE | Severity | Component | Notes |
|-----|----------|-----------|-------|
| CVE-2023-2953 | HIGH | `libldap-2.5-0` | openldap null pointer dereference |
| CVE-2023-45853 | CRITICAL | `zlib1g` | integer overflow in zipOpenNewFileInZip4_6; will_not_fix |
| CVE-2023-50782 | HIGH | `python3-cryptography` | Bleichenbacher timing oracle; will_not_fix |
| CVE-2025-7458 | CRITICAL | `libsqlite3-0`, `sqlite3` | integer overflow |
| CVE-2025-8194 | HIGH | `python3.11*` | cpython tarfile infinite loop |
| CVE-2025-13836 | HIGH | `python3.11*` | http.client excessive read buffering |
| CVE-2025-15366 | HIGH | `python3.11*` | IMAP command injection; will_not_fix |
| CVE-2025-15367 | HIGH | `python3.11*` | POP3 command injection; will_not_fix |
| CVE-2025-66471 | HIGH | `python3-urllib3` | highly compressed data DoS; will_not_fix |
| CVE-2025-69534 | HIGH | `python3.11*` | python-markdown HTML-like sequence DoS |
| CVE-2025-69720 | HIGH | `ncurses*` | buffer overflow |
| CVE-2026-0861 | HIGH | `libc-bin`, `libc6`, `nscd` | glibc memalign integer overflow |
| CVE-2026-1299 | HIGH | `python3.11*` | cpython email header injection |
| CVE-2026-25210 | HIGH | `libexpat1` | integer overflow, info disclosure |
| CVE-2026-27135 | HIGH | `libnghttp2-14` | HTTP/2 frames DoS |
| CVE-2026-29111 | HIGH | `libsystemd0`, `libudev1` | systemd IPC code execution/DoS |
| CVE-2026-32597 | HIGH | `python3-jwt` | PyJWT accepts unknown crit header extensions |
| CVE-2026-35535 | HIGH | `sudo` | privilege escalation via failed privilege drop |
| CVE-2026-4519 | HIGH | `python3.11*` | webbrowser.open() command injection |

Review trigger: New uptime-kuma release based on updated Debian 12 or a newer Debian version.

---

Stack is LAN-only, not publicly exposed. Fixes are available upstream where noted; exceptions are
temporary until the respective images are rebuilt or dependencies are replaced.