#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: scripts/cert-issue.sh [options] <service>

Creates a server certificate signed by your Root CA for <service>.<LOCAL_DOMAIN>.
Writes certs to secrets/nginx/<service>/ by default.

Options:
  --service <name>       Service name (alternative to positional arg)
  --out-dir <path>       Output directory (default: secrets/nginx/<service>)
  --days <n>             Cert validity in days (default: 825)
  --key-bits <n>         RSA key size (default: 2048)
  --extra-dns <a,b,c>    Additional DNS SANs (default: from EXTRA_DNS env)
  --no-ip                Do not include SERVER_IP as IP SAN
  --env-file <path>      Env file to load (default: .env)
  --force                Overwrite existing files in out-dir
  -h, --help             Show help

Requires in .env:
  LOCAL_DOMAIN, SERVER_IP

Env overrides:
  EXTRA_DNS, CERT_DAYS, CERT_KEY_BITS, CERT_OUT_BASE
USAGE
}

die() { echo "Error: $*" >&2; exit 1; }

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ENV_FILE="$ROOT_DIR/.env"
SERVICE=""
OUT_DIR=""
DAYS="${CERT_DAYS:-825}"
KEY_BITS="${CERT_KEY_BITS:-2048}"
EXTRA_DNS_ENV="${EXTRA_DNS:-}"
INCLUDE_IP="1"
FORCE="0"

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --service) SERVICE="${2:-}"; shift 2;;
    --out-dir) OUT_DIR="${2:-}"; shift 2;;
    --days) DAYS="${2:-}"; shift 2;;
    --key-bits) KEY_BITS="${2:-}"; shift 2;;
    --extra-dns) EXTRA_DNS_ENV="${2:-}"; shift 2;;
    --no-ip) INCLUDE_IP="0"; shift;;
    --env-file)
      ENV_FILE="${2:-}"
      [[ "$ENV_FILE" = /* ]] || ENV_FILE="$ROOT_DIR/$ENV_FILE"
      shift 2
      ;;
    --force) FORCE="1"; shift;;
    -h|--help) usage; exit 0;;
    *)
      # positional service
      if [[ -z "$SERVICE" ]]; then
        SERVICE="$1"
        shift
      else
        die "Unknown arg: $1 (use --help)"
      fi
      ;;
  esac
done

[[ -n "$SERVICE" ]] || die "Service name is required. Example: scripts/cert-issue.sh pihole"

# Load env
if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

: "${LOCAL_DOMAIN:?LOCAL_DOMAIN is required}"
: "${SERVER_IP:?SERVER_IP is required}"

[[ "$DAYS" =~ ^[0-9]+$ ]] || die "--days must be an integer"
[[ "$KEY_BITS" =~ ^[0-9]+$ ]] || die "--key-bits must be an integer"

CA_DIR="$ROOT_DIR/secrets/ca"
ROOT_KEY="$CA_DIR/rootCA.key"
ROOT_CERT="$CA_DIR/rootCA.crt"

[[ -f "$ROOT_KEY" && -f "$ROOT_CERT" ]] || die "Root CA not found. Run scripts/ca-init.sh first."

# Output directory: per service
OUT_BASE="${CERT_OUT_BASE:-$ROOT_DIR/secrets/nginx}"
[[ "$OUT_BASE" = /* ]] || OUT_BASE="$ROOT_DIR/$OUT_BASE"

if [[ -z "$OUT_DIR" ]]; then
  OUT_DIR="$OUT_BASE/$SERVICE"
else
  [[ "$OUT_DIR" = /* ]] || OUT_DIR="$ROOT_DIR/$OUT_DIR"
fi

mkdir -p "$OUT_DIR"

SERVER_KEY="$OUT_DIR/server.key"
SERVER_CSR="$OUT_DIR/server.csr"
SERVER_CERT="$OUT_DIR/server.crt"
FULLCHAIN="$OUT_DIR/fullchain.pem"

if [[ "$FORCE" != "1" && -f "$SERVER_KEY" && -f "$SERVER_CERT" ]]; then
  echo "Certificate already exists in $OUT_DIR (use --force to overwrite)"
  exit 0
fi

DNS_NAME="${SERVICE}.${LOCAL_DOMAIN}"

SAN_ENTRIES="DNS:${DNS_NAME}"
if [[ "$INCLUDE_IP" == "1" ]]; then
  SAN_ENTRIES+=",IP:${SERVER_IP}"
fi

if [[ -n "$EXTRA_DNS_ENV" ]]; then
  IFS=',' read -ra EXTRA <<< "$EXTRA_DNS_ENV"
  for entry in "${EXTRA[@]}"; do
    entry="${entry//[[:space:]]/}"
    [[ -n "$entry" ]] && SAN_ENTRIES+=",DNS:${entry}"
  done
fi

TMP_CONF="$(mktemp)"
cat > "$TMP_CONF" <<CONF
[req]
prompt = no
distinguished_name = dn
req_extensions = v3_req

[dn]
CN = ${DNS_NAME}

[v3_req]
basicConstraints = critical,CA:FALSE
keyUsage = critical,digitalSignature,keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = ${SAN_ENTRIES}
subjectKeyIdentifier = hash
CONF

openssl genrsa -out "$SERVER_KEY" "$KEY_BITS"
openssl req -new -key "$SERVER_KEY" -out "$SERVER_CSR" -config "$TMP_CONF"

openssl x509 -req -in "$SERVER_CSR" \
  -CA "$ROOT_CERT" -CAkey "$ROOT_KEY" -CAcreateserial \
  -out "$SERVER_CERT" -days "$DAYS" -sha256 \
  -extensions v3_req -extfile "$TMP_CONF"

cat "$SERVER_CERT" "$ROOT_CERT" > "$FULLCHAIN"
chmod 600 "$SERVER_KEY"
rm -f "$TMP_CONF"

echo "Server certificate created:"
echo "  Service:   $SERVICE"
echo "  DNS name:  $DNS_NAME"
echo "  SAN:       $SAN_ENTRIES"
echo "  Output:    $OUT_DIR"
