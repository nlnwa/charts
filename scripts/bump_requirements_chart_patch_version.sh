#!/usr/bin/env sh

set -e

bumpPatchVersion() {
    local requirements_yaml=$1
    local chart_name=$2

    # get line number containing version of $chart_name and store it in NR
    local nr=$(awk "/${chart_name}/ {f=1} f==1 && /version/ {print NR}" ${requirements_yaml} | head -1 | tr -d '\n')

    # get incremented patch version
    local patch_version=$(awk "NR == \"${nr}\"" ${requirements_yaml} | awk -F. '{print $3 + 1}')

    # replace patch version
    sed -ri "${nr}s/(.*version: [0-9]+\.[0-9]+\.)[0-9]+/\1${patch_version}/" ${requirements_yaml}
}

usage() {
    echo "Usage: $0 <path/to/requirements.yaml> <name_of_dependency>" >&2
}

# check correct number of arguments
if [ "$#" -ne 2 ]; then
    usage
    exit 1
fi

bumpPatchVersion $1 $2
