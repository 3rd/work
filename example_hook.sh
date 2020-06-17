#!/usr/bin/env bash
set -uf -o pipefail
IFS=$'\n\t'

SOURCE="$1"
TARGET="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)/current"

ln -sTf "$SOURCE" "$TARGET"
