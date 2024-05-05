export PATH="/home/$USER/.local/bin:$PATH"
export USER_BIN_PATH=/home/$USER/.local/bin/spec
export USER_BIN_SYMBOL_PATH=/home/$USER/.local/bin
function check_executable() {
    if [ -e "$USER_BIN_SYMBOL_PATH/$1" ] || which "$1" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}
SHELL_TYPE=$1

# Assuming check_executable USER_BIN_PATH is set
alias lg=lazygit
alias v=nvim

# For tmux
alias tm=tmux
alias tma="tmux a"
alias tmat="tmux attach-session -t "
alias tmls="tmux list-sessions"
alias ch="cht.sh"
# For git
alias gp="git pull"
alias gs="git status"

case "$SHELL_TYPE" in
    "zsh")
        alias s=zsh ;;
    "bash")
        alias s=sh ;;
esac



if check_executable "fzf"; then
    export FZF_COMPLETION_TRIGGER='\'
    case "$SHELL_TYPE" in
        "bash")
            source $USER_BIN_PATH/fzf-repo/shell/key-bindings.$SHELL_TYPE
            source $USER_BIN_PATH/fzf-repo/shell/completion.$SHELL_TYPE
            FZF_CTRL_R_EDIT_KEY=ctrl-e
            FZF_CTRL_R_EXEC_KEY=enter
            source $USER_BIN_PATH/fzf-exec-history/history-exec.bash
            ;;
    esac
fi

if check_executable "zoxide"; then
    cdi() {
        local dir
        dir="$(zoxide query -i | fzf --height 40% --reverse --preview 'ls -la {}' --preview-window right:60%)"
        if [ -n "$dir" ]; then
            cd "$dir"
        fi
    }
    eval "$(zoxide init $SHELL_TYPE --cmd cd)"
fi

if check_executable "starship"; then
    eval "$(starship init $SHELL_TYPE)"
fi

export windows_host=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`
# proxy
proxy(){
    if [[ $(grep "microsoft" /proc/version) ]]; then
        export ALL_PROXY=http://$windows_host:30120
        export HTTP_PROXY=$ALL_PROXY
        export HTTPS_PROXY=$ALL_PROXY
        export http_proxy=$ALL_PROXY
        export https_proxy=$ALL_PROXY
    fi
}

unproxy(){
    export ALL_PROXY=""
    export HTTP_PROXY=""
    export HTTPS_PROXY=""
    export http_proxy=""
    export https_proxy=""
}
