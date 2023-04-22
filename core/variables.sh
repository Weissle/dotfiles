DOTFILES_PATH=`pwd`
EXP_DOTFILES_PATH="/home/$USER/.config/dotfiles"
BIN_PATH=/home/$USER/.local/bin/spec
BIN_SYMBOL_PATH=/home/$USER/.local/bin

BINARY_LIST=("nvim" "lazygit" "ripgrep" "fd" "fzf" "zoxide" "starship" "bat" "exa")

NVIM_VERSION="v0.9.0"
LAZYGIT_VERSION="v0.37.0"
RIPGREP_VERSION="13.0.0"
FD_VERSION="v8.7.0"
FZF_VERSION="0.39.0"
ZOXIDE_VERSION="v0.9.0"
STARSHIP_VERSION="v1.14.1"
BAT_VERSION="v0.23.0"
EXA_VERSION="v0.10.1"

NVIM_REPO_BASE="https://github.com/neovim/neovim"
LAZYGIT_REPO_BASE="https://github.com/jesseduffield/lazygit"
RIPGREP_REPO_BASE="https://github.com/BurntSushi/ripgrep"
FD_REPO_BASE="https://github.com/sharkdp/fd"
FZF_REPO_BASE="https://github.com/junegunn/fzf"
ZOXIDE_REPO_BASE="https://github.com/ajeetdsouza/zoxide"
STARSHIP_REPO_BASE="https://github.com/starship/starship"
BAT_REPO_BASE="https://github.com/sharkdp/bat"
EXA_REPO_BASE="https://github.com/ogham/exa"

RD="releases/download"

for name in "${BINARY_LIST[@]}"
do
    UPPER=`echo $name | tr '[:lower:]' '[:upper:]'`
    eval ${UPPER}_REPO="\$${UPPER}_REPO_BASE.git"
    eval ${UPPER}_FOLDER_NAME="${name}_\${${UPPER}_VERSION}"
    eval TMP=$( rm_prefixv \$${UPPER}_VERSION)
    # exit 0
    BIN_REL_PATH=$name
    case "$name" in
        "nvim")
            COMPRESS_NAME="nvim-linux64.tar.gz"
            BIN_REL_PATH="bin/nvim" ;;
        "lazygit")
            COMPRESS_NAME="lazygit_${TMP}_Linux_x86_64.tar.gz" ;;
        "ripgrep")
            COMPRESS_NAME="ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz"
            BIN_REL_PATH="rg" ;;
        "fd")
            COMPRESS_NAME="fd-${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz" ;;
        "fzf")
            COMPRESS_NAME="fzf-${FZF_VERSION}-linux_amd64.tar.gz" ;;
        "zoxide")
            COMPRESS_NAME="zoxide-${TMP}-x86_64-unknown-linux-musl.tar.gz" ;;
        "starship")
            COMPRESS_NAME="starship-x86_64-unknown-linux-gnu.tar.gz" ;;
        "bat")
            COMPRESS_NAME="bat-${BAT_VERSION}-x86_64-unknown-linux-gnu.tar.gz" ;;
        "exa")
            COMPRESS_NAME="exa-linux-x86_64-${EXA_VERSION}.zip"
            BIN_REL_PATH="bin/exa" ;;
    esac

    eval ${UPPER}_BIN_PATH=$BIN_REL_PATH
    eval DOWNLOAD_URL_PREFIX=\$${UPPER}_REPO_BASE/$RD/\$${UPPER}_VERSION
    eval ${UPPER}_DOWNLOAD_URL=${DOWNLOAD_URL_PREFIX}/$COMPRESS_NAME

done

