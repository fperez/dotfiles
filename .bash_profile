# ~/.bash_profile: executed by bash(1) for interactive login shells.

# Note that the traditional Unix design idea was to have a user's session
# contain a _single_ login shell, with all one-time actions taken there, and
# all subsequent interactive shells started as child processes of that one,
# thus inheriting its setup. Those interactive shells would then only load
# .bashrc. However, OSX starts each new terminal as a login shell, and
# JupyterLab terminals are also login shells. So it makes sense to configure
# this file to load .bashrc directly, and put most user configuration logic
# into .bashrc.

#echo '*** this is .bash_profile'

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

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
# <<< conda initialize <<<


if [ "$CONDA_DEFAULT_ENV" == "base" ] && [ -d "$CONDA_PREFIX/copip" ]
then
    #echo "*** DBG: default copip"  # dbg
    source $HOME/dev/copip/copipon.sh
else
    #echo "*** DBG: NO CONDA"  # dbg
    export JUPYTER_PATH=$HOME/.local/share/jupyter
fi


#############################################################################
# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
