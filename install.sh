#!/usr/bin/env bash
set -euo pipefail
REPO_URL=https://github.com/fhlkfds/ai-skills
CLONE="${AI_SKILLS_DIR:-$HOME/.local/share/ai-skills}"
AGENTS="$HOME/.agents/skills"
CLAUDE="$HOME/.claude/skills"

if [ -d "$CLONE/.git" ]; then
  git -C "$CLONE" fetch -q origin main
  git -C "$CLONE" reset -q --hard origin/main
else
  git clone -q "$REPO_URL" "$CLONE"
fi

mkdir -p "$AGENTS" "$CLAUDE"
backup="$AGENTS/.trash/ai-skills-$(date +%Y%m%d-%H%M%S)"

for src in "$CLONE"/skills/*/; do
  name=$(basename "$src")
  dest="$AGENTS/$name"
  if [ -e "$dest" ] && ! diff -rq "$src" "$dest" >/dev/null; then
    mkdir -p "$backup"; mv "$dest" "$backup/"
  fi
  [ -e "$dest" ] || cp -r "$src" "$dest"

  link="$CLAUDE/$name"
  if [ "$(readlink "$link" 2>/dev/null)" != "../../.agents/skills/$name" ]; then
    if [ -e "$link" ] || [ -L "$link" ]; then mkdir -p "$backup/claude"; mv "$link" "$backup/claude/"; fi
    ln -s "../../.agents/skills/$name" "$link"
  fi
  echo "installed $name"
done