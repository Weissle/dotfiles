# LOG_SKIP=false
# for arg in "$@"
# do
#     case "$arg" in
#         "-s") LOG_SKIP=true && echo "$LOG_SKIP";;
#     esac
# done
#
eval "$(cat ./core/functions.sh)"
eval "$(cat ./core/variables.sh)"
if [ "$DOTFILES_PATH" != "$EXP_DOTFILES_PATH" ]; then
    echo "You should place the dotfile in \"$EXP_DOTFILES_PATH\""
    exit 1
fi


mkdir -p $BIN_PATH
mkdir -p $BIN_SYMBOL_PATH
prepare_binary "nvim" "bin/nvim" "$NVIM_DOWNLOAD_URL" "tar-strip"
prepare_binary "lazygit" "lazygit" "$LAZYGIT_DOWNLOAD_URL"
prepare_binary "ripgrep" "rg" "$RIPGREP_DOWNLOAD_URL" "tar-strip"
prepare_binary "fd" "fd" "$FD_DOWNLOAD_URL" "tar-strip"
prepare_binary "fzf" "fzf" "$FZF_DOWNLOAD_URL"
prepare_binary "zoxide" "zoxide" "$ZOXIDE_DOWNLOAD_URL"
prepare_binary "starship" "starship" "$STARSHIP_DOWNLOAD_URL"
prepare_binary "bat" "bat" "$BAT_DOWNLOAD_URL" "tar-strip"
prepare_binary "exa" "bin/exa" "$EXA_DOWNLOAD_URL" "unzip"

link_file "nvim config" "$DOTFILES_PATH/nvim" "/home/$USER/.config/nvim"
link_file "Tmux config" "$DOTFILES_PATH/.tmux.conf" "/home/$USER/.tmux.conf"
link_file "starship config" "$DOTFILES_PATH/starship.toml" "/home/$USER/.config/starship.toml"
link_file ".shell_common" "$DOTFILES_PATH/shell/shell_common.bash" "/home/$USER/.shell_common"
if [ `wc -l /home/$USER/.config/lazygit/config.yml | awk '{print $1}'` -eq 0 ]; then
    echo_c "info" "lazygit config is empty. Removing it and create a softlink to ./lazygit/config.yml"
    rm /home/$USER/.config/lazygit/config.yml
fi
link_file "lazygit config" "$DOTFILES_PATH/lazygit/config.yml" "/home/$USER/.config/lazygit/config.yml"

# oh my zsh
if [ -e "/usr/bin/zsh" ]; then
	if [ ! -e "/home/$USER/.oh-my-zsh" ]; then
		echo_c "info" "Installing oh-my-zsh"
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
		rm ~/.zshrc
	fi
	link_file ".zshrc" "$DOTFILES_PATH/shell/.zshrc" "/home/$USER/.zshrc"
else 
	echo_c "error" "ZSH is not installed. Please install it and run this script again."
fi

clone_repo "fzf-repo" "https://github.com/junegunn/fzf.git" "$BIN_PATH/fzf-repo"
clone_repo "fzf-exec-history" "https://github.com/4z3/fzf-plugins.git" "$BIN_PATH/fzf-exec-history"

OMZ_CUSTOM_PATH=$BIN_PATH/omz-custom
mkdir -p $OMZ_CUSTOM_PATH/plugins
clone_repo "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions.git" "$OMZ_CUSTOM_PATH/plugins/zsh-autosuggestions"
clone_repo "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$OMZ_CUSTOM_PATH/plugins/zsh-syntax-highlighting"
clone_repo "tpm" "https://github.com/tmux-plugins/tpm.git" "/home/$USER/.tmux/plugins/tpm"


cd $DOTFILES_PATH
append_if_not_exist(){
    TEXT=$1
    FILE=$2
    [ ! -e "$FILE" ] && echo_c "error" "$FILE not exists. Append cancel." && return
    if ! grep -q "$TEXT" "$FILE"; then
        echo_c "info" "Append \"$TEXT\" to $FILE"
        echo "$TEXT" >> $FILE
    else
        echo_c "skip" "\"$TEXT\" exists in $FILE, skip"
    fi
}

append_if_not_exist "source $DOTFILES_PATH/shell/.bashrc" "/home/$USER/.bashrc"
append_if_not_exist "changeps1: false" "/home/$USER/.condarc"

CHEAT_SHELL_PATH="$BIN_SYMBOL_PATH/cht.sh"
if [ ! -e  "$CHEAT_SHELL_PATH" ]; then
    curl https://cht.sh/:cht.sh > "$CHEAT_SHELL_PATH"
    chmod +x "$CHEAT_SHELL_PATH"
    echo_c "good" "cheat.sh is installed in $CHEAT_SHELL_PATH."
else
    echo_c "skip" "$CHEAT_SHELL_PATH exists, skip."
fi
