#!/usr/bin/env bash
set -euo pipefail

repo="HAL-42/bash-proxy-toggle"
description="Tiny Bash helper to toggle HTTP/HTTPS/SOCKS5 proxy variables"

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI 'gh' is required. Install it and run: gh auth login" >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "GitHub CLI is not authenticated. Run: gh auth login" >&2
  exit 1
fi

if [ ! -d .git ]; then
  git init
  git branch -M main
fi

git add README.md .gitignore proxy.bash install.sh publish.sh
git commit -m "Initial Bash proxy toggle helper" || true

if gh repo view "$repo" >/dev/null 2>&1; then
  if ! git remote get-url origin >/dev/null 2>&1; then
    git remote add origin "https://github.com/${repo}.git"
  fi
  git push -u origin main
else
  gh repo create "$repo" \
    --public \
    --description "$description" \
    --source=. \
    --remote=origin \
    --push
fi

gh repo edit "$repo" \
  --add-topic bash \
  --add-topic shell \
  --add-topic proxy \
  --add-topic bash-script
