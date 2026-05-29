#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$DOTFILES/$1"
  local dst="$HOME/$1"
  mkdir -p "$(dirname "$dst")"
  ln -sf "$src" "$dst"
  echo "  linked $dst"
}

copy() {
  local src="$DOTFILES/$1"
  local dst="$HOME/$1"
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "  copied $dst"
}

echo "Installing dotfiles from $DOTFILES"

link ".gitconfig"
link ".zprofile"
link ".config/fish/config.fish"
link ".config/fish/alias.fish"
link ".config/starship.toml"
link ".config/gh/config.yml"
link "Library/Application Support/Claude/claude_desktop_config.json"
link "Library/Application Support/Code/User/mcp.json"
link "Library/Application Support/Code/User/settings.json"
link "Library/Application Support/iTerm2/DynamicProfiles/Profiles.json"
link ".config/linearmouse/linearmouse.json"
link ".config/git/ignore"
link ".docker/config.json"
link ".pi/agent/settings.json"
link ".pi/agent/npm/package.json"
link ".claude/settings.json"

# Claude skills/tasks must be real files — scheduler writes to them
find "$DOTFILES/.claude/scheduled-tasks" -name "SKILL.md" | while read -r src; do
  rel="${src#$DOTFILES/}"
  copy "$rel"
done
find "$DOTFILES/.claude/skills" -name "SKILL.md" 2>/dev/null | while read -r src; do
  rel="${src#$DOTFILES/}"
  copy "$rel"
done

echo ""
echo "Done. Next steps:"
echo "  brew bundle install    # restore all packages"
echo "  colima start --cpu 4 --memory 8 --kubernetes  # start container runtime with k8s"
