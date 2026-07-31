# dotfiles

macOS (Apple Silicon) terminal setup built around **Ghostty + tmux + Claude Code**, with a
visual system that answers "which project, which branch, which pane, which session needs me"
at a glance.

The day-to-day reference is **[CHEATSHEET.md](CHEATSHEET.md)** — or run `cheat` in a shell.

## New machine

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git clone git@github.com:whiskeylotus/dotfiles.git ~/dotfiles
~/dotfiles/bootstrap.sh
```

Then, once: `gh auth login --git-protocol ssh` and open a fresh terminal.

`bootstrap.sh` installs the `Brewfile`, symlinks configs into place (backing up anything real
it finds as `*.bak`), creates `~/dev`, and installs tmux plugins. It is idempotent — re-run it
whenever you add something.

## What's here

| Path | |
|---|---|
| `Brewfile` | Every package and cask this machine needs |
| `zsh/` | `zshenv`, `zprofile`, `zshrc`, aliases, functions — no framework, ~40ms startup |
| `starship/` | Prompt: dir, git, plus `◆ claude` and `⑂ worktree` badges |
| `ghostty/` | Terminal: Nerd Font, dimmed unfocused splits, `Ctrl+\`` quick terminal |
| `tmux/` | Prefix `C-a`, per-session colours, Claude session markers, resurrect |
| `git/` | delta, sensible defaults, aliases, per-directory identities |
| `claude/` | Global settings, status line, hooks, working preferences |
| `bin/` | `tsw` project switcher · `cw` Claude-on-a-worktree · `claude-notify` · `github-mcp` |
| `cheatsheets/` | Older vim/git reference notes |

## Conventions

- **Edit files in `~/dotfiles/`**, never the symlinks in `~/.config/`.
- Projects live in `~/dev`. Claude worktrees in `~/dev/.worktrees/<repo>/<branch>`.
- Machine-local and secret things go in `~/.zshrc.local` (untracked, sourced automatically).

## Previous life

The Linux/pentest version of these dotfiles is preserved on the
[`archive/linux-pentest`](../../tree/archive/linux-pentest) branch.
