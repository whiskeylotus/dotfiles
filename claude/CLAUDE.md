# Global preferences

## This machine

macOS (Apple Silicon), zsh, Ghostty + tmux (prefix `C-a`), Homebrew at `/opt/homebrew`.
Suggest macOS commands, never Linux-only ones — `pbcopy` not `xclip`, `ipconfig getifaddr en0`
not `ip a`, `launchctl` not `systemctl`, `brew` not `apt`.

Dotfiles live in `~/dotfiles` and are symlinked into place by `~/dotfiles/bootstrap.sh`.
**Edit the file in `~/dotfiles/`, never the symlink target in `~/.config/`.**
Projects live in `~/dev`; Claude worktrees in `~/dev/.worktrees/<repo>/<branch>`.

## Tools

- Search with `rg` and `fd`, not `grep -r` / `find`.
- `bat` for viewing files, `eza` for listing, `delta` renders git diffs.
- `gh` is authenticated — use it for PRs, issues, and CI status instead of scraping the web.

## Working style

- Answer the question asked; skip preamble and summary padding.
- Match the surrounding code's style. Don't add comments explaining the obvious.
- Don't create README/summary files unless asked.
- Prefer editing an existing file over creating a new one.

## Guardrails

- Never `git push --force`, rewrite published history, or delete a branch without asking.
- Never commit secrets. `.env` files are in the deny list for a reason.
- Ask before installing global packages (`brew install`, `npm -g`, `pip install --user`).
- When several sessions may touch the same repo, work in a worktree (`cw <branch>`) rather
  than switching branches under another session's feet.
