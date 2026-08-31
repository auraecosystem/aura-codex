#!/usr/bin/env bash
set -Eeuo pipefail

echo '== Aura pipeline =='

if command -v bun >/dev/null 2>&1 && [[ -f package.json ]]; then
  bun install --frozen-lockfile
  bun run lint --if-present
  bun run typecheck --if-present
  bun test --if-present
  bun run build --if-present
fi

if [[ -f pyproject.toml || -f requirements.txt ]]; then
  command -v python3 >/dev/null 2>&1 && python3 -m compileall .
  command -v ruff >/dev/null 2>&1 && ruff check .
  command -v pytest >/dev/null 2>&1 && pytest -q
fi

if [[ -f Cargo.toml ]]; then
  cargo fmt --check
  cargo clippy --all-targets --all-features -- -D warnings
  cargo test --all-features
fi

echo '== Aura pipeline complete =='
