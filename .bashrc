export PATH="/home/$USER/.local/bin:$PATH"

BIN_PATH=/home/$USER/.local/bin/spec
alias lz=lazygit
alias v=nvim

function check_executable() {
  if which "$1" >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

# fzf: Debian or ubuntun
if check_executable "fzf"; then
    export FZF_COMPLETION_TRIGGER='\'
    FZF_CTRL_R_EDIT_KEY=ctrl-e
    FZF_CTRL_R_EXEC_KEY=enter
    source $BIN_PATH/fzf-repo/shell/key-bindings.bash
    source $BIN_PATH/fzf-repo/shell/completion.bash
    source $BIN_PATH/fzf-exec-history/history-exec.bash
fi

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# No repeated history 
export HISTCONTROL=ignoreboth:erasedups

if check_executable "zoxide"; then
    eval "$(zoxide init bash)"
fi

if check_executable "starship"; then
    eval "$(starship init bash)"
fi
