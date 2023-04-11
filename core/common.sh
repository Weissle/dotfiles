RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
echo_c(){
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
upper(){
    echo $name | tr '[:lower:]' '[:upper:]'
}

BINARY_LIST=("nvim" "lazygit" "ripgrep" "fd" "fzf" "zoxide" "starship" "bat" "exa")

NVIM_VERSION="v0.8.3"
LAZYGIT_VERSION="v0.37.0"
RIPGREP_VERSION="13.0.0"
FD_VERSION="v8.7.0"
FZF_VERSION="0.38.0"
ZOXIDE_VERSION="v0.9.0"
STARSHIP_VERSION="v1.13.1"
BAT_VERSION="v0.22.1"
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

for name in "${BINARY_LIST[@]}"
do
    UPPER=`echo $name | tr '[:lower:]' '[:upper:]'`
    eval ${UPPER}_REPO="\$${UPPER}_REPO_BASE.git"
done

RD="releases/download"
rm_prefixv(){
    echo $1 | cut --characters=2-
}

NVIM_DOWNLOAD_URL="$NVIM_REPO_BASE/$RD/$NVIM_VERSION/nvim-linux64.tar.gz"
TMP=$(rm_prefixv $LAZYGIT_VERSION)
LAZYGIT_DOWNLOAD_URL="$NVIM_REPO_BASE/$RD/$LAZYGIT_VERSION/lazygit_${TMP}_Linux_x86_64.tar.gz"
RIPGREP_DOWNLOAD_URL="https://github.com/BurntSushi/ripgrep/releases/download/$RIPGREP_VERSION/ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz" 
FD_DOWNLOAD_URL="https://github.com/sharkdp/fd/releases/download/$FD_VERSION/fd-${FD_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
FZF_DOWNLOAD_URL="https://github.com/junegunn/fzf/releases/download/$FZF_VERSION/fzf-${FZF_VERSION}-linux_amd64.tar.gz"
TMP=$(rm_prefixv $ZOXIDE_VERSION)
ZOXIDE_DOWNLOAD_URL="https://github.com/ajeetdsouza/zoxide/releases/download/$ZOXIDE_VERSION/zoxide-${TMP}-x86_64-unknown-linux-musl.tar.gz"
STARSHIP_DOWNLOAD_URL="https://github.com/starship/starship/releases/download/$STARSHIP_VERSION/starship-x86_64-unknown-linux-gnu.tar.gz"
BAT_DOWNLOAD_URL="https://github.com/sharkdp/bat/releases/download/$BAT_VERSION/bat-${BAT_VERSION}-x86_64-unknown-linux-gnu.tar.gz" 
EXA_DOWNLOAD_URL="https://github.com/ogham/exa/releases/download/$EXA_VERSION/exa-linux-x86_64-${EXA_VERSION}.zip" 

