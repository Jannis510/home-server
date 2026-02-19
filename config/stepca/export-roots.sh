#!/bin/sh
set -eu

OUT_ROOTS="/export/roots.pem"
OUT_ROOTCRT="/export/root_ca.crt"

CA_HEALTH="https://stepca:9000/health"
CA_ROOTS="https://stepca:9000/roots.pem"

# Wenn beide Dateien existieren -> skip
if [ -s "$OUT_ROOTS" ] && [ -s "$OUT_ROOTCRT" ]; then
  echo "roots.pem + root_ca.crt exist, skip"
  exit 0
fi

echo "waiting for stepca..."

i=0
while [ $i -lt 60 ]; do
  if curl -sk "$CA_HEALTH" >/dev/null 2>&1; then
    break
  fi
  i=$((i+1))
  sleep 1
done

if [ $i -eq 60 ]; then
  echo "stepca not reachable"
  exit 1
fi

echo "exporting roots..."
curl -skf "$CA_ROOTS" -o "$OUT_ROOTS"

# root_ca.crt ableiten (gleicher PEM-Inhalt)
cp "$OUT_ROOTS" "$OUT_ROOTCRT"

echo "exported:"
echo " - $OUT_ROOTS"
echo " - $OUT_ROOTCRT"
