#!/usr/bin/env bash
set -euo pipefail

# -----------------------------
# Config (defaults; override via .env or CLI flags)
# -----------------------------
DEFAULT_COUNTRY="DE"
DEFAULT_ORG="HomeLab"
DEFAULT_CN="HomeLab Root CA"
DEFAULT_DAYS="3650"
DEFAULT_KEY_BITS="4096"

# Paths (relative to repo root)
DEFAULT_SECRETS_SUBDIR="secrets/ca"
DEFAULT_ENV_FILE=".env"

# -----------------------------
# Helpers
# -----------------------------
usage() {
  cat <<'USAGE'
Usage: scripts/ca-init.sh [options]

Creates a Root CA (rootCA.key + rootCA.crt) if it does not exist.

Options:
  --country <C>         Subject country (default: DE)
  --org <O>             Subject organization (default: HomeLab)
  --cn <CN>             Subject common name (default: "HomeLab Root CA")
  --days <N>            Validity in days (default: 3650)
  --key-bits <N>        RSA key size (default: 4096)
  --secrets-dir <PATH>  Secrets directory (default: secrets/ca)
  --env-file <PATH>     Env file path (default: .env)
  --force               Overwrite existing rootCA.key/rootCA.crt
  -h, --help            Show help

You can also set these via .env:
  CA_COUNTRY, CA_ORG, CA_CN, CA_DAYS, CA_KEY_BITS, CA_SECRETS_DIR, CA_SUBJECT

Note:
  If CA_SUBJECT is set, it takes precedence over country/org/cn.
USAGE
}

die() { echo "Error: $*" >&2; exit 1; }

# -----------------------------
# Locate repo root + load env
# -----------------------------
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# defaults (may be overridden)
ENV_FILE="$ROOT_DIR/$DEFAULT_ENV_FILE"
SECRETS_DIR="$ROOT_DIR/$DEFAULT_SECRETS_SUBDIR"

COUNTRY="$DEFAULT_COUNTRY"
ORG="$DEFAULT_ORG"
CN="$DEFAULT_CN"
DAYS="$DEFAULT_DAYS"
KEY_BITS="$DEFAULT_KEY_BITS"
FORCE="0"

# Load .env if present
if [[ -f "$ENV_FILE" ]]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

# Apply .env overrides (if set)
COUNTRY="${CA_COUNTRY:-$COUNTRY}"
ORG="${CA_ORG:-$ORG}"
CN="${CA_CN:-$CN}"
DAYS="${CA_DAYS:-$DAYS}"
KEY_BITS="${CA_KEY_BITS:-$KEY_BITS}"
SECRETS_DIR="${CA_SECRETS_DIR:-$SECRETS_DIR}"

# -----------------------------
# Parse CLI args (CLI wins)
# -----------------------------
while [[ $# -gt 0 ]]; do
  case "$1" in
    --country) COUNTRY="${2:-}"; shift 2;;
    --org) ORG="${2:-}"; shift 2;;
    --cn) CN="${2:-}"; shift 2;;
    --days) DAYS="${2:-}"; shift 2;;
    --key-bits) KEY_BITS="${2:-}"; shift 2;;
    --secrets-dir) SECRETS_DIR="${2:-}"; shift 2;;
    --env-file)
      ENV_FILE="${2:-}"
      [[ "$ENV_FILE" = /* ]] || ENV_FILE="$ROOT_DIR/$ENV_FILE"
      # reload env from specified file
      if [[ -f "$ENV_FILE" ]]; then
        # shellcheck disable=SC1090
        source "$ENV_FILE"
      fi
      # re-apply env overrides after reload
      COUNTRY="${CA_COUNTRY:-$COUNTRY}"
      ORG="${CA_ORG:-$ORG}"
      CN="${CA_CN:-$CN}"
      DAYS="${CA_DAYS:-$DAYS}"
      KEY_BITS="${CA_KEY_BITS:-$KEY_BITS}"
      SECRETS_DIR="${CA_SECRETS_DIR:-$SECRETS_DIR}"
      shift 2
      ;;
    --force) FORCE="1"; shift;;
    -h|--help) usage; exit 0;;
    *) die "Unknown option: $1 (use --help)";;
  esac
done

# Make secrets dir absolute if needed
[[ "$SECRETS_DIR" = /* ]] || SECRETS_DIR="$ROOT_DIR/$SECRETS_DIR"

# Validate inputs (basic)
[[ "$COUNTRY" =~ ^[A-Z]{2}$ ]] || die "--country must be 2-letter ISO code (e.g., DE)"
[[ "$DAYS" =~ ^[0-9]+$ ]] || die "--days must be an integer"
[[ "$KEY_BITS" =~ ^[0-9]+$ ]] || die "--key-bits must be an integer"

mkdir -p "$SECRETS_DIR"

ROOT_KEY="$SECRETS_DIR/rootCA.key"
ROOT_CERT="$SECRETS_DIR/rootCA.crt"

if [[ "$FORCE" != "1" && -f "$ROOT_KEY" && -f "$ROOT_CERT" ]]; then
  echo "Root CA already exists at $SECRETS_DIR"
  exit 0
fi

# Subject: prefer CA_SUBJECT if explicitly set, otherwise build from parts
CA_SUBJECT="${CA_SUBJECT:-/C=${COUNTRY}/O=${ORG}/CN=${CN}}"

TMP_CONF="$(mktemp)"
cat > "$TMP_CONF" <<'CONF'
[req]
prompt = no
distinguished_name = dn
x509_extensions = v3_ca

[dn]
CN = Root CA

[v3_ca]
basicConstraints = critical,CA:TRUE,pathlen:1
keyUsage = critical,keyCertSign,cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always,issuer
CONF

openssl genrsa -out "$ROOT_KEY" "$KEY_BITS"
openssl req -x509 -new -nodes -key "$ROOT_KEY" -sha256 -days "$DAYS" \
  -subj "$CA_SUBJECT" -out "$ROOT_CERT" -config "$TMP_CONF" -extensions v3_ca

chmod 600 "$ROOT_KEY"
rm -f "$TMP_CONF"

echo "Root CA created at $SECRETS_DIR"
echo "  Subject: $CA_SUBJECT"
echo "  Days:    $DAYS"
echo "  KeyBits: $KEY_BITS"
