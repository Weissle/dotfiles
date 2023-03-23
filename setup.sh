PWD=`pwd`

BIN_PATH=/home/$USER/.local/bin/spec
BIN_SYMBOL_PATH=/home/$USER/.local/bin
mkdir -p $BIN_PATH
mkdir -p $BIN_SYMBOL_PATH

echo_c(){
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    NC='\033[0m' # No Color
    MSG_TYPE=$1
    MSG=$2
    case "$MSG_TYPE" in
        "info") echo -n "$BLUE" ;;
        "good") echo -n "$GREEN" ;;
        "error") echo -n "$RED" ;;
        "warn") echo -n "$YELLOW" ;;
    esac
    echo "$2$NC"
}

link_file(){
    NAME=$1
    SOURCE=$2
    TARGET=$3
    if [ ! -e "$TARGET" ]; then
        ln -s $SOURCE $TARGET && echo_c "good" "$NAME: Soft link is created."
    else
        echo_c "warn" "$NAME: Existing and is skipped."
    fi
}

prepare_binary(){
    NAME=$1
    SOURCE=$2
    TARGET=$3
    if [ -e "$TARGET" ]; then
        echo_c "warn" "$NAME: Existing and is skipped."
        return;
    fi
    URL=$4
    FILE=`basename $URL`
    TAR_PARAMETERS=${5:-"tar xf"}
    EXTRACT_PATH=${6:-$BIN_PATH}
    echo_c "info" "$NAME: Downloading ..."
    cd $EXTRACT_PATH
    wget --output-document $FILE $URL && \
        $TAR_PARAMETERS $FILE && \
        rm $FILE && \
        ln -s $SOURCE $TARGET && \
        echo_c "good" "$NAME: Binary is ready." || \
        echo_c "error" "$NAME: Failed to prepare the binary."
    cd -
}

clone_repo(){
    NAME=$1
    REPO_URL=$2
    REPO_PATH=$3
    if [ ! -e "$REPO_PATH" ]; then
        echo_c "info" "$NAME: Cloning repo ..."
        git clone "$REPO_URL" "$REPO_PATH" && echo_c "good" "$NAME: Clone finished." || echo_c "error" "$NAME: Failed to clone the repo."
    else
        echo_c "warn" "$NAME: Existing and is skipped."
    fi
}

NVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.tar.gz"
NVIM_BIN_PATH=$BIN_PATH/nvim-linux64/bin/nvim
NVIM_SYMBOL_PATH=$BIN_SYMBOL_PATH/nvim
NVIM_CONFIG_PATH=$PWD/nvim
NVIM_CONFIG_SYMBOL_PATH=/home/$USER/.config/nvim
prepare_binary "nvim" "$NVIM_BIN_PATH" "$NVIM_SYMBOL_PATH" "$NVIM_DOWNLOAD_URL"
link_file "nvim config" "$NVIM_CONFIG_PATH" "$NVIM_CONFIG_SYMBOL_PATH"

TMUX_CONFIG_PATH=$PWD/.tmux.conf
TMUX_CONFIG_SYMBOL_PATH=/home/$USER/.tmux.conf
link_file "Tmux config" "$TMUX_CONFIG_PATH" "$TMUX_CONFIG_SYMBOL_PATH"

LAZYGIT_DOWNLOAD_URL="https://github.com/jesseduffield/lazygit/releases/download/v0.37.0/lazygit_0.37.0_Linux_x86_64.tar.gz"
LAZYGIT_BIN_PATH=$BIN_PATH/lazygit
LAZYGIT_SYMBOL_PATH=$BIN_SYMBOL_PATH/lazygit
prepare_binary "Lazygit" "$LAZYGIT_BIN_PATH" "$LAZYGIT_SYMBOL_PATH" "$LAZYGIT_DOWNLOAD_URL"

