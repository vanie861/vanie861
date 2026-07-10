#!/usr/bin/env bash
# Decrypt the committed blob back into the plaintext questions file.
#
#   data/questions.js.enc  ->  data/questions.js
#
# Use this after a fresh clone so the app has its questions locally.
#
# Usage (git bash / macOS / Linux):
#   QUESTIONS_KEY='your-strong-passphrase' bash scripts/decrypt-questions.sh
set -euo pipefail
: "${QUESTIONS_KEY:?Set QUESTIONS_KEY env var to your passphrase}"

cd "$(dirname "$0")/.."

openssl enc -d -aes-256-cbc -pbkdf2 -salt \
  -in data/questions.js.enc \
  -out data/questions.js \
  -pass env:QUESTIONS_KEY

echo "Wrote data/questions.js ($(wc -c < data/questions.js) bytes)."
