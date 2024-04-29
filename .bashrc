#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export HISTCONTROL=ignoreboth
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


# funny pipe lol
countdown() {
   start_time=$(date +%s)
   end_time=$((start_time + $1))

   while [ $end_time -gt $(date +%s) ]; do
      printf "\x1B[1K\rtime left: %s" "$((end_time - $(date +%s)))"
      sleep 1
   done

   printf "\nTIME'S UP!!\n"
   mpv --really-quiet ~/vault/assets/audio/metal_pipe.opus
}

# vim: set ts=3 sw=3 et:
