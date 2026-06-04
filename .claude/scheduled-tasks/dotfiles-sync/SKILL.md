---
name: dotfiles-sync
description: Perform a dotfiles sync
---

You are running a weekly dotfiles sync for /Users/dan/Github/dotfiles.

Work through these steps:

**1. Refresh the Brewfile**
Run: brew bundle dump --no-restart --force --file=/Users/dan/Github/dotfiles/Brewfile
This overwrites the Brewfile with the current state of installed packages.

**2. Scan for config drift**
Check if any of these tracked files have changed vs the repo copy:
- ~/.gitconfig
- ~/.zprofile
- ~/.config/fish/config.fish
- ~/.config/fish/alias.fish
- ~/.config/starship.toml
- ~/.config/gh/config.yml
- ~/.docker/config.json
- ~/.config/linearmouse/linearmouse.json
- ~/.config/git/ignore
- ~/.pi/agent/settings.json
- ~/.pi/agent/npm/package.json
- ~/.claude/settings.json
- ~/.claude/scheduled-tasks/ (all SKILL.md files)
- ~/.claude/skills/ (all SKILL.md files)
- ~/Library/Application Support/Code/User/settings.json
- ~/Library/Application Support/Code/User/mcp.json
- ~/Library/Application Support/Claude/claude_desktop_config.json
- ~/Library/Application Support/iTerm2/DynamicProfiles/Profiles.json

For each file, compare the live version to the repo copy using diff. If the live version has changed, copy it into the repo (overwriting the repo copy).

**3. Check for secrets before committing**
Do not commit if any file contains: passwords, tokens, private keys, or AWS credentials.
Specifically skip any copy of ~/.config/gh/hosts.yml if it somehow appears.

**4. Commit if anything changed**
Run: git status
If there are changes, stage and commit with a message like:
"weekly sync: update [list of what changed]".
and then push

**5. Report**
Print a short summary: what changed, what was committed, or "everything up to date".