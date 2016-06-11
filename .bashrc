# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
[ -z "$TMUX" ] && export TERM=xterm-256color



# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

#my alias
stty -ixon # disable ctrl-s in vim
alias ..='cd ..;ls'
alias js='node'
alias bi='bundle install'
alias be='bundle exec'
alias bp='vim ~/.bashrc'
alias vp='vim ~/.vimrc'
alias pp='vim ~/.pryrc'
alias tp='vim ~/.tern-project'
alias aa='cd ~/Documents/appacademy/'
alias l='ls -laH'
alias gs='git status'
alias gl='git log'
alias gc='git clone'
alias bes='bundle exec rspec'
alias besf='bundle exec rspec --fail-fast'
alias f='find -name'
alias rbp='source ~/.bashrc'
alias v='vim'
alias rm='rm -rf'
alias open='xdg-open'
alias rs='vim ~/.vim/bundle/vim-snippets/snippets/ruby.snippets'
alias snippets='cd ~/.vim/bundle/vim-snippets/snippets/'
alias n='nautilus .'
alias cp='cp -r'
alias b='cd -'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias fping='ping -c 100 -s.2'
alias ping='ping -c 5'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias top='atop'
alias p='cd ~/.vim/bundle'
#rails development
alias routes='rake routes'
alias migrate='rake db:migrate'
alias create='rake db:create'
alias model='rails g model'
alias controller='rails g controller'
alias destroy='rails destroy'
alias mailer='rails g mailer'
alias s='rails s'
alias rc='rails c'
alias brake='bundle exec rake db:migrate db:test:load'
alias names='grep -r "click_" spec/ | uniq > link_names'
alias railspid='lsof -wni tcp:3000'
alias unode='curl https://raw.githubusercontent.com/isaacs/nave/master/nave.sh | sudo bash -s -- usemain latest'
#allows vi commands at terminal
set -o vi 

#scripts


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

gg () {
	git add -A
	git commit -m "$1"
	git push
  git log
}


aae () {
    aa
    mkcd $1/exercises
}

guards () {
    cp ~/Documents/appacademy/gems/Gemfile .
    cp ~/Documents/appacademy/gems/Guardfile .
    bundle install --without rails railtest
    bundle exec guard
}

guardr () {
    cp ~/Documents/appacademy/gems/Gemfile .
    cp ~/Documents/appacademy/gems/Guardfile .
    bundle install --without sql
    bundle exec guard
}
