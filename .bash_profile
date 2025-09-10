# ~/.bash_profile: executed by bash for interactive login shells.

#echo '*** this is .bash_profile ***'  # dbg

# On macOS - New iTerm windows/tabs run this file, but NOT .bashrc.
#   .bashrc is also NOT executed even for ssh logins.
# On JupyterHub/JupyterLab - new terminals do NOT run this file, ONLY .bashrc.
#   That is true even if JupyterHub is running on a macOS host.

# Note that the traditional Unix design idea was to have a user's session
# contain a _single_ login shell, with all one-time actions taken there, and
# all subsequent interactive shells started as child processes of that one,
# thus inheriting its setup. Those interactive shells would then only load
# .bashrc. However, OSX starts each new terminal as a login shell, and
# JupyterLab terminals are also login shells. So it makes sense to configure
# this file to load .bashrc directly, and put most user configuration logic
# into .bashrc. We call .bashrc at the bottom.

#############################################################################
# macOS specific config here

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

#############################################################################
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


#############################################################################
# include .bashrc if it exists - contains all other config common to all OSes
# We call it from here so that ssh and JupyterHub logins get the same config,
# see long explanation above.

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
