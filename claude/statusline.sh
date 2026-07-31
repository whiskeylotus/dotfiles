#!/bin/bash
# Claude Code status line. Reads the session JSON on stdin and prints one line:
#   <model> │ <dir> │ <branch+dirty> │ ⑂ <worktree> │ <cost>
# Colours match the tmux/starship palette so the whole screen reads as one thing.
set -uo pipefail

input=$(cat)

j() { printf '%s' "$input" | jq -r "$1 // empty" 2>/dev/null; }

model=$(j '.model.display_name')
dir=$(j '.workspace.current_dir'); [ -n "$dir" ] || dir=$(j '.cwd'); [ -n "$dir" ] || dir="$PWD"
cost=$(j '.cost.total_cost_usd')
added=$(j '.cost.total_lines_added')
removed=$(j '.cost.total_lines_removed')

BLUE='\033[38;2;122;162;247m'
CYAN='\033[38;2;125;207;255m'
MAGENTA='\033[38;2;187;154;247m'
GREEN='\033[38;2;158;206;106m'
ORANGE='\033[38;2;255;158;100m'
RED='\033[38;2;247;118;142m'
DIM='\033[38;2;86;95;137m'
RESET='\033[0m'

out=""
[ -n "$model" ] && out="${CYAN}󰧑 ${model}${RESET}"

out="${out}${DIM} │ ${RESET}${BLUE}$(basename "$dir")${RESET}"

if git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$dir" symbolic-ref --quiet --short HEAD 2>/dev/null || git -C "$dir" rev-parse --short HEAD 2>/dev/null)
  dirty=$(git -C "$dir" status --porcelain --untracked-files=no 2>/dev/null | wc -l | tr -d ' ')
  seg="${MAGENTA} ${branch}${RESET}"
  [ "${dirty:-0}" -gt 0 ] 2>/dev/null && seg="${seg}${ORANGE} ✚${dirty}${RESET}"
  out="${out}${DIM} │ ${RESET}${seg}"

  case "$(git -C "$dir" rev-parse --absolute-git-dir 2>/dev/null)" in
    */worktrees/*)
      root=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null)
      out="${out}${DIM} │ ${RESET}${ORANGE}⑂ $(basename "${root:-$dir}")${RESET}" ;;
  esac
fi

if [ -n "$added" ] || [ -n "$removed" ]; then
  [ "${added:-0}" != "0" ] || [ "${removed:-0}" != "0" ] &&
    out="${out}${DIM} │ ${RESET}${GREEN}+${added:-0}${RESET}${DIM}/${RESET}${RED}-${removed:-0}${RESET}"
fi

if [ -n "$cost" ]; then
  out="${out}${DIM} │ \$$(printf '%.2f' "$cost")${RESET}"
fi

printf '%b' "$out"
