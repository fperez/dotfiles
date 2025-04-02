# .bashrc - started by interactive non-login shells

# echo '*** this is .bashrc' # dbg

# On macOS - New iTerm windows/tabs do NOT run this file by default, unless
# it gets explicitly sourced from ~/.bash_profile.

# On JupyterHub - new terminals run only this file, andf NOT .bash_profile.

# useful: http://tldp.org/LDP/abs/html/sample-bashrc.html

# Contact: Fernando Pérez <fdo.perez@gmail.com>

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

############################################################################
# My usual login name on most machines.  This file is set to display any login
# that is NOT this one in red (root, when I log into machines with an atypical
# login, etc.).
export MYLOGIN="fperez"

############################################################################
# Load basic bash utilities (handy functions and constants)
if [ -f $HOME/.bash_utils ]; then
    . $HOME/.bash_utils
fi

############################################################################
# Load private info not kept in public version control
if [ -f $HOME/.bash_secrets ]; then
    . $HOME/.bash_secrets
fi

# Initialize $PATH with homebrew and conda locations so I can find their tools
# when working over SSH (such as remote rsync calls)
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:$PATH

# Configure paths, using the path generation functions in .bash_utils
#
# These are the prefixes I typically use as --prefix options for installation 
# of packages.  There's a method to the madness of having several of them, and
# in this order.  The ones at the TOP end up first in the generated path specs,
# so they take precedence.
pfx="$pfx $HOME/tmp/junk"  # quick and dirty testing
pfx="$pfx $HOME/usr"  # codes *I* have written
pfx="$pfx $HOME/usr/local"  # default prefix for third-party installs
pfx="$pfx $HOME/.local"  # used by python in --user installs

# Now, set all common paths based on the prefix list just built.  The
# export_paths function ensures that all commonly needed paths get correctly
# set and exported to the environment.
export_paths "$pfx"

#echo "stop here"  && return

# Default prefix for personal installs I use.
export PREFIX=$HOME/usr/local

# This is the name CMAKE uses for the same thing
export CMAKE_INSTALL_PREFIX=$PREFIX

# Search paths for LaTeX (Dont' forget the final colons.  The null entry `::'
# denotes `default system directories' -- try finding that in the
# documentation.)  Note that these *must* go under ~/texmf, because that
# particular path is hardcod ed in LaTeX and is not overridable by the user.
# While one could keep ~/texmf for default package installs and use other
# locations for {tex/bib/bst}inputs, I prefer to centralize all Tex stuff in
# one place.  Since I can't do it in ~/usr/tex, then I'll just keep everything
# TeX related in ~/texmf
export TEXINPUTS=.:$HOME/texmf/texinputs::
export BIBINPUTS=.:$HOME/texmf/bibinputs::
export BSTINPUTS=.:$HOME/texmf/bstinputs::

# Seaborn's data cache
export SEABORN_DATA=$HOME/local/seaborn-data

##############################################################################
#
# other environment variables
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
alias cup='mamba update --all --yes'
alias aup='conda update --all --yes'
alias cclean='conda clean -pity'
alias cnuke='conda remove --all --yes -n'
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
# Mamba/Conda configuration for environment management

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/fperez/local/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/fperez/local/conda/etc/profile.d/conda.sh" ]; then
        . "/Users/fperez/local/conda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/fperez/local/conda/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/fperez/local/conda/etc/profile.d/mamba.sh" ]; then
    . "/Users/fperez/local/conda/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# DEACTIVATED - copip setup.
# # My own conda-pip overlay - code here: https://github.com/fperez/copip
# if [ "$CONDA_DEFAULT_ENV" == "base" ] && [ -d "$CONDA_PREFIX/copip" ] && [ -f "$HOME/dev/copip/copipon.sh" ]
# then
#     #echo "*** DBG: default copip"  # dbg
#     source $HOME/dev/copip/copipon.sh
# else
#     #echo "*** DBG: NO CONDA"  # dbg
#     export JUPYTER_PATH=$HOME/.local/share/jupyter
# fi

# # Conda environments
# alias con="source $HOME/dev/copip/cactivate"  # this one opens a subshell

# Always direct pip installations to --user location
# export PIP_USER=True  # should only be activated when using copip

#**********************  END OF FILE <.bashrc> *******************************
