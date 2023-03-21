export PATH="/home/$USER/.local/bin:$PATH"

alias lz=lazygit

# fzf: Debian or ubuntun
export FZF_COMPLETION_TRIGGER='\'
FZF_CTRL_R_EDIT_KEY=ctrl-e
FZF_CTRL_R_EXEC_KEY=enter
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash
source /home/$USER/.config/dotfiles/exec-history.bash

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# autojump
. /usr/share/autojump/autojump.sh

# No repeated history 
export HISTCONTROL=ignoreboth:erasedups

