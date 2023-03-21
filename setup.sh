PWD=`pwd`

BIN_PATH=/home/$USER/.local/bin/spec
BIN_SYMBOL_PATH=/home/$USER/.local/bin
mkdir -p $BIN_PATH
mkdir -p $BIN_SYMBOL_PATH

link_config_file(){
    NAME=$1
    SOURCE=$2
    TARGET=$3
    if [ ! -e "$TARGET" ]; then
        ln -s $SOURCE $TARGET && echo "$NAME: soft link is created"
    else
        echo "$NAME: Existing and is skipped."
    fi
}

prepare_binary(){
    NAME=$1
    SOURCE=$2
    TARGET=$3
    if [ -e "$TARGET" ]; then
        echo "$NAME: Existing and is skipped."
        return;
    fi
    URL=$4
    SUFFIX=${5:-tar.gz}
    FILE=tmp.$SUFFIX
    echo "$NAME: Downloading ..."
    {
        ALL_RIGHT=0 && \
        cd $BIN_PATH && \
        wget --output-document $FILE $URL && \
        tar xf $FILE && \
        rm $FILE && \
        ln -s $SOURCE $TARGET && \
        cd - && \
        ALL_RIGHT=1
    } > /dev/null 2>&1
    if [ $ALL_RIGHT -eq 1 ]; then
        echo "$NAME: Binary is ready"
    else
        echo "$NAME: Failed to prepare the binary"
    fi
}

NVIM_DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.tar.gz"
NVIM_BIN_PATH=$BIN_PATH/nvim-linux64/bin/nvim
NVIM_SYMBOL_PATH=$BIN_SYMBOL_PATH/nvim
NVIM_CONFIG_PATH=$PWD/nvim
NVIM_CONFIG_SYMBOL_PATH=/home/$USER/.config/nvim
prepare_binary "Nvim" "$NVIM_BIN_PATH" "$NVIM_SYMBOL_PATH" "$NVIM_DOWNLOAD_URL"
link_config_file "Nvim config" "$NVIM_CONFIG_PATH" "$NVIM_CONFIG_SYMBOL_PATH"

TMUX_CONFIG_PATH=$PWD/.tmux.conf
TMUX_CONFIG_SYMBOL_PATH=/home/$USER/.tmux.conf
link_config_file  "Tmux config" "$TMUX_CONFIG_PATH" "$TMUX_CONFIG_SYMBOL_PATH"

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

echo "source $PWD/.bashrc " >> /home/$USER/.bashrc
