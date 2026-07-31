# Aliases. `alias` with no args lists everything live; `cheat` opens the cheatsheet.

# ------------------------------------------------------------ files / nav ----
alias ls='eza --group-directories-first --icons=auto'
alias ll='eza -l --group-directories-first --icons=auto --git --time-style=relative'
alias la='eza -la --group-directories-first --icons=auto --git --time-style=relative'
alias lt='eza --tree --level=2 --icons=auto --group-directories-first'
alias ltt='eza --tree --level=4 --icons=auto --group-directories-first'
alias l.='eza -ld .* --icons=auto'

alias cat='bat --style=plain'
alias catn='bat --style=numbers'
alias less='bat --style=plain --paging=always'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias d='dirs -v | head -10'          # recent dirs; `cd -2` to jump

alias md='mkdir -p'
alias cpr='cp -R'
alias rmf='rm -rf'
alias df='df -h'
alias du='du -h'
alias dus='du -sh * | sort -h'

# ----------------------------------------------------------------- search ----
alias grep='grep --color=auto'
alias rgh='rg --hidden --no-ignore'   # search everything, including ignored files
alias ff='fd --type f'                # find file
alias fdir='fd --type d'              # find directory

# -------------------------------------------------------------------- git ----
alias g='git'
alias gs='git status --short --branch'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gsw='git switch'
alias gb='git branch'
alias gd='git diff'
alias gds='git diff --staged'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch --all --prune'
alias gst='git stash'
alias gwl='git worktree list'
alias lg='git log --color=always --graph --format="%C(bold 242)%<|(11)%h -%C(172)%d%C(reset) %s %C(243)(%cr) %C(69)<%an>%C(reset)"'
alias lgs='lg --stat'
alias lz='lazygit'

# ----------------------------------------------------------------- claude ----
alias c='claude'
alias cc='claude --continue'          # resume the most recent session here
alias cr='claude --resume'            # pick a past session from a list
alias cy='claude --permission-mode acceptEdits'   # auto-accept file edits
alias cp-='claude --permission-mode plan'         # start in plan mode
alias cmcp='claude mcp list'

# ------------------------------------------------------------------ tmux ----
alias t='tmux'
alias ta='tmux attach -t'
alias tat='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'
alias tk='tmux kill-session -t'
alias tks='tmux kill-server'

# ----------------------------------------------------------------- macOS ----
alias ip='ipconfig getifaddr en0'                       # LAN address (wifi)
alias ips="ifconfig -a | rg 'inet ' | rg -v 127.0.0.1"
alias pubip='curl -s https://ifconfig.me && echo'
alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias o='open'
alias oo='open .'
alias cpwd='pwd | tr -d "\n" | pbcopy'                  # copy cwd to clipboard
alias www='echo "http://$(ipconfig getifaddr en0):8000" && python3 -m http.server 8000'

# ------------------------------------------------------------------ misc ----
alias reload='exec zsh'
alias zshrc='$EDITOR $DOTFILES/zsh/zshrc'
alias dot='cd $DOTFILES'
alias path='echo -e ${PATH//:/\\n}'
alias ports='lsof -iTCP -sTCP:LISTEN -n -P'
alias top='btop'
alias h='history'
alias brewup='brew update && brew upgrade && brew cleanup'
