HISTSIZE=5000
HISTFILESIZE=10000
bind '"\C-p": history-search-backward'
bind '"\e[A": history-search-backward'
bind '"\C-n": history-search-forward'
bind '"\e[B": history-search-forward'

# No repeated history
export HISTCONTROL=ignoreboth:erasedups

source /home/$USER/.shell_common "bash"
