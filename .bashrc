export PATH="/home/$USER/.local/bin:$PATH"

BIN_PATH=/home/$USER/.local/bin/spec
BIN_SYMBOL_PATH=/home/$USER/.local/bin
HISTSIZE=5000
HISTFILESIZE=10000
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# No repeated history
export HISTCONTROL=ignoreboth:erasedups


function check_executable() {
    if [ -e "$BIN_SYMBOL_PATH/$1" ] || which "$1" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

alias lz=lazygit
alias v=nvim
# fzf: Debian or ubuntun
if check_executable "fzf"; then
    export FZF_COMPLETION_TRIGGER='\'
    FZF_CTRL_R_EDIT_KEY=ctrl-e
    FZF_CTRL_R_EXEC_KEY=enter
    source $BIN_PATH/fzf-repo/shell/key-bindings.bash
    source $BIN_PATH/fzf-repo/shell/completion.bash
    source $BIN_PATH/fzf-exec-history/history-exec.bash
fi

if check_executable "zoxide"; then
    cdi() {
        local dir
        dir="$(zoxide query -i | fzf --height 40% --reverse --preview 'ls -la {}' --preview-window right:60%)"
        if [ -n "$dir" ]; then
            cd "$dir"
        fi
    }
    eval "$(zoxide init bash --cmd cd)"
    source $BIN_PATH/zoxide/completions/zoxide.bash
fi

if check_executable "starship"; then
    eval "$(starship init bash)"
fi

if check_executable "bat"; then
    alias cat=bat
    alias cata="bat --paging=never"
    source $BIN_PATH/bat/autocomplete/bat.bash
fi

if check_executable "exa"; then
    alias ls="exa"
    alias la="exa -a"
    alias ll="exa -alF"
    source $BIN_PATH/exa/completions/exa.bash
fi

check_executable "fd" && source "$BIN_PATH/fd/autocomplete/fd.bash"
check_executable "rg" && source "$BIN_PATH/ripgrep/complete/rg.bash"
