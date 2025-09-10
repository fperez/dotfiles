# .bashrc - started by interactive non-login shells

# Keep ONLY interactive configuration stuff (aliases, ect) here.
# All "quiet" configuration (paths, etc) should go to .bash_env

#echo '*** this is .bashrc ***' # dbg

# On macOS - New iTerm windows/tabs do NOT run this file by default, unless
# it gets explicitly sourced from ~/.bash_profile.

# On JupyterHub - new terminals run only this file, and NOT .bash_profile.

# useful: http://tldp.org/LDP/abs/html/sample-bashrc.html

# Contact: Fernando Pérez <fdo.perez@gmail.com>

# Start by loading all "quiet" configuration
[[ -r ~/.bash_env ]] && . ~/.bash_env


############################################################################
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Only load system bash_completion if it hasn't been read yet (it defines some
# read-only variables and will error out if you read it twice).
if [[ -z $BASH_COMPLETION && -e /etc/bash_completion ]]; then
    source /etc/bash_completion
fi

############################################################################
# Configure shell for git usage - these two are static copies of git utils

if [ -f $HOME/.git-completion.bash ]; then
    . $HOME/.git-completion.bash
fi

if [ -f $HOME/.git-prompt.sh ]; then
    . $HOME/.git-prompt.sh
fi

##############################################################################
#
# Environment variables relevant only for interactive usage
#

export EDITOR=emacs
export CSHEDIT=emacs
export ENSCRIPT=-MLetter
export PAGER=less
#export LESS=-r  # Seems to cause problems on OSX

# Locale configuration
#export LANG=en_US.UTF-8
#export LC_ALL=en_US.UTF-8

# readline config
export INPUTRC=$HOME/.inputrc

# Avoid duplicates in history
export HISTIGNORE="&:exit"

# change colors defaults: swap directory/link (cyan is easier to see for dirs)
export LS_COLORS='no=00:fi=00:di=01;36:ln=01;34:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jpg=01;35:*.png=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:'

# Default options for ACK
export ACK_OPTIONS=--text

############################################################################
#
# aliases
#

if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "linux"* ]]; then
    alias ls='/bin/ls -F --color=tty'
    alias d="pwd; ls -o"
    alias dd='pwd; ls --color -o | grep /$'
    alias dx='pwd; ls --color -o | grep ^-..x'
    alias dp='pwd; ls --color -o | grep ^-..x'
    alias dl='pwd; ls --color -o | grep ^l'
    alias yup='sudo apt-get update;sudo apt-get -y --force-yes dselect-upgrade';
    alias pfox='firefox -new-instance -ProfileManager &'
    alias nocaps='setxkbmap -option "ctrl:nocaps"'
    alias ccopy='xclip -in -selection c'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias ls='/bin/ls -FG'
    alias d="pwd; ls -o"
    alias dd='pwd; ls -o | grep /$'
    alias dx='pwd; ls -o | grep ^-..x'
    alias dp='pwd; ls -o | grep ^-..x'
    alias dl='pwd; ls -o | grep ^l'
    alias git=hub
    alias cdiff='git diff --no-index'
    alias bup='brew update && brew upgrade'
    alias tmoff='diskutil unmount /Volumes/Time\ Machine\ -\ Seagate\ Silver'
    alias today='date "+%b %d, %Y" | tr -d "\n" | pbcopy'
    alias add='pbcopy < $HOME/.address'
    alias pbclean='pbpaste | pbcopy'
    alias emacsapp='open -a /Applications/Emacs.app/'
    alias fixaudio='sudo killall coreaudiod'  # fix logitech webcam audio loop
    alias fixbluetooth='sudo pkill bluetoothd'  # fix logitech webcam audio loop
else
    echo "No OS-specific aliases, OS unknown.";
fi

# Various update aliases
alias mm='micromamba'
alias mamba='micromamba'
#alias cup='micromamba update --all --yes'
alias cup='mamba update --all --yes'
alias cclean='mamba clean -pity'
alias cnuke='mamba remove --all --yes -n'
alias mrup='mr -d $HOME update'

