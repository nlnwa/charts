#!/bin/sh

function bumpPatchVersion() {
    # store piped input to function
    local stdin=$(cat -)

    # get incremented patch version
    local patch_version=$(echo "${stdin}" | grep -E '^version:' | cut -d' ' -f2 | awk -F. '{print $3 + 1}')

    # replace patch version
    echo "${stdin}" | sed -re "s/(^version: [0-9]\.[0-9]\.)[0-9]/\1${patch_version}/"
}


function usage() {
    echo "Usage: cat path/to/Charts.yaml | $0"
}

# exit if no arguments or stdin is tty
if [ -t 0 ]; then
    usage
    exit 1
fi

cat - | bumpPatchVersion
