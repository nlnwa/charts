#!/bin/sh

function bumpPatchVersion() {
    # store piped input to funtion
    local stdin=$(cat -)

    # get line number containing version of $CHART_NAME and store it in NR
    local nr=$(echo "${stdin}" | awk "/$1/ {f=1} f==1 && /version/ {print NR}" | head -1)

    # get incremented patch version
    local patch_version=$(echo "${stdin}" | awk "NR == ${nr}" | awk -F. '{print $3 + 1}')

    # replace patch version
    echo "${stdin}" | sed -re "${nr}s/(.*version: [0-9]\.[0-9]\.)[0-9]/\1${patch_version}/"
}

function usage() {
    echo "Usage: cat path/to/requirements.yaml | $0 <chart name>"
}

# exit if no arguments or stdin is tty
if [ -z $1 ] || [ -t 0 ]; then
    usage
    exit 1
fi

cat - | bumpPatchVersion $1
