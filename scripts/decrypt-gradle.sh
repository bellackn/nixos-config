#!/usr/bin/env bash
set -euo pipefail

USER_NAME="n.bellack"
KEY_FILE="/Users/${USER_NAME}/.config/sops/age/keys.txt"
SECRET_FILE="secrets/gradle.properties.secret"
TARGET_FILE="/Users/${USER_NAME}/.gradle/gradle.properties"

mkdir -p "$(dirname "$TARGET_FILE")"

export SOPS_AGE_KEY_FILE="$KEY_FILE"

echo "Decrypting gradle.properties..."
sops --decrypt "$SECRET_FILE" > "$TARGET_FILE"
echo "Done: $TARGET_FILE"
