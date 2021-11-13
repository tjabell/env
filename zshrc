[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# case $(tty) in /dev/tty[0-3]*)
#  tbsm ;;
# esac

# Path to your oh-my-zsh installation.
export ZSH="/home/trevor/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# Removing zsh_reload - deprecated in favor of omz reload or exec zsh
plugins=(git z)

source $ZSH/oh-my-zsh.sh

# User configuration
SAVEHIST=10000
HISTSIZE=5000
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias -g sc=systemctl
alias -g NF='./*(oc[1])'

# Append "$1" to $PATH when not already in.
# This function API is accessible to scripts in /etc/profile.d
# Borrowed form /etc/profile 
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}

# Android paths
export ANDROID_HOME=$HOME/Android/Sdk
# append_path $ANDROID_HOME/emulator
# append_path $ANDROID_HOME/tools
# append_path $ANDROID_HOME/tools/bin
# append_path $ANDROID_HOME/platform-tools


# Rust Paths
if [ -f ~/.cargo/env ]; then
   source ~/.cargo/env
fi

# Python Paths
append_path $HOME/.local/bin

alias -g ssc='sudo systemctl'
alias -g mc='machinectl'
alias -g sm='start-machine'
alias -g sc=systemctl
alias -g jc=journalctl
alias -g startdb='sudo systemctl start mssql-server'

alias hn=hostname
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
alias scucron='systemctl --user list-timers'
alias se='scu start emacs'
alias mcs='sudo machinectl start '
alias xclips='xclip -selection clipboard'
alias noderl="env NODE_NO_READLINE=1 rlwrap node"
alias cl=catls

function tm {
  TMUXNAME=${1:-"default"}

  if tmux ls | grep "^$TMUXNAME:"; then
    tmux attach -d -t $TMUXNAME
  else
    tmux new -s $TMUXNAME
  fi
}

# catls - either list a directory or cat a file
catls() {
  [[ -f "$1" ]] && cat "$1" || ls "$1";
}

mkcd () {
  case "$1" in
    */..|*/../) cd -- "$1";; # that doesn't make any sense unless the directory already exists
    /*/../*) (cd "${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd -- "$1";;
    /*) mkdir -p "$1" && cd "$1";;
    */../*) (cd "./${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd "./$1";;
    ../*) (cd .. && mkdir -p "${1#.}") && cd "$1";;
    *) mkdir -p "./$1" && cd "./$1";;
  esac
}

if command -v keychain; then
    eval $(keychain --eval --quiet id_ecdsa id_rsa)
fi
alias desktop=startplasma-wayland

# Add gem bin to path
export GEM_HOME=$(ruby -e 'print Gem.user_dir')
if which ruby>/dev/null && which gem>/dev/null; then
    # make idempotent by checking path contains gem dir already
    if ruby -r rubygems -e 'exit(!ENV["PATH"].include?(Gem.user_dir))'; then
        append_path "$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
    fi
fi

if which dotnet>/dev/null && which dotnet>/dev/null; then
    DOTNET_TOOLS_DIR=/home/trevor/.dotnet/tools

    if [[ :$PATH: == *:"$DOTNET_TOOLS_DIR":* ]] ; then
        #export PATH="$DOTNET_TOOLS_DIR:$PATH"
    else
        append_path "$DOTNET_TOOLS_DIR:$PATH"
    fi
fi

# Node paths
append_path ~/.node_modules/bin

# Go Path
append_path ~/go/bin

alias reboot-into-windows="systemctl reboot --boot-loader-entry=auto-windows"
alias dt=desktop
alias sp='sudo pacman'
alias hibernate='systemctl hibernate'


# whence - 'type -P' in zsh
[[ $(typeset pacman) ]] && {
    alias update='sudo pacman -Sy'
    alias upgrade='sudo pacman -Syu'
    alias upgrade-aur="sudo aura -Akuax"
}

alias -g scu="systemctl --user"
alias -g scult='systemctl --user list-timers'
alias -g sclt='systemctl list-timers'
alias -g startdb='sudo systemctl start mssql-server'
alias -g stopdb='sudo systemctl stop mssql-server'

alias lock='swaylock -c 005678'
alias upgrade=sudo pacman -Syu

vterm_printf(){
    if [ -n "$TMUX" ]; then
        # Tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
        vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
        shift
    done
    vterm_printf "51;E$vterm_elisp"
}

vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}

setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

# Alacritty
alias at='alacritty-themes'

# Z config
if command -v z; then
    . /usr/share/z/z.sh
fi

# npm global config
append_path ~/.npm-global/bin:$PATH
