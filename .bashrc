#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export NVIM_APPNAME=nvim-next
export EDITOR=nvim


# PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
eval "$(starship init bash)"


scripts=(
    # Only the function defined by this script: `n`, will do the quitcd
    "/usr/share/nnn/quitcd/quitcd.bash_sh_zsh"
    "/usr/share/bash-completion/bash_completion"
)

for i in ${!scripts[@]}; do
    if [[ -e ${scripts[$i]} ]]; then
        source ${scripts[$i]}
    fi
done


alias ls="exa -la --icons --git --group-directories-first"
alias dotf="git --work-tree $HOME --git-dir $HOME/dotfiles"
# alias du="du --summarize --human-readable"
alias emc="emacsclient"
alias blc="bluetoothctl"
alias man="PAGER='nvim +Man!' man"
