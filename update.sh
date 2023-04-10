eval "$(cat core/common.sh)"

get_last_release() {
    git ls-remote --refs --sort="version:refname" --tags "$1" | cut -d/ -f3- | tail -n1; 
}

for name in "${BINARY_LIST[@]}"
do
    UPPER=`echo $name | tr '[:lower:]' '[:upper:]'`
    LATEST_VERSION=$(eval get_last_release \$${UPPER}_REPO)
    eval CURRENT_VERSION="\$${UPPER}_VERSION"
    if [ "$LATEST_VERSION" != "$CURRENT_VERSION" ]; then
        echo_c "info" "$name: current version is $CURRENT_VERSION, latest version is $LATEST_VERSION"
    fi
done
