# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.


# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background

# Put your fun stuff here.
if [[ -a /usr/bin/virtualenvwrapper.sh ]]; then source /usr/bin/virtualenvwrapper.sh; fi
if [[ -a /usr/bin/virtualenv-lazy.sh ]]; then source /usr/bin/virtualenv-lazy.sh; fi
if [[ $PATH != */home/trevor/root/bin* ]]; then PATH=$PATH:/home/trevor/root/bin; fi

export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

alias psc='ps xawf -eo pid,user,cgroup,args'
alias ec='emacsclient -c'
alias ll='ls -Al --color'
alias l='ls -AlG'
alias psc='ps xawf -eo pid,user,cgroup,args'
alias sdc='systemd-cgls'
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
if [[ $EUID -eq 0 ]]; then
    PS1="(su) $PS1"
fi
export PS1

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export TERM=xterm-256color

alias sc='systemctl'
alias jc='journalctl --user'
alias scu='systemctl --user'

if [[ -a ~/.bash-git-prompt/gitprompt.sh ]]; then source ~/.bash-git-prompt/gitprompt.sh; fi
if [[ -a ~/.git-completion.bash ]]; then source ~/.git-completion.bash; fi

export GEM_HOME=$(ruby -e 'print Gem.user_dir')
if which ruby>/dev/null && which gem>/dev/null; then
    # make idempotent by checking path contains gem dir already
    if ruby -rubygems -e 'exit(!ENV["PATH"].include?(Gem.user_dir))'; then
        PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
    fi
fi

man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
alias mc='machinectl'
alias gru='git remote update'
alias gru='git remote update'
alias ssheasy='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=No'
alias scpeasy='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=No'
alias mosheasy='mosh --ssh="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=No"'
alias workin='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=No -Y'
alias printpirate='echo -e "\xE2\x98\xA0"'
alias tmux='TERM=xterm-256color tmux'
alias mcls='machinectl list-images'
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '
alias emacsq='emacs -Q -nw'
alias se='scu start emacs'
alias mcs='sudo machinectl start '
