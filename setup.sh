PWD=`pwd`

NVIM_CONFIG_PATH=/home/$USER/.config/nvim
TMUX_CONFIG_PATH=/home/$USER/.tmux.conf

BIN_PATH=/home/$USER/.local/bin
LAZYGIT_PATH=$BIN_PATH/lazygit

if [ ! -d "$NVIM_CONFIG_PATH" ]; then
    echo "nvim: soft link for nvim config is created."
    ln -s $PWD/nvim $NVIM_CONFIG_PATH
else
    echo "nvim: config exists. Skip."
fi

if [ ! -f "$TMUX_CONFIG_PATH" ]; then
    echo "tmux: soft link for tmux config is created."
    ln -s $PWD/.tmux.conf  $TMUX_CONFIG_PATH
else
    echo "tmux: config exists. Skip."
fi

if [ ! -f $LAZYGIT_PATH ]; then
    echo "lazygit: Downloading lazygit"
    cd $BIN_PATH
    wget --output-document lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v0.37.0/lazygit_0.37.0_Linux_x86_64.tar.gz && mkdir lazygit_folder && tar xf lazygit.tar.gz --directory=lazygit_folder && ln -s $BIN_PATH/lazygit_folder/lazygit .
else
    echo "lazygit: Lazygit exists. Skip."
fi

# echo "source $PWD/.bashrc " >> /home/$USER/.bashrc

