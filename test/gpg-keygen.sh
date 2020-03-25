#!/usr/bin/env bash

set -e

name=${1:-gitsrv}
email=${2:-support@weave.works}
batchcfg=$(mktemp)

cat > "$batchcfg" << EOF
  %echo Generating a throwaway OpenPGP key for "$name <$email>"
  Key-Type: 1
  Key-Length: 2048
  Subkey-Type: 1
  Subkey-Length: 2048
  Name-Real: $name
  Name-Email: $email
  Expire-Date: 0
  %no-protection
  %commit
  %echo Done
EOF

gpg --batch --gen-key "$batchcfg"

key_id=$(gpg --no-tty --list-secret-keys --with-colons "$name" 2> /dev/null |
  awk -F: '/^sec:/ { print $5 }' | tail -1)

gpg --export-secret-keys "$key_id" | \
kubectl create secret generic gpg-signing-key \
  --from-file=gitsrv.asc=/dev/stdin
