# Vorssaint settings backup

Vorssaint stores its config in `UserDefaults` (`~/Library/Preferences/<bundle-id>.plist`).
That file isn't portable directly — it carries machine-specific state (mic device
IDs, window sizes, local file paths). The app has a built-in filtered export/import
instead, and that's what's tracked here.

## Export (after configuring the app)

Vorssaint → Settings → Advanced → **Export settings…** → save as
`Vorssaint Settings.plist` into this directory, then commit it.

## Import (new/reset Mac)

Install Vorssaint (`brew bundle install`), then
Settings → Advanced → **Import settings…** → pick `config/vorssaint/Vorssaint Settings.plist`.
App restarts with the restored config.

Not auto-symlinked by `install.sh` — it's a manual GUI export/import, not a
passively-read file.