# other everyday aliases
alias r2d='jupyter-repo2docker'
alias pd=pushd
alias pop=popd
alias cl=clear
alias lo=exit
alias e=echo
alias c=cd
alias h=cd        # home
alias u="cd .."   # up
alias p="cd -"    # previous
alias o="cd ..;cd \!^ ; pwd" # up and cd
alias over="cd ..;cd \!^ ; pwd"  # same as o
alias clk='rm -f *~ .*~ *.bak .dircopy.log;rm -rf .ipynb_checkpoints'
alias clu='rm -f *~ .*~ *.bak .dircopy.log;rm -rf .ipynb_checkpoints;rm -f [Uu]ntitled*'
alias clk2='rm -f $(find . -name "*~")'
alias clp='rm -f *~ .*~ *.pyc *.pyo'
alias ec='emacs -nw ~/.bashrc'
alias sc='source ~/.bashrc'
alias sutil='source ~/.bash_utils'
alias igrep='egrep -i'
alias ig='egrep -i'
alias dfsumm="df -h | head -1 ; df -h | grep -v '^File' | sort"
alias dus='du -s * . | sort -n'
alias whoelse='date; who | grep -v `whoami` | sort '
alias hist='history | cut -d " " -f 5-'
alias gt='gnome-terminal . &'
alias tm='tmux attach || tmux'
alias livelines="egrep -v '^#|^$'"
alias nocomment='grep "^[:space:][^#]"'
alias dm='docker-machine'
alias dmon='eval "$(docker-machine env default)"'
alias lc="rename 'tr/[A-Z]/[a-z]/'"
alias showip='ifconfig | grep "inet "'

# Found at http://separaterealities.com/blag/?p=25
# Useful way to quickly remember the CWD from one shell to reuse it in others.
alias saved='echo pwd > ~/.savedir'
alias showd='cat ~/.savedir'
alias god='cd `cat ~/.savedir`'

# Git-related aliases
alias gcmb="git branch --merged | grep -Ev '(^\*|master)' | xargs git branch -d"

# Identify tabs in files
alias findtabs='grep -n "\t"'

# Make a directory of small pics for email
alias imresizeall="imresize --outdir=small *.jpg *.JPG"

# Emacs-related aliases
# Plain-terminal emacs
alias em='emacs -nw'
# Fast-starting emacs
alias emq='emacs -nw --no-init-file --no-site-file --load $HOME/.emacs.conf.d/init-minimal.el'
# start emacsclient to quickly open a file in a running emacs
alias emc='emacsclient -c -n'
# Avoid biber/biblatex incompatibilities in tectonic
# See https://github.com/tectonic-typesetting/tectonic/issues/893#issuecomment-1592466609
alias tect='tectonic -Z search-path=/usr/local/texlive/2023/texmf-dist/tex/latex/biblatex'

alias make2dag='make -Bnd | make2graph | dot -Tpng -o make-dag.png'

# Fix function keys on apple keyboard for linux systems
#alias fix_apple_kbd='echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode'

alias t='time'

alias f='find . | grep '

# Git-based management of dot files and basic $HOME setup
# See https://github.com/fperez/dotfiles 
# and https://github.com/fperez/homesetup
# for details
alias gdot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias ghome='git --git-dir=$HOME/.homesetup --work-tree=$HOME'

# Aliases for the fpsync script in various modes, as well as other simple
# synchronization calls

ETC=$HOME/usr/etc

# Convenience fpsync wrapper with message, wait and timing
function hsync {
    local host=${1:-"longs"}
    local mode=${2:-"sync"}

    if [[ "$mode" == "up" ]]; then
        echo "*** Destructive upload to: $host"
    elif [[ "$mode" == "down" ]]; then
        echo "*** Destructive download from: $host"
    else
        echo "*** Two-way sync with: $host"
    fi
    echo "*** Sleeping for 2 seconds..."
    sleep 2
    time fpsync --host $host $mode

}

# Sync with longs, server in Stats office at Berkeley
alias longssync-up='hsync longs up'
alias longssync-down='hsync longs down'

# Sync with ritacuba, home desktop. Only works in home network.
alias ritacubasync-up='hsync ritacuba up'
alias ritacubasync-down='hsync ritacuba down'

# Aliases for finding/cleaning sync conflicts arising from Dropbox/Syncthing
alias fconf="find -E . -regex '\.\/.*sync-conflict.*|\.\/.*conflicted copy.*' -print"
alias fconfd="find -E . -regex '\.\/.*sync-conflict.*|\.\/.*conflicted copy.*' -exec rm {} \;"

##############################################################################
#
# Python config: environment variables and aliases
#

# Set startup file for interactive sessions
#export PYTHONSTARTUP=$HOME/.pythonstartup.py

# Python aliases
alias fdbg="egrep -n 'dbg|debugx\(' *py */*.py */*/*.py */*/*/*.py | egrep -v '\.dbg|def debugx|\:[[:space:]]*\#'"
alias fdbgc="egrep -n 'dbg' *.c *.C *.cxx *.cpp | egrep -v '\:[[:space:]]*\//'"

