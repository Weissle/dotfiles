eval "$(cat core/functions.sh)"
eval "$(cat core/variables.sh)"
get_last_tag_by_git(){
    UPPER=$(upper $1)
    eval REPO=\$${UPPER}_REPO
    echo `git ls-remote --refs --sort="version:refname" --tags "$REPO" | cut -d/ -f3- | tail -n1`
}

get_last_tag_by_github_release(){
    UPPER=$(upper $1)
    eval URL=\$${UPPER}_REPO_BASE/releases/latest
    LATEST_URL=`wget -O /dev/null $URL 2>&1  | grep 'Location' | awk '{print $2}'`
    echo `basename $LATEST_URL`
}

get_last_release() {
    GET_FUNC=
    NAME=$1
    case $NAME in
        "nvim") GET_FUNC=get_last_tag_by_git ;;
        *) GET_FUNC=get_last_tag_by_github_release
    esac
    eval $GET_FUNC "$NAME"
}

for name in "${BINARY_LIST[@]}"
do
    LATEST_VERSION="$(get_last_release $name)"
    UPPER=$(upper $name)
    eval CURRENT_VERSION="\$${UPPER}_VERSION"
    if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
        echo_c "warn" "$name: current version is $CURRENT_VERSION, latest version is $LATEST_VERSION"
    else
        echo_c "info" "$name: current version is $CURRENT_VERSION, this is the latest version."
    fi
done


