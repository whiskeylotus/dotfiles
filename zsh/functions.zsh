# Shell functions. Anything longer or reusable from outside zsh lives in bin/.

# mkcd <dir> — make a directory and step into it
mkcd() { mkdir -p "$1" && cd "$1" }

# cheat [term] — open the cheatsheet, or grep it
cheat() {
  local f="$DOTFILES/CHEATSHEET.md"
  if [[ -n "$1" ]]; then
    rg -i --color=always -B1 -A3 "$1" "$f" | ${PAGER:-less} -R
  else
    bat --style=plain --language=markdown "$f"
  fi
}

# kb [term] — search the knowledge base, or browse it with fzf
kb() {
  local root="${KB:-$HOME/Documents/perso/knowledge_db}"
  [[ -d "$root" ]] || {
    echo "kb: no knowledge base at ${root/#$HOME/~}" >&2
    echo "    clone it there, or set KB=<path> in ~/.zshrc.local" >&2
    return 1
  }
  if [[ -n "$1" ]]; then
    (cd "$root" && rg -i --color=always -B1 -A3 --glob '*.md' "$*") | ${PAGER:-less} -R
  else
    local f
    f=$(cd "$root" && fd -e md --exclude _templates \
      | fzf --preview 'bat --style=plain --color=always --language=markdown {}' --height 80%) || return
    bat --style=plain --language=markdown "$root/$f"
  fi
}

# extract <archive> — unpack anything without remembering the flags
extract() {
  [[ -f "$1" ]] || { echo "extract: '$1' is not a file" >&2; return 1 }
  case "$1" in
    *.tar.bz2|*.tbz2) tar xjf "$1"   ;;
    *.tar.gz|*.tgz)   tar xzf "$1"   ;;
    *.tar.xz)         tar xJf "$1"   ;;
    *.tar)            tar xf  "$1"   ;;
    *.zip)            unzip   "$1"   ;;
    *.gz)             gunzip  "$1"   ;;
    *.bz2)            bunzip2 "$1"   ;;
    *.7z)             7z x    "$1"   ;;
    *) echo "extract: don't know how to handle '$1'" >&2; return 1 ;;
  esac
}

# killport <port> — kill whatever is listening on a port
killport() {
  [[ -n "$1" ]] || { echo "usage: killport <port>" >&2; return 1 }
  local pids=$(lsof -ti tcp:"$1")
  [[ -n "$pids" ]] || { echo "nothing listening on $1"; return 0 }
  echo "$pids" | xargs kill -9 && echo "killed $(echo $pids | wc -w | tr -d ' ') process(es) on port $1"
}

# gclone <url> — clone into ~/dev and cd there
gclone() {
  [[ -n "$1" ]] || { echo "usage: gclone <url>" >&2; return 1 }
  mkdir -p "$DEV" && git -C "$DEV" clone "$1" && cd "$DEV/$(basename "$1" .git)"
}

# gcb <branch> — create and switch to a branch (fetches first)
gcb() { git fetch --quiet origin && git switch -c "$1" }

# fzf-powered git branch switcher
gbr() {
  local branch
  branch=$(git branch --all --sort=-committerdate --format='%(refname:short)' \
    | rg -v '^origin/HEAD' \
    | fzf --preview 'git log --oneline --color=always -20 {}' --height 50%) || return
  git switch "${branch#origin/}"
}

# fzf-powered process kill
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --header='select process(es) to kill' | awk '{print $2}') || return
  [[ -n "$pid" ]] && echo "$pid" | xargs kill -${1:-9}
}

# note [text] — append a timestamped line to today's scratch note, or open it
note() {
  local dir="$HOME/Documents/notes" file="$dir/$(date +%Y-%m-%d).md"
  mkdir -p "$dir"
  if [[ -n "$*" ]]; then printf -- '- %s %s\n' "$(date +%H:%M)" "$*" >> "$file"
  else ${EDITOR} "$file"; fi
}
