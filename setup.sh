PWD=`pwd`

NVIM_CONFIG_PATH=/home/$USER/.config/nvim
TMUX_CONFIG_PATH=/home/$USER/.tmux.conf

BIN_PATH=/home/$USER/.local/bin
LAZYGIT_PATH=$BIN_PATH/lazygit
NVIM_PATH=$BIN_PATH/nvim

echo_skip(){
    echo "$1: Existing and skip."
}
if [ ! -d "$NVIM_CONFIG_PATH" ]; then
    echo "nvim: soft link for nvim config is created."
    ln -s $PWD/nvim $NVIM_CONFIG_PATH
else
    echo_skip "neovim config"
fi

if [ ! -f "$TMUX_CONFIG_PATH" ]; then
    echo "tmux: soft link for tmux config is created."
    ln -s $PWD/.tmux.conf  $TMUX_CONFIG_PATH
else
    echo_skip "tmux config"
fi

if [ ! -f "$LAZYGIT_PATH" ]; then
    echo "lazygit: Downloading..."
    cd $BIN_PATH
    wget --output-document lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v0.37.0/lazygit_0.37.0_Linux_x86_64.tar.gz && mkdir lazygit_folder && tar xf lazygit.tar.gz --directory=lazygit_folder && cp $BIN_PATH/lazygit_folder/lazygit . && rm -r lazygit.tar.gz lazygit_folder
    cd $PWD
else
    echo_skip "lazygit"
fi

if [ ! -f "$NVIM_PATH" ]; then
    echo "nvim: Downloading ..."
    cd $BIN_PATH
    wget --output-document neovim.tar.gz https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.tar.gz && mkdir nvim_folder && tar xf neovim.tar.gz --directory=nvim_folder && rm neovim.tar.gz && ln -s $BIN_PATH/nvim_folder/nvim-linux64/bin/nvim .
    cd $PWD
else
    echo_skip "neovim"
fi

echo "source $PWD/.bashrc " >> /home/$USER/.bashrc

