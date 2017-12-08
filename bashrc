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

# Useful functions
add_to_PROMPT_COMMAND() {
    for d; do
        case "$PROMPT_COMMAND;" in
            *"$d;"*) :;;
            *) PROMPT_COMMAND="$d; $PROMPT_COMMAND" ;;
        esac
    done
}

# History control
[[ -d ~/.history ]] || mkdir --mode=0700 ~/.history
[[ -d ~/.history ]] && chmod 0700 ~/.history
ttynum=`tty | sed -e "s:/dev/pts/::"`
HISTFILE=~/.history/history.$ttynum
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it


# Save and reload the history after each command finishes
# -- For some reason adding these individually as 'history -r' 'history -c' doesn't work, the history gets wiped after each new prompt
add_to_PROMPT_COMMAND "history -a; history -c; history -r"

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
alias jc='journalctl'
alias jcu='journalctl --user'
alias scu='systemctl --user'

if [[ -a ~/.bash-git-prompt/gitprompt.sh ]]; then source ~/.bash-git-prompt/gitprompt.sh; fi
if [[ -a ~/.git-completion.bash ]]; then source ~/.git-completion.bash; fi

