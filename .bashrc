#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vifm='vifmrun'
# alias truth="cowsay \">tfw you are a failure and you're never gonna have a gf but at least you have a collection of half-naked anime girls to jerk off to.\""
alias ff='nvim $(find . -type f | fzy)'
alias config='/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}'
# alias tmux='TERM=xterm-256color tmux'

alias sr='sr -browser=firefox'
alias srl='sr google -l'
alias srg='sr google'
alias s='srg'

# alias feh='feh --auto-zoom --scale-down --image-bg "#000000"'

_bold="\[\e[1m\]"
_green="\[\e[32m\]"
_blue="\[\e[34m\]"
_reset="\[\e[0m\]"
PS1="${_bold}[${_green}\u@\h ${_blue}\w${_reset}]\$ "

source /usr/share/doc/pkgfile/command-not-found.bash
source /usr/share/git/completion/git-completion.bash
