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
    echo $1 | tr '[:lower:]' '[:upper:]'
}

rm_prefixv(){
    echo "$1" | cut --characters=2-
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
        eval $EXTRACT_CMD &&\
        rm $FILE_NAME &&\
        echo_c "good" "$NAME: Download finished." || \
        echo_c "error" "$NAME: Failed to download."
    cd $DOTFILES_PATH
}

prepare_binary(){
    NAME=$1
    UPPER_NAME=$(upper $NAME)
    eval FOLDER=$BIN_PATH/${NAME}_\${${UPPER_NAME}_VERSION}
    TARGET_RELATIVE_PATH=$2
    TARGET_PATH="$FOLDER/$TARGET_RELATIVE_PATH"
    URL=$3
    EXTRACT_OPT=${4:-"tar"}
    SYMBOL_PATH=$BIN_SYMBOL_PATH/`basename $TARGET_PATH`
    [ -e "$SYMBOL_PATH" ] && echo_c "info" "$NAME: Symbol exists." && return
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
        cur_path=$PWD
        cd $REPO_PATH
        THX_REPO_URL=`git remote get-url origin`
        if [ "$?" -eq 128 ]; then
            echo_c "error" "$NAME: $REPO_PATH exists and it is not a git repo."
        elif [ "$THX_REPO_URL" != "$REPO_URL" ]; then
            echo_c "error" "$NAME: $REPO_PATH exists and it's origin URL is not target URL."
        else
            echo_c "skip" "$NAME: Existing and is skipped. Pulling ..."
            git pull
        fi
        cd $cur_path
    fi
}
