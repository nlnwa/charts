#!/bin/sh

function setAppVersion() {
    local app_version=$1
    sed -re "s/(appVersion: )(.*)/\1${app_version}/"
}

function usage() {
    echo "Usage: cat path/to/Charts.yaml | $0 <version>"
}

# exit if no arguments or stdin is tty
if [ -z $1 ] || [ -t 0 ]; then
    usage
    exit 1
fi

cat - | setAppVersion $1