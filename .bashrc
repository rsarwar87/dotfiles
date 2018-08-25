# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
export HISTFILE=~/.bash_eternal_history

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s histappend
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)

# set a fancy prompt (non-color, unless we know we "want" color)
LS_OPTIONS='--color=auto'
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
color_prompt=yes

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
    PS1="\[\033[01;32m\]\u@\h\[\033[00m\] : \[\033[01;34m\]\w\[\033[00m\]\n\$ "
 else
    PS1='\u@\h : \w\ \n $ '
fi
unset color_prompt force_color_prompt

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#function setenv() { export "$1=$2";  }
function setalias() { alias "$1=$2";  }
function setexporta() { eval param=\$$1;  export $1=$2:$param; }
function setexport() { export "$1=$2"; }

source ~/.env

if [ "$(uname)" = "SunOS"  ]; then
   alias tree='ls -R | grep ":$" | sed -e '"'"'s/:$//'"'"' -e '"'"'s/[^-][^\/]*\//--/g'"'"' -e '"'"'s/^/   /'"'"' -e '"'"'s/-/      |/'"'"
    if [ -x /usr/local/depot/vim-7.4/bin/vim   ]; then
        alias vim='/usr/local/depot/vim-7.4/bin/vim'
    fi
    export TERM=dtterm
    
    alias ls='gls $LS_OPTIONS'
    alias ll='ls $LS_OPTIONS -laF'
    [ -n "$XTERM_VERSION"  ] && transset-df --id "$WINDOWID" >/dev/null
    alias l='ls $LS_OPTIONS -lF'
    alias dir='gdir $LS_OPTIONS'
    alias grep='grep $LS_OPTIONS'
    alias egrep='fgrep $LS_OPTIONS'
    alias fgrep='egrep $LS_OPTIONS'


else
   source ~/.env_linux
   # if [ ! -x /usr/bin/dircolors ]; then
   #    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
   #    alias ls='ls --color=auto'
   #    #alias dir='dir --color=auto'
   #    #alias vdir='vdir --color=auto'

   #    alias grep='grep --color=auto' 
   #    alias fgrep='fgrep --color=auto'
   #    alias egrep='egrep --color=auto'
   # fi
fi

set -o ignoreeof
# some more ls aliases
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

if hash fish 2>/dev/null; then
   fish "$@"; exit
fi
# main  var
#alias logvpn='sudo /opt/forticlientsslvpn/forticlientsslvpn_cli --server vpn.ukaea.uk:943 --vpnuser=rsarwar'

