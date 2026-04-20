# Machine Setup Guide

## Quick Start

```sh
# 1. Clone this repo
git clone https://github.com/danielriddellsh/dotfiles ~/Github/dotfiles

# 2. Restore all packages
brew bundle install

# 3. Symlink configs
./install.sh
```

---

## Applications

| App | Install |
|---|---|
| VSCode | `brew install --cask visual-studio-code` (Brewfile) |
| Obsidian | `brew install --cask obsidian` (Brewfile) |
| Colima | `brew install colima` (Brewfile) |
| lazygit | `brew install lazygit` (Brewfile) |
| lazydocker | `brew install lazydocker` (Brewfile) |
| Claude Desktop | `brew install --cask claude` (Brewfile) |
| Bruno | `brew install --cask bruno` (Brewfile) |
| FreeLens | `brew install --cask freelens` (Brewfile) |
| Office 365 | `brew install --cask microsoft-office` (Brewfile) |
| Microsoft Teams | `brew install --cask microsoft-teams` (Brewfile) |
| Latest | `brew install --cask latest` (Brewfile) |
| Cleanup Buddy | `brew install --cask cleanupbuddy` (Brewfile) |
| Mole | `brew install mole` (Brewfile) |
| unum | `brew install danielriddell21/unum/unum` (Brewfile) |
| Island Browser | [download.island.io](https://download.island.io/) — manual |
| Company Portal | [Download](https://go.microsoft.com/fwlink/?linkid=853070) — manual |

---

## Extensions

| Extension | Install |
|---|---|
| LinearMouse | `brew install --cask linearmouse` (Brewfile) |
| Loop | `brew install --cask loop` (Brewfile) |
| Monocle | `brew install --cask monocle-app` (Brewfile) |
| DockLock Plus | App Store — manual |
| Ublock Origin Lite | App Store — manual |

---

## Screensaver

- **Fliqlo** — [fliqlo.com/screensaver](https://fliqlo.com/screensaver/) — manual download

---

## Terminal

| Tool | Install |
|---|---|
| iTerm2 | `brew install --cask iterm2` (Brewfile) |
| Fish shell | `brew install fish` (Brewfile) |
| Starship prompt | `brew install starship` (Brewfile) — [config](https://starship.rs/faq/#what-is-the-configuration-used-in-the-demo-gif) |

---

## SDKs

| SDK | Install |
|---|---|
| Go | `brew install go` (Brewfile) |
| buf | `brew install buf` (Brewfile) |
| uv (Python) | `brew install uv` (Brewfile) |
| Node.js | `brew install node` (Brewfile) |

---

## MCP Servers

Configs are tracked in this repo and symlinked by `install.sh`.

**Claude Desktop** (`~/Library/Application Support/Claude/claude_desktop_config.json`):
- `postgres` — local PostgreSQL via `@modelcontextprotocol/server-postgres`

**VS Code** (`~/Library/Application Support/Code/User/mcp.json`):
- `serena` — AI code assistant via [oraios/serena](https://github.com/oraios/serena)
