# Bash commands

alias ll='ls -alF'
alias grep='grep --color=auto'
alias ..='cd ..'
alias mkdir='mkdir -p'
alias cpr='cp -R'

# Misc
list_ips() {
  ip a show scope global | awk '/^[0-9]+:/ { sub(/:/,"",$2); iface=$2 } /^[[:space:]]*inet / { split($2, a, "/"); print "[\033[96m" iface"\033[0m] "a[1] }'
}

ls_pwd() {
  echo -e "[\e[96m`pwd`\e[0m]\e[34m" && ls && echo -en "\e[0m"
}

mkdir_cd() {
  mkdir $1 && cd $_
}

alias www="list_ips && ls_pwd && sudo python3 -m http.server 8000"
alias tun0="ifconfig tun0 | grep 'inet ' | cut -d' ' -f10 | tr -d '\n' | xclip -sel clip"

# Nmap related
alias get_ports="awk -F/ '/open/ {printf \"%s%s\",sep,\$1,sep=\",\"} END{print \"\"}'"

do_nmap(){
  sudo nmap -p$(sudo nmap -p- --open --min-rate=3000 -Pn $1 | get_ports) -sCV -oN $1.nmap $1
}

get_nmap_rst(){
  ~/dotfiles/scripts/get-rst-from-nmap.sh $1;
}

# Git related
alias lg="git log --color=always --graph --format='%C(bold 242)%<|(11)%h -%C(172)%d%C(reset) %s %C(243)(%cr) %C(69)<%an>%C(reset)'"

# TTY upgrades
py_tty_upgrade () {
  echo "python -c 'import pty;pty.spawn(\"/bin/bash\")'"| xclip -sel clip
}
py3_tty_upgrade () {
  echo "python3 -c 'import pty;pty.spawn(\"/bin/bash\")'"| xclip -sel clip
}
alias script_tty_upgrade="echo '/usr/bin/script -qc /bin/bash /dev/null'| xclip -sel clip"
alias tty_fix="stty raw -echo; fg; reset"
alias tty_conf="stty -a | sed 's/;//g' | head -n 1 | sed 's/.*baud /stty /g;s/line.*//g' | xclip -sel clip"

export PYTHONPYCACHEPREFIX=~/.cache/cpython
export PATH=~/.local/bin:$PATH
