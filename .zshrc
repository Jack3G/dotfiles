setopt autocd
setopt notify # (Immediately show bg job changes)
unsetopt beep # no beebing pls

bindkey -e
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

HISTFILE=~/.cache/zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000

export NVIM_APPNAME=nvim-next
export EDITOR=nvim


eval "$(starship init zsh)"

# Only the function defined by this script: `n`, will do the quitcd
source "/usr/share/nnn/quitcd/quitcd.bash_sh_zsh"

alias ls="exa -la --icons --git --group-directories-first"
alias dotf="git --work-tree $HOME --git-dir $HOME/dotfiles"
alias emc="emacsclient"
alias blc="bluetoothctl"
alias man="PAGER='nvim +Man!' man"


# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' file-sort modification reverse
zstyle ':completion:*' format 'compl: %d'
zstyle ':completion:*' ignore-parents parent ..
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=long
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/jenny/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
