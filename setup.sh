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
        ln -s $SOURCE $TARGET && echo_c "good" "$NAME: Soft link is created." && return;
    fi
    REAL_TARGET=`readlink -f $TARGET`
    if [ "$SOURCE" != "$REAL_TARGET" ]; then
        echo_c "warn" "$NAME: Existing and they are not same."
    else
        echo_c "good" "$NAME: Existing and is skipped."
    fi
}

download_extract(){
    NAME=$1
    FOLDER=$2
    FOLDER=$BIN_PATH/$NAME
    URL=$3
    FILE_NAME=`basename $URL`
    EXTRACT_OPT=$4
    case "$EXTRACT_OPT" in
        "tar") EXTRACT_CMD="tar xf $FILE_NAME -C $FOLDER" ;;
        "tar-strip") EXTRACT_CMD="tar xf $FILE_NAME -C $FOLDER --strip-components=1" ;;
        "unzip") EXTRACT_CMD="unzip -d $FOLDER $FILE_NAME" ;;
    esac
    CUR_DIR=`pwd`
    mkdir -p $FOLDER && cd $FOLDER
    wget $URL &&\
        $EXTRACT_CMD &&\
        rm $FILE_NAME &&\
        echo_c "good" "$NAME: Download finished." || \
        echo_c "error" "$NAME: Failed to download."
    cd $CUR_DIR
}

prepare_binary(){
    NAME=$1
    FOLDER=$BIN_PATH/$NAME
    TARGET_RELATIVE_PATH=$2
    TARGET_PATH="$FOLDER/$TARGET_RELATIVE_PATH"
    URL=$3
    EXTRACT_OPT=${4:-"tar"}
    SYMBOL_PATH=$BIN_SYMBOL_PATH/`basename $TARGET_PATH`
    [ ! -e "$TARGET_PATH" ] && echo_c "info" "$NAME: Target file(s) is not found. Downloading ... " && \
        download_extract $NAME $FOLDER $URL $EXTRACT_OPT
    link_file $NAME $TARGET_PATH $SYMBOL_PATH
}

clone_repo(){
    NAME=$1
    REPO_URL=$2
    REPO_PATH=$3
    if [ ! -e "$REPO_PATH" ]; then
        echo_c "info" "$NAME: Cloning repo ..."
        git clone "$REPO_URL" "$REPO_PATH" && echo_c "good" "$NAME: Clone finished." || echo_c "error" "$NAME: Failed to clone the repo."
    else
        echo_c "good" "$NAME: Existing and is skipped."
    fi
}

prepare_binary "nvim" "bin/nvim" "https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.tar.gz" "tar-strip"
prepare_binary "lazygit" "lazygit" "https://github.com/jesseduffield/lazygit/releases/download/v0.37.0/lazygit_0.37.0_Linux_x86_64.tar.gz"
prepare_binary "ripgrep" "rg" "https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz" "tar-strip"
prepare_binary "fd" "fd" "https://github.com/sharkdp/fd/releases/download/v8.7.0/fd-v8.7.0-x86_64-unknown-linux-gnu.tar.gz" "tar-strip"
prepare_binary "fzf" "fzf" "https://github.com/junegunn/fzf/releases/download/0.38.0/fzf-0.38.0-linux_amd64.tar.gz"
prepare_binary "zoxide" "zoxide" "https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.0/zoxide-0.9.0-x86_64-unknown-linux-musl.tar.gz"
prepare_binary "starship" "starship" "https://github.com/starship/starship/releases/download/v1.13.1/starship-x86_64-unknown-linux-gnu.tar.gz"
prepare_binary "bat" "bat" "https://github.com/sharkdp/bat/releases/download/v0.22.1/bat-v0.22.1-x86_64-unknown-linux-gnu.tar.gz" "tar-strip"
prepare_binary "exa" "bin/exa" "https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip" "unzip"

link_file "nvim config" "$PWD/nvim" "/home/$USER/.config/nvim"
link_file "Tmux config" "$PWD/.tmux.conf" "/home/$USER/.tmux.conf"
link_file "starship config" "$PWD/starship.toml" "/home/$USER/.config/starship.toml"
link_file ".zshrc" "$PWD/.zshrc" "/home/$USER/.zshrc"
link_file ".shell_common" "$PWD/.shell_common" "/home/$USER/.shell_common"

clone_repo "fzf-repo" "https://github.com/junegunn/fzf.git" "$BIN_PATH/fzf-repo"
clone_repo "fzf-exec-history" "https://github.com/4z3/fzf-plugins.git" "$BIN_PATH/fzf-exec-history"


cd $PWD
BASH_COMMAND="source $PWD/.bashrc"
BASHRC_PATH=/home/$USER/.bashrc
if ! grep -q "$BASH_COMMAND" "$BASHRC_PATH"; then
    echo "$BASH_COMMAND">> $BASHRC_PATH
fi
