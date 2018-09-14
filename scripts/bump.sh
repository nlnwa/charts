#!/bin/sh

function setAppVersion() {
    local app_version=$1
    sed -re "s/(appVersion: )(.*)/\1${app_version}/"
}

function bumpChartPatchVersion() {
    local stdin=$(cat -)
    PATCH_VERSION=$(echo "${stdin}" | grep -E '^version:' | cut -d' ' -f2 | awk -F. '{print $3}')
    BUMPED_PATCH_VERSION=$((${PATCH_VERSION} + 1))

    echo "${stdin}" | sed -re "s/(^version: )([0-9]\.[0-9]\.)[0-9]/\1\2${BUMPED_PATCH_VERSION}/"
}

if [ -z $1 ]; then echo "Requires one argument: app version"; exit 1; fi

cat | setAppVersion $1 | bumpChartPatchVersion
