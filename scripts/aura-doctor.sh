#!/usr/bin/env bash
set -Eeuo pipefail

echo 'Aura repository diagnostic'
echo "Repository: $(basename "$PWD")"
echo "Branch: $(git branch --show-current 2>/dev/null || echo unknown)"
echo 'Git status:'
git status --short 2>/dev/null || true

for tool in git node bun python3 rustc cargo go docker; do
  if command -v "$tool" >/dev/null 2>&1; then
    printf '%-10s %s\n' "$tool" "$("$tool" --version 2>/dev/null | head -n1)"
  fi
done
