# ~/.bashrc

export HISTCONTROL=ignoreboth
export NVIM_APPNAME=nvim-next
export EDITOR=nvim

if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if command -v starship > /dev/null; then
   eval "$(starship init bash)"
else
   PS1="\n\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[00m\]\n \$ "
fi


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
alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"

alias pfetch-kitty="clear; echo; PF_ASCII=catppuccin pfetch"
alias playsong='sh -c "cd $HOME/Music/library; fd -t f . . | fzf --tac --print0 | xargs -0 mpv"'
# only uses opustags. still have to do mp{3,4} manually.
alias songmeta='sh -c "cd $HOME/Music/library; fd -t f \"\\.opus|\\.ogg\" . | fzf --tac --print0 | xargs -0 "opustags {} | grep -v "^METADATA_BLOCK_PICTURE="""'
alias songmetaf='sh -c "cd $HOME/Music/library; fd -t f | fzf --tac --print0 | xargs -0 "ffprobe {}""'
alias songmetaedit='sh -c "cd $HOME/Music/library; fd -t f \"\\.opus|\\.ogg\" . | fzf --tac --print0 | xargs -0 "opustags -ie {}""'

alias webcam="mpv --demuxer-lavf-format=video4linux2 --demuxer-lavf-o-set=input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency --untimed"


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

stopwatch() {
   start_time=$(date +%s)
   printf "start time: %s\n" $start_time

   while [ 1 ]; do
      time_taken=$(($(date +%s) - start_time))
      by_clock=$(date -d@$time_taken -u +%H:%M:%S)
      printf "\rtime taken: %s or %s" "$time_taken" "$by_clock"
      sleep 1
   done

   printf "\n"
}


bar_percentage_scale=4

progress_bar() {
   current="$1"
   total="$2"

   # minus the number of extra characters in the line
   bar_size=$(($(tput cols) - 5 - 1 - ${bar_percentage_scale}))

   percent=$(bc <<< "scale=$bar_percentage_scale; $current / $total" )
   done=$(bc <<< "scale=0; $bar_size * $percent" )
   todo=$(bc <<< "scale=0; $bar_size - $done" )

   done_sub_bar=$(printf "%${done}s" | tr " " "#")
   todo_sub_bar=$(printf "%${todo}s" | tr " " "-")

   # handle the case where done_sub is empty
   if [ -z $done_sub_bar ]; then
      printf "\x1B[1K\r [%s] %s" ${todo_sub_bar} ${percent}
   else
      # and when it's full
      if [ -z $todo_sub_bar ]; then
         # don't print too much. (would go from .999 to 1.000)
         if (( $(bc <<< "$percent == 1") )); then percent=1; fi

         printf "\x1B[1K\r [%s] %s" ${done_sub_bar} ${percent}
      else
         printf "\x1B[1K\r [%s%s] %s" ${done_sub_bar} ${todo_sub_bar} ${percent}
      fi
   fi
}


wakeup() {
   offset="$1"

   wake_duration=43200

   start_time=$(($(date +%s) - offset))
   end_time=$((start_time + wake_duration))

   progress=0

   while ((progress <= wake_duration)); do
      progress=$(($(date +%s) - start_time))

      progress_bar $progress $wake_duration
      sleep 1
   done

   printf "\n\neep time now\n"
}

# vim: set ts=3 sw=3 et:
