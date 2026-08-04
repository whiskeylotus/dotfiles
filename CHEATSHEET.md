# Cheatsheet

`cheat` opens this file · `cheat worktree` greps it · lives in `~/dotfiles/CHEATSHEET.md`

---

## The first six things

| Do this | Get this |
|---|---|
| `tmux` | Start the multiplexer. Everything below assumes you're inside it. |
| `C-a f` | Fuzzy-jump to any project in `~/dev` — creates its session if needed. |
| `C-a C` | New window running Claude, in the current repo. |
| `cw <branch>` | New Claude session on its own git worktree. Parallel work, zero conflicts. |
| `C-a g` | lazygit in a full-screen popup. `q` closes it. |
| `cheat` | This file. |

`C-a` means: press `ctrl`+`a`, release, then press the next key. It is the tmux **prefix**.

---

## Reading the screen

| What you see | What it means |
|---|---|
| Coloured block, bottom-left | Session (= project) name. **The colour is stable per name** — `acme` is always the same colour, everywhere, forever. |
| Bright bar in the window list | The window you're in. Others are grey. |
| `2 claude ✓` in green | That Claude session **finished** and you haven't looked yet. |
| `3 api !` in yellow | That Claude session is **waiting for your input**. |
| ` main ✚3`, bottom-right | Branch of the focused pane + number of modified files. |
| `⑂` anywhere | You are in a **linked worktree**, not the main checkout. |
| Bright blue pane border | The focused pane. Unfocused Ghostty splits also dim to 82%. |
| `◆ claude` in the prompt | This shell was spawned by Claude Code, not by you. |
| `󰌌 PREFIX`, bottom-right | tmux is waiting for the second key of a prefix binding. |

The `✓` / `!` markers clear themselves the moment you switch to that window.

---

## tmux — prefix is `C-a`

### Sessions (one per project)
| Key | Action |
|---|---|
| `C-a f` | **Fuzzy project switcher** (the one you'll use most) |
| `C-a d` | Detach — leave everything running |
| `C-a s` | Visual session/window tree |
| `C-a $` | Rename session |
| `C-a Tab` | Last session |
| `C-a Q` | Kill session (asks first) |

From a plain shell: `tl` list · `ta <name>` attach · `tn <name>` new · `tk <name>` kill · `tsw` switcher.

### Windows (one per role: editor, claude, server, git)
| Key | Action |
|---|---|
| `C-a c` | New window (inherits current directory) |
| `C-a C` | New window running **Claude** |
| `C-a W` | Prompt for a branch, then Claude on a **fresh worktree** |
| `C-a ,` | Rename window — do this, it's how you find things later |
| `C-a 1`…`9` | Jump to window N |
| `C-a n` / `C-a p` | Next / previous window (repeatable) |
| `C-a Space` | Last window |
| `C-a X` | Kill window |

### Panes
| Key | Action |
|---|---|
| <code>C-a &#124;</code> | Split vertically (side by side) |
| `C-a -` | Split horizontally (stacked) |
| `C-a h j k l` | Move focus left / down / up / right |
| `C-a H J K L` | Resize (hold to repeat) |
| `C-a z` | Zoom the pane full-screen — toggle |
| `C-a x` | Kill pane |
| `C-a e` | Sync typing to **all** panes — toggle (careful) |
| `C-a q` | Show pane numbers |

### Popups (open over your work, close with `q` or `Esc`)
| Key | Action |
|---|---|
| `C-a g` | lazygit |
| <code>C-a &#96;</code> | Throwaway shell in the current directory |

### Copy mode (vi keys)
| Key | Action |
|---|---|
| `C-a [` or `C-a Enter` | Enter copy mode |
| `k j` `C-u` `C-d` | Move / half-page up / down |
| `/` then text, `n` | Search down, next match |
| `v` | Start selection · `C-v` for a rectangle |
| `y` | Copy to the macOS clipboard and exit |
| `q` | Leave copy mode |

Mouse works too: scroll to enter copy mode, drag to select (copies on release).

### Housekeeping
| Key | Action |
|---|---|
| `C-a r` | Reload config after editing `tmux/tmux.conf` |
| `C-a m` | Toggle mouse (turn off to select text with the terminal itself) |
| `C-a C-s` / `C-a C-r` | Save / restore all sessions (resurrect) |

Sessions auto-save every 15 min and **restore after a reboot** — just run `tmux`.

---

## Claude Code

### Launching
| Command | What it does |
|---|---|
| `c` | Start Claude here |
| `cc` | **Continue** the last session in this directory |
| `cr` | **Resume** — pick from a list of past sessions |
| `cy` | Start with edits auto-accepted |
| `cp-` | Start in plan mode (read-only until you approve a plan) |
| `cw <branch>` | New session on a dedicated git worktree |

### Inside a session
| Key | Action |
|---|---|
| `Shift+Tab` | Cycle permission mode: normal → auto-accept edits → plan |
| `Esc` | Interrupt Claude mid-work |
| `Esc` `Esc` | Rewind — go back and edit an earlier message |
| `Ctrl+C` | Cancel the current input |
| `Ctrl+D` | Exit |
| `Ctrl+L` | Clear the screen (not the conversation) |
| `↑` / `↓` | Previous prompts |
| `Ctrl+V` | Paste an image from the clipboard |
| `Option+Enter` | Newline without submitting |

### Typing shortcuts
| Prefix | Effect |
|---|---|
| `/` | Slash command — `/help` lists everything available right now |
| `@` | Mention a file or directory, with completion |
| `#` | Save the rest of the line to memory (`CLAUDE.md`) |
| `!` | Run the rest of the line as a shell command in the session |

### Slash commands worth knowing
`/help` · `/clear` (fresh context) · `/compact` (summarise and continue) · `/model` ·
`/cost` · `/status` · `/mcp` (server status + auth) · `/permissions` · `/memory` ·
`/init` (write a project CLAUDE.md) · `/review` · `/doctor` · `/terminal-setup`

### Running several sessions at once — the actual workflow

```
cd ~/dev/acme          # or C-a f to jump there
C-a C                  # window 2: Claude on the main checkout
cw fix-login           # window 3: Claude on its own worktree + branch
cw refactor-api        # window 4: another one, fully isolated
```

Each `cw` session has its **own checkout** in `~/dev/.worktrees/acme/<branch>`, so they never
fight over `git checkout`. Go do something else — the window list tells you who's done (`✓`)
and who needs you (`!`), and macOS notifies you either way.

| Command | Action |
|---|---|
| `cw <branch>` | Create/reuse a worktree + Claude window |
| `cw --list` | This repo's worktrees |
| `cw --rm <branch>` | Delete the worktree (keeps the branch) |
| `gwl` | `git worktree list` |

### Status line, left to right
`󰧑 model` · `directory` · ` branch ✚dirty` · `⑂ worktree` · `+lines/-lines` · `$cost`

### Config
- Global settings: `~/dotfiles/claude/settings.json` → `~/.claude/settings.json`
- Global instructions: `~/dotfiles/claude/CLAUDE.md`
- Per-project: `<repo>/CLAUDE.md` (write one with `/init`)
- MCP servers: `context7` (live library docs), `github` (issues/PRs/CI via your `gh` login)

---

## Shell

### Navigation
| Command | Action |
|---|---|
| `z <partial>` | Jump to a frecently-used directory — `z acm` → `~/dev/acme` |
| `zi` | Pick the directory interactively |
| `..` `...` `....` | Up 1 / 2 / 3 levels |
| `-` | Back to the previous directory |
| `d` | Recent directories; `cd -2` jumps to the 2nd |
| `mkcd <dir>` | Make a directory and enter it |
| `dot` | `cd ~/dotfiles` |

### fzf (fuzzy finder)
| Key | Action |
|---|---|
| `Ctrl+R` | Search command history |
| `Ctrl+T` | Insert a file path, with preview |
| `Alt+C` | cd into a subdirectory, with tree preview |
| `Ctrl+/` | Toggle the preview pane |
| `Ctrl+Y` | Copy the highlighted line to the clipboard |
| `Tab` | Multi-select (where allowed) |

Type letters in any order — `srcindx` matches `src/components/index.ts`.

### Listing and reading
| Command | Action |
|---|---|
| `ls` / `ll` / `la` | Compact / long+git / long+hidden (icons, dirs first) |
| `lt` / `ltt` | Tree, 2 levels / 4 levels |
| `cat <file>` | Syntax-highlighted (`bat`); `catn` adds line numbers |
| `ff <name>` | Find files (`fd`) |
| `fdir <name>` | Find directories |
| `rg <text>` | Search file contents; `rgh` includes ignored/hidden files |
| `glow <file.md>` | Render markdown in the terminal; `glow -p` for a pager |
| `glow` | Browse all markdown in the current directory (TUI, `q` quits) |

### Functions
| Command | Action |
|---|---|
| `cheat [term]` | This file, or grep it |
| `kb [term]` | Search the knowledge base, or browse it with fzf |
| `extract <archive>` | Unpack anything — zip, tar.gz, tar.xz, 7z… |
| `killport <port>` | Kill whatever holds a port |
| `ports` | What's listening right now |
| `gclone <url>` | Clone into `~/dev` and cd there |
| `gbr` | Fuzzy branch switcher with commit preview |
| `fkill` | Fuzzy process killer |
| `note [text]` | Append a timestamped line to today's note, or open it |

### macOS
| Command | Action |
|---|---|
| `ip` / `pubip` | LAN address / public address |
| `cpwd` | Copy the current path to the clipboard |
| `o <file>` / `oo` | Open in the default app / open the current folder in Finder |
| `www` | Serve the current directory on port 8000 and print the URL |
| `flushdns` | Flush the DNS cache |
| `showfiles` / `hidefiles` | Toggle hidden files in Finder |
| `pbcopy` / `pbpaste` | Clipboard in and out — `cat x.txt \| pbcopy` |

### Line editing (emacs keys, they work everywhere on macOS)
`Ctrl+A` start · `Ctrl+E` end · `Ctrl+W` delete word back · `Ctrl+U` clear line ·
`Ctrl+K` delete to end · `Option+←/→` move by word · `Ctrl+Space` accept the grey
suggestion · `Ctrl+X Ctrl+E` edit the command in vim.

Type a space before a command to keep it out of history.

---

## git

| Command | Action |
|---|---|
| `gs` | Short status with branch |
| `lg` / `lgs` | Graph log / with file stats |
| `gd` / `gds` | Diff unstaged / staged (side-by-side via delta) |
| `ga` `gaa` `gcm "msg"` | Stage / stage all / commit |
| `gco` `gsw` `gcb <new>` | Checkout / switch / create+switch |
| `gp` `gpl` `gf` | Push / pull / fetch+prune |
| `lz` | lazygit TUI |
| `git undo` | Undo the last commit, keep the changes staged |
| `git amend` | Amend without editing the message |
| `git wip` | Stage everything and commit as "wip" |
| `git cleanup` | Delete branches already merged into main |

Inside a delta diff: `n` / `N` jump between files. Push auto-creates the upstream branch.

Identity is `whiskeylotus <0xpentest@proton.me>` by default. Repos under `~/work/` pick up
`~/.config/git/config-work` if you create it (template: `git/config-work.example`).

---

## Ghostty

| Key | Action |
|---|---|
| <code>Ctrl+&#96;</code> | **Drop-down terminal over any app** — works from anywhere in macOS |
| `Cmd+T` / `Cmd+W` | New tab / close |
| `Cmd+D` / `Cmd+Shift+D` | Split right / down |
| `Cmd+Option+←↑↓→` | Move between splits |
| `Cmd+Shift+Enter` | Zoom a split |
| `Cmd+K` | Clear screen |
| `Cmd+Shift+R` | Reload config after editing |
| `Cmd+ +` / `-` / `0` | Font size |

Use Ghostty splits for throwaway side-by-sides; use tmux for anything you want to survive
closing the window.

---

## Where everything lives

```
~/dotfiles/            edit HERE, never the symlinks
  bootstrap.sh         re-run any time; safe and idempotent
  Brewfile             brew bundle --file=~/dotfiles/Brewfile
  zsh/                 zshenv · zprofile · zshrc · aliases.zsh · functions.zsh
  starship/            prompt
  ghostty/ tmux/ git/  terminal, multiplexer, vcs
  claude/              settings.json · CLAUDE.md · statusline.sh
  bin/                 tsw · cw · claude-notify · tmux-session-color · github-mcp
~/dev/                 projects
~/dev/.worktrees/      Claude worktrees, one dir per repo/branch
~/.zshrc.local         machine-local, untracked, sourced automatically
```

After changing a config: `reload` (zsh) · `C-a r` (tmux) · `Cmd+Shift+R` (Ghostty).

---

## Suggestions — when you want more

**Soon, probably**
- `/init` in each repo to write a project `CLAUDE.md`. Biggest single quality win for Claude.
- Custom slash commands: drop a markdown file in `~/.claude/commands/deploy.md` and get
  `/deploy` in every project. Same for `~/.claude/agents/` (custom subagents).
- `gh auth login`, then try `gh pr create --fill` and `gh pr checks --watch`.

**Language toolchains, when a project needs one**
- Node: `fnm install --lts` — already installed, activates per-directory via `.node-version`.
- Python: `brew install uv` — replaces pyenv + pip + virtualenv, and it's fast.
- `brew install direnv` for per-project env vars via a `.envrc`.

**Quality of life**
- `brew install atuin` — history in SQLite, searchable and synced across machines. Replaces
  `Ctrl+R`. The single biggest upgrade after this setup.
- `brew install --cask raycast` — Spotlight replacement with window management and clipboard
  history. Pairs well with the Ghostty quick terminal.
- `brew install --cask font-symbols-only-nerd-font` if you ever want icons in an app whose
  font you can't change.
- `brew install difftastic` then `git -c diff.external=difft diff` for syntax-aware diffs.

**Security / secrets**
- `brew install bitwarden-cli`, then `bw get password <item>` in scripts instead of putting
  keys in dotfiles. Keep them out of git entirely — `~/.zshrc.local` is untracked.
- Bitwarden can act as an SSH agent (enable in the desktop app) so your keys never sit
  unencrypted on disk.

**Keep the setup honest**
- `brew bundle dump --force --file=~/dotfiles/Brewfile` after installing something you want
  to keep, then commit. Next machine is one `bootstrap.sh` away.
- `brew bundle cleanup --file=~/dotfiles/Brewfile` lists what's installed but unrecorded.
