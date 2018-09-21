#!/usr/bin/env sh

set -e

function bumpPatchVersion() {
    local chart_yaml=$1

    # get incremented patch version
    local patch_version=$(grep '^version:' ${chart_yaml} | awk -F. '{print $3 + 1}')

    # replace patch version
    sed -ri "s/(^version: [0-9]+\.[0-9]+\.)[0-9]+/\1${patch_version}/" ${chart_yaml}
}

function usage() {
    echo "Usage: $0 <path/to/Chart.yaml>"
}

# check correct number of arguments
if [ "$#" -ne 1 ]; then
    usage
    exit 1
fi

bumpPatchVersion $1
