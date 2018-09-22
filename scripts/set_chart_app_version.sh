#!/usr/bin/env sh

set -e

setAppVersion() {
    local chart_yaml=$1
    local app_version=$2

    sed -ri "s/(appVersion: )(.*)/\1${app_version}/" ${chart_yaml}
}

usage() {
    echo "Usage: $0 <path/to/Chart.yaml> <appVersion>" >&2
}

# check correct number of arguments
if [ "$#" -ne 2 ]; then
    usage
    exit 1
fi

setAppVersion $1 $2
