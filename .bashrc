export PATH="/home/$USER/.local/bin:$PATH"

HISTSIZE=5000
HISTFILESIZE=10000
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# No repeated history
export HISTCONTROL=ignoreboth:erasedups


export USER_BIN_PATH=/home/$USER/.local/bin/spec
export USER_BIN_SYMBOL_PATH=/home/$USER/.local/bin
function check_executable() {
    if [ -e "$USER_BIN_SYMBOL_PATH/$1" ] || which "$1" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

source /home/$USER/.shell_common "bash"
