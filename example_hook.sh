#!/usr/bin/env bash
set -uf -o pipefail
IFS=$'\n\t'

case "${1:-}" in
  new | switch) ;;
  *) exit 0 ;;
esac

SOURCE="$2"
TARGET="$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null 2>&1 && pwd)/current"

ln -sTf "$SOURCE" "$TARGET"
