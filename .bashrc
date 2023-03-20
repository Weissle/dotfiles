export PATH="$PATH:/home/$USER/.local/bin"

alias lz=lazygit

# fzf: Debian or ubuntun
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash
FZF_CTRL_R_EDIT_KEY=ctrl-e
FZF_CTRL_R_EXEC_KEY=enter
source /home/$USER/.config/dotfiles/exec-history.bash

export FZF_COMPLETION_TRIGGER='\'

# autojump
. /usr/share/autojump/autojump.sh

# No repeated history 
export HISTCONTROL=ignoreboth:erasedups

