export PATH="/home/$USER/.local/bin:$PATH"

BIN_PATH=/home/$USER/.local/bin/spec
alias lz=lazygit
alias v=nvim

# fzf: Debian or ubuntun
export FZF_COMPLETION_TRIGGER='\'
FZF_CTRL_R_EDIT_KEY=ctrl-e
FZF_CTRL_R_EXEC_KEY=enter
source $BIN_PATH/fzf-repo/shell/key-bindings.bash
source $BIN_PATH/fzf-repo/shell/completion.bash
source $BIN_PATH/fzf-exec-history/history-exec.bash

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# No repeated history 
export HISTCONTROL=ignoreboth:erasedups

eval "$(zoxide init bash)"
