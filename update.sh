eval "$(cat core/common.sh)"

get_last_release() {
    git ls-remote --refs --sort="version:refname" --tags "$1" | cut -d/ -f3- | tail -n1; 
}
# if "$(get_last_release $NVIM_REPO)" != $NVIM_VERSION; then
#     echo_c "info" "nvim has a newer version"
# fi
get_last_release $LAZYGIT_REPO
get_last_release $RIPGREP_REPO
get_last_release $FD_REPO
get_last_release $FZF_REPO
get_last_release $ZOXIDE_REPO
get_last_release $STARSHIP_REPO
get_last_release $BAT_REPO
get_last_release $EXA_REPO
