#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export NVIM_APPNAME=nvim-next
export EDITOR=nvim


# PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
eval "$(starship init bash)"

# Only the function defined by this script: `n`, will do the quitcd
source /usr/share/nnn/quitcd/quitcd.bash_zsh


alias ls="exa -la --icons --git --group-directories-first"
alias dotfiles="git --work-tree $HOME --git-dir $HOME/dotfiles"
alias du="du --summarize --human-readable"
alias emc="emacsclient"
