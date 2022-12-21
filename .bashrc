#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export EDITOR=nvim


# PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
eval "$(starship init bash)"


alias ls="exa -la --icons --git"
alias dotfiles="git --work-tree $HOME --git-dir $HOME/dotfiles"