RIPGREP_DOWNLOAD_URL="https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz"
RIPGREP_BIN_PATH=$BIN_PATH/ripgrep-13.0.0-x86_64-unknown-linux-musl/rg
RIPGREP_SYMBOL_PATH=$BIN_SYMBOL_PATH/rg
prepare_binary "ripgrep" "$RIPGREP_BIN_PATH" "$RIPGREP_SYMBOL_PATH" "$RIPGREP_DOWNLOAD_URL"

FD_DOWNLOAD_URL="https://github.com/sharkdp/fd/releases/download/v8.7.0/fd-v8.7.0-x86_64-unknown-linux-gnu.tar.gz"
FD_BIN_PATH=$BIN_PATH/fd-v8.7.0-x86_64-unknown-linux-gnu/fd
FD_SYMBOL_PATH=$BIN_SYMBOL_PATH/fd
prepare_binary "fd" "$FD_BIN_PATH" "$FD_SYMBOL_PATH" "$FD_DOWNLOAD_URL"

FZF_DOWNLOAD_URL="https://github.com/junegunn/fzf/releases/download/0.38.0/fzf-0.38.0-linux_amd64.tar.gz"
FZF_BIN_PATH=$BIN_PATH/fzf
FZF_SYMBOL_PATH=$BIN_SYMBOL_PATH/fzf
FZF_REPO_URL=https://github.com/junegunn/fzf.git
FZF_REPO_PATH=$BIN_PATH/fzf-repo
prepare_binary "fzf" "$FZF_BIN_PATH" "$FZF_SYMBOL_PATH" "$FZF_DOWNLOAD_URL"
clone_repo "fzf-repo" "$FZF_REPO_URL" "$FZF_REPO_PATH"

FZF_PLUGIN_EXEC_HISTORY_URL=https://github.com/4z3/fzf-plugins.git
FZF_PLUGIN_EXEC_HISTORY_PATH=$BIN_PATH/fzf-exec-history
clone_repo "fzf-exec-history" "$FZF_PLUGIN_EXEC_HISTORY_URL" "$FZF_PLUGIN_EXEC_HISTORY_PATH"

ZOXIDE_DOWNLOAD_URL=https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.0/zoxide-0.9.0-x86_64-unknown-linux-musl.tar.gz
ZOXIDE_FOLDER=$BIN_PATH/zoxide
mkdir -p $ZOXIDE_FOLDER
ZOXIDE_BIN_PATH=$ZOXIDE_FOLDER/zoxide
ZOXIDE_SYMBOL_PATH=$BIN_SYMBOL_PATH/zoxide
prepare_binary "zoxide" "$ZOXIDE_BIN_PATH" "$ZOXIDE_SYMBOL_PATH" "$ZOXIDE_DOWNLOAD_URL" "tar xf" "$ZOXIDE_FOLDER"

STARSHIP_DOWNLOAD_URL=https://github.com/starship/starship/releases/download/v1.13.1/starship-x86_64-unknown-linux-gnu.tar.gz
STARSHIP_BIN_PATH=$BIN_PATH/starship
STARSHIP_SYMBOL_PATH=$BIN_SYMBOL_PATH/starship
STARSHIP_CONFIG_PATH=$PWD/starship.toml
STARSHIP_CONFIG_SYMBOL_PATH=/home/$USER/.config/starship.toml
prepare_binary "starship" "$STARSHIP_BIN_PATH" "$STARSHIP_SYMBOL_PATH" "$STARSHIP_DOWNLOAD_URL"
link_file "starship config" "$STARSHIP_CONFIG_PATH" "$STARSHIP_CONFIG_SYMBOL_PATH"




cd $PWD
BASH_COMMAND="source $PWD/.bashrc"
BASHRC_PATH=/home/$USER/.bashrc
if ! grep -q "$BASH_COMMAND" "$BASHRC_PATH"; then
    echo "$BASH_COMMAND">> $BASHRC_PATH
fi