# IPython config
alias ip='ipython'

# alias pycolor="pygmentize -l python -f terminal16m -O style=monokai"
# alias pyg="pygmentize -f terminal16m -O style=monokai"

# "cli calculator" to execute any valid Python expression
alias pyx="python -c \"import sys;from math import *;print(eval(' '.join(sys.argv[1:])))\" "

##############################################################################
#
# Interactive login shell configuration

# My usual login name on most machines.  This file is set to display any login
# that is NOT this one in red (root, when I log into machines with an atypical
# login, etc.).
export MYLOGIN="fperez"

# Interactive prompt
if [[ "$WHOAMI" == "$MYLOGIN" ]]; then
    USERNAME=""
else
    USERNAME="$WHOAMI@"
fi

# Declare the main prompt.
# Note - bash accepts the following special chars in PS1 strings:
# \u = username
# \h = hostname
# \W = current working directory

if [[ "$TERM" == "dumb" ]]; then  # no colors
    PS1="${USERNAME}\h[\W]> "
elif [[ "$WHOAMI" == "jovyan" ]]; then
    PS1="$GREEN\$(__git_ps1 '(%s)')$L_BLUE\h[$L_CYAN\W${L_BLUE}]$L_GREEN> $NO_COLOR"

    #PS1="$GREEN\$(__git_ps1 '(%s)')$L_RED${USERNAME}${L_BLUE}JupyterHub[$L_CYAN\W${L_BLUE}]$L_GREEN> $NO_COLOR"
else
    PS1="$GREEN\$(__git_ps1 '(%s)')$L_RED${USERNAME}$L_BLUE\h[$L_CYAN\W${L_BLUE}]$L_GREEN> $NO_COLOR"
    #PS1="$L_RED${USERNAME}$L_BLUE\h[$L_CYAN\W${L_BLUE}]$L_GREEN> $NO_COLOR"
fi

# Various options for interactive behavior
if [[ "$-" =~ "i" ]]; then
    shopt -s cdspell
    shopt -s cmdhist
    shopt -s dotglob
    shopt -s extglob

    # bind a few keys to search patterns
    bind '"\e[A"':history-search-backward
    bind '"\e[B"':history-search-forward
    bind "C-p":history-search-backward
    bind "C-n":history-search-forward
fi

########################################################################
# macOS-specific settings and configuration, not needed when running on
# Linux hosts (typically JupyterHub/cloud deployments).

if [[ "$OSTYPE" == "darwin"* ]]; then

    # Mamba config
    #
    # On macOS shells launched via JupyterHub/JupyterLab, .bash_profile is NOT
    # called, as they are **interactive non-login shells** (which only call
    # .bashrc). Therefore, we need to repeat the mamba initialization sequence
    # here. 
    # We need to initialize mamba in two different scenarios:
    # 1 - if MAMBA_ROOT_PREFIX hasn't been set at all.
    # 2 - if MAMBA_ROOT_PREFIX HAS been set, but it was inherited from the parent process. This happens when a terminal started by a LOCAL JupyterLab (i.e one started with the `juptyer lab` command and NOT launched by a JupyterHub server) is running.  

    # The logic below detects either of these cases, so we also initialize mamba in jupyterlab terminals that would otherwise throw an error when calling `mamba activate` despite having MAMBA_ROOT_PREFIX set.  

    # This snippet should work to configure 

    # In all environments that do call .bash_profile (e.g. iTerm or ssh
    # logins), that has already been run and MAMBA_ROOT_PREFIX will have been set,
    # so we trigger on that variable.

    if [[ -z "$MAMBA_ROOT_PREFIX" || ( -n "$JUPYTER_SERVER_URL" && -z "$JUPYTERHUB_BASE_URL" ) ]]; then
        #echo "*** mamba init in bashrc, not done previously ***"  # dbg
        # >>> mamba initialize >>>
        # !! Contents within this block are managed by 'micromamba shell init' !!
        export MAMBA_EXE='/Users/fperez/.local/bin/micromamba';
        export MAMBA_ROOT_PREFIX='/Users/fperez/.local/share/mamba';
        __mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__mamba_setup"
        else
            alias micromamba="$MAMBA_EXE"  # Fallback on help from micromamba activate
        fi
        unset __mamba_setup
        # <<< mamba initialize <<<

    fi

    # Activate base mamba environment for everyday work
    micromamba activate base

    # iterm2 integration
    [[ -r ~/.iterm2_shell_integration.bash ]] && . ~/.iterm2_shell_integration.bash

fi # end darwin-specific config

#**********************  END OF FILE <.bashrc> *******************************
