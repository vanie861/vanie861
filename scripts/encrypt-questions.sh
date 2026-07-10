#!/usr/bin/env bash
# Encrypt the plaintext questions into the committed blob.
#
#   data/questions.js  ->  data/questions.js.enc
#
# Run this every time you change the questions, then commit the .enc file.
# The plaintext data/questions.js is gitignored and never committed.
#
# Usage (git bash / macOS / Linux):
#   QUESTIONS_KEY='your-strong-passphrase' bash scripts/encrypt-questions.sh
#
# Use the SAME passphrase you store as the GitHub repo secret QUESTIONS_KEY.
set -euo pipefail
: "${QUESTIONS_KEY:?Set QUESTIONS_KEY env var to your passphrase}"

cd "$(dirname "$0")/.."

if [ ! -f data/questions.js ]; then
  echo "data/questions.js not found — nothing to encrypt." >&2
  exit 1
fi

openssl enc -aes-256-cbc -pbkdf2 -salt \
  -in data/questions.js \
  -out data/questions.js.enc \
  -pass env:QUESTIONS_KEY

echo "Wrote data/questions.js.enc ($(wc -c < data/questions.js.enc) bytes). Commit this file."
