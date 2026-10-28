#!/usr/bin/env bash
# Copies the client template (Spanish files only) into a new client folder outside this repo.
# Usage: scripts/new-client.sh <client-slug> [destination-root]
# Default destination root: /mnt/project-files/clientes
set -euo pipefail
slug="${1:-}"
root="${2:-/mnt/project-files/clientes}"
if [[ -z "$slug" || ! "$slug" =~ ^[a-z0-9-]+$ ]]; then
  echo "usage: $0 <client-slug> [destination-root]   (slug: lowercase letters, digits, hyphens)" >&2
  exit 2
fi
repo="$(cd "$(dirname "$0")/.." && pwd)"
dest="$root/$slug"
case "$(cd "$root" 2>/dev/null && pwd)/" in
  "$repo"/*) echo "refusing: client folders never go inside this repo" >&2; exit 1 ;;
esac
mkdir -p "$dest/escenario-SINTETICO"
for f in "$repo"/client-template/*.md; do
  name="$(basename "$f")"
  [[ "$name" == *.en.md || "$name" == README.md || "$name" == escenario-sintetico.md ]] && continue
  if [[ -e "$dest/$name" ]]; then
    echo "skip (exists): $dest/$name"
  else
    sed "s/<cliente>/$slug/g" "$f" > "$dest/$name"
    echo "created: $dest/$name"
  fi
done
