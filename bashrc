#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
# HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1024

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Setup a nice prompt.
source ~/.git-prompt.sh
source /usr/share/git/completion/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
BLUE="\[$(tput setaf 4)\]"
ORANGE="\[$(tput setaf 3)\]"
UNDERLINE="\[$(tput smul)\]"
BOLD="\[$(tput bold)\]"
RESET="\[$(tput sgr0)\]"
# According to git-prompt.sh, __git_ps1 output is inserted between the two
# string arguments. To update xterm window title string, we append the
# original PROMPT_COMMAND value.
PROMPT_COMMAND='__git_ps1 "${UNDERLINE}${BLUE}\w${ORANGE}" "${RESET}${BOLD}\$${RESET} ";'$PROMPT_COMMAND

# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    # alias grep='ack-grep --color'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias diff='colordiff'
# colored wdiff
function cwdiff () { wdiff -n $@ | colordiff; }

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# alias for virtualenv
# > virtualenv wrapper settings
# I use python3 and virtualenv-3.5,
# the 3 should match a 3-versioned virtualenv.
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv
export WORKON_HOME=$HOME/virtualenvs
export PROJECT_HOME=$HOME/workspace
source /usr/bin/virtualenvwrapper.sh

## alias for git
alias gt='git st'
alias gl='git la'
alias gd='git diff'

## alias to pretty print json string
alias json='python -m json.tool'

export EDITOR="vim"
export PATH=$PATH:$HOME/.gem/ruby/2.3.0/bin/
