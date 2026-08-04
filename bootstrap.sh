#!/bin/bash
# bootstrap.sh — set this machine up from the dotfiles repo. Safe to re-run.
# Existing real files are moved to <file>.bak before being replaced by a symlink.
set -uo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"

bold=$'\033[1m'; green=$'\033[32m'; yellow=$'\033[33m'; dim=$'\033[2m'; reset=$'\033[0m'
info() { printf '%s==>%s %s\n' "$bold" "$reset" "$1"; }
ok()   { printf '  %s✓%s %s\n' "$green" "$reset" "$1"; }
skip() { printf '  %s·%s %s%s%s\n' "$dim" "$reset" "$dim" "$1" "$reset"; }
warn() { printf '  %s!%s %s\n' "$yellow" "$reset" "$1"; }

link() {
  local src="$DOTFILES/$1" dst="$2"
  [ -e "$src" ] || { warn "missing source: $1"; return; }
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    skip "${dst/#$HOME/~}"
    return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mv "$dst" "$dst.bak"
    warn "backed up ${dst/#$HOME/~} -> ${dst/#$HOME/~}.bak"
  fi
  ln -s "$src" "$dst"
  ok "${dst/#$HOME/~}"
}

# ------------------------------------------------------------------ brew ----
info "Homebrew packages"
if command -v brew >/dev/null; then
  if brew bundle check --file="$DOTFILES/Brewfile" >/dev/null 2>&1; then
    skip "Brewfile already satisfied"
  elif brew bundle --file="$DOTFILES/Brewfile"; then
    ok "brew bundle done"
  else
    warn "brew bundle reported failures — see above"
  fi
else
  warn "Homebrew not found — install it from https://brew.sh first"
fi

# --------------------------------------------------------------- symlinks ----
info "Linking config"
link zsh/zshenv              "$HOME/.zshenv"
link zsh/zprofile            "$HOME/.zprofile"
link zsh/zshrc               "$HOME/.zshrc"
link ghostty/config          "$CONFIG/ghostty/config"
link tmux/tmux.conf          "$CONFIG/tmux/tmux.conf"
link git/config              "$CONFIG/git/config"
link git/ignore              "$CONFIG/git/ignore"
link starship/starship.toml  "$CONFIG/starship.toml"
link claude/settings.json    "$HOME/.claude/settings.json"
link claude/CLAUDE.md        "$HOME/.claude/CLAUDE.md"
link claude/statusline.sh    "$HOME/.claude/statusline.sh"
link vim/vimrc               "$HOME/.vimrc"

# ------------------------------------------------------------------ dirs ----
info "Directories"
for d in "$HOME/dev" "$HOME/.cache/zsh" "$HOME/.cache/vim" "$HOME/.local/state/zsh" "$HOME/.cache/cpython"; do
  [ -d "$d" ] && skip "${d/#$HOME/~}" || { mkdir -p "$d"; ok "${d/#$HOME/~}"; }
done

# -------------------------------------------------------------------- kb ----
# The `kb` function ships with the shell config; the knowledge base itself is a
# separate repo that may not be on this machine. Absence is fine, not an error.
info "Knowledge base"
KB_DIR="${KB:-$HOME/Documents/perso/knowledge_db}"
if [ -d "$KB_DIR" ]; then
  ok "${KB_DIR/#$HOME/~}"
else
  warn "not found at ${KB_DIR/#$HOME/~} — \`kb\` will say so until you clone it"
  printf '    %sor set KB=<path> in ~/.zshrc.local%s\n' "$dim" "$reset"
fi

# ------------------------------------------------------------------- exec ----
chmod +x "$DOTFILES"/bin/* "$DOTFILES"/claude/statusline.sh 2>/dev/null
ok "scripts executable"

# -------------------------------------------------------------------- tpm ----
info "tmux plugin manager"
TPM="$CONFIG/tmux/plugins/tpm"
if [ -d "$TPM" ]; then
  skip "tpm present"
else
  git clone --quiet --depth 1 https://github.com/tmux-plugins/tpm "$TPM" && ok "tpm cloned"
fi
if [ -x "$TPM/bin/install_plugins" ]; then
  "$TPM/bin/install_plugins" >/dev/null 2>&1 && ok "tmux plugins installed"
fi

# ------------------------------------------------------------------- next ----
info "Remaining manual steps"
command -v gh >/dev/null && ! gh auth status >/dev/null 2>&1 &&
  printf '  %s·%s gh auth login --git-protocol ssh --hostname github.com\n' "$dim" "$reset"
[ -f "$CONFIG/git/config-work" ] ||
  printf '  %s·%s cp %s ~/.config/git/config-work   (only if you need a work identity)\n' \
    "$dim" "$reset" "git/config-work.example"
printf '  %s·%s open a new terminal, then run: %stmux%s and %scheat%s\n' \
  "$dim" "$reset" "$bold" "$reset" "$bold" "$reset"
