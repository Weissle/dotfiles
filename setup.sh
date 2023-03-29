DOTFILES_PATH=`pwd`
LOG_SKIP=false

for arg in "$@"
do
    case "$arg" in
        "-s") LOG_SKIP=true && echo "$LOG_SKIP";;
    esac
done

BIN_PATH=/home/$USER/.local/bin/spec
BIN_SYMBOL_PATH=/home/$USER/.local/bin
NO_OUTPUT_TO_TERM=" > /dev/null 2>&1"
mkdir -p $BIN_PATH
mkdir -p $BIN_SYMBOL_PATH

echo_c(){
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    NC='\033[0m' # No Color
    MSG_TYPE=$1
    MSG=$2
    MSG_COLOR=
    case "$MSG_TYPE" in
        "info") MSG_COLOR="$BLUE" ;;
        "good") MSG_COLOR="$GREEN" ;;
        "error") MSG_COLOR="$RED" ;;
        "warn") MSG_COLOR="$YELLOW" ;;
        "skip") [ "$LOG_SKIP" = false ] && return || MSG_COLOR="$CYAN" ;;
    esac
    echo "$MSG_COLOR$2$NC"
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
        echo_c "skip" "$NAME: Existing and is skipped."
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
    mkdir -p $FOLDER && cd $FOLDER
    wget $URL &&\
        $EXTRACT_CMD &&\
        rm $FILE_NAME &&\
        echo_c "good" "$NAME: Download finished." || \
        echo_c "error" "$NAME: Failed to download."
    cd $DOTFILES_PATH
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
        return
    else
        cd $REPO_PATH
        THX_REPO_URL=`git remote get-url origin`
        if [ "$?" -eq 128 ]; then
            echo_c "error" "$NAME: $REPO_PATH exists and it is not a git repo."
        elif [ "$THX_REPO_URL" != "$REPO_URL" ]; then
            echo_c "error" "$NAME: $REPO_PATH exists and it's origin URL is not target URL."
        else
            echo_c "skip" "$NAME: Existing and is skipped."
        fi
        cd $DOTFILES_PATH
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

link_file "nvim config" "$DOTFILES_PATH/nvim" "/home/$USER/.config/nvim"
link_file "Tmux config" "$DOTFILES_PATH/.tmux.conf" "/home/$USER/.tmux.conf"
link_file "starship config" "$DOTFILES_PATH/starship.toml" "/home/$USER/.config/starship.toml"
link_file ".shell_common" "$DOTFILES_PATH/shell/.shell_common" "/home/$USER/.shell_common"
if [ `wc -l /home/$USER/.config/lazygit/config.yml | awk '{print $1}'` -eq 0 ]; then
    echo_c "info" "lazygit config is empty. Removing it and create a softlink to ./lazygit/config.yml"
    rm /home/$USER/.config/lazygit/config.yml
fi
link_file "lazygit config" "$DOTFILES_PATH/lazygit/config.yml" "/home/$USER/.config/lazygit/config.yml"

# oh my zsh
if [ ! -e "/home/$USER/.oh-my-zsh" ]; then
    echo_c "info" "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm ~/.zshrc
fi
link_file ".zshrc" "$DOTFILES_PATH/shell/.zshrc" "/home/$USER/.zshrc"

clone_repo "fzf-repo" "https://github.com/junegunn/fzf.git" "$BIN_PATH/fzf-repo"
clone_repo "fzf-exec-history" "https://github.com/4z3/fzf-plugins.git" "$BIN_PATH/fzf-exec-history"

OMZ_CUSTOM_PATH=$BIN_PATH/omz-custom
mkdir -p $OMZ_CUSTOM_PATH/plugins
clone_repo "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git" "$OMZ_CUSTOM_PATH/plugins/zsh-autosuggestions"
clone_repo "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$OMZ_CUSTOM_PATH/plugins/zsh-syntax-highlighting"


cd $DOTFILES_PATH
append_if_not_exist(){
    TEXT=$1
    FILE=$2
    [ ! -e "$FILE" ] && echo_c "error" "$FILE not exists. Append cancel." && return
    if ! grep -q "$TEXT" "$FILE"; then
        echo_c "info" "Append \"$TEXT\" to $FILE"
        echo "$TEXT" >> $FILE
    else
        echo_c "skip" "$TEXT exists in $FILE, skip"
    fi
}

append_if_not_exist "source $DOTFILES_PATH/shell/.bashrc" "/home/$USER/.bashrc"
append_if_not_exist "changeps1: false" "/home/$USER/.condarc"
