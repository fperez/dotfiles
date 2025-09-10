# ~/.bash_profile: executed by bash for interactive login shells.

#echo '*** this is .bash_profile ***'  # dbg

# On macOS - New iTerm windows/tabs start as **interactive login shells**, and
# thus run this file, but NOT .bashrc.  .bashrc is also NOT executed even for
# ssh logins, which are **non-interactive shells**. 

# On JupyterHub/JupyterLab - new terminals start as **interactive non-login
# shells*, and thus do NOT run this file, ONLY .bashrc. That is true even if
# JupyterHub is running on a macOS host.

# Note that the traditional Unix design idea was to have a user's session
# contain a _single_ login shell, with all one-time actions taken there, and
# all subsequent interactive shells started as child processes of that one,
# thus inheriting its setup. Those interactive shells would then only load
# .bashrc. However, OSX starts each new terminal as a login shell, and
# JupyterLab terminals are also login shells. So it makes sense to configure
# this file to load .bashrc directly, and put most user configuration logic
# into .bashrc. We call .bashrc at the bottom.

#############################################################################
# include .bashrc if it exists - contains all other config common to all OSes
# We call it from here so that ssh and JupyterHub logins get the same config,
# see long explanation above.

# Ensure that non-interactive bash calls find and source ~/.bash_env
export BASH_ENV="$HOME/.bash_env"

# Load from .bash_env quiet, non-interactive configuration, paths, etc.
[[ -r ~/.bash_env ]] && . ~/.bash_env

# Only source ~/.bashrc if this is an *interactive* shell
case $- in *i*) [[ -r ~/.bashrc ]] && . ~/.bashrc ;; esac
