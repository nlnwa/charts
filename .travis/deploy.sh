#!/usr/bin/env bash

set -e

PACKAGE_DIR=/tmp/out
mkdir -p ${PACKAGE_DIR}

# Package charts (except veidemann)
find repo/ -name Chart.yaml -printf "%h\n" | grep -v "repo/veidemann$" | xargs helm package -u -d ${PACKAGE_DIR}
# Package veidemann chart
helm package -u -d ${PACKAGE_DIR} repo/veidemann

git remote set-branches origin gh-pages
git fetch
git checkout gh-pages
cp ${PACKAGE_DIR}/* .

# Create (or merge with current) helm repository index
helm repo index --url ${REPO_URL} --merge index.yaml .

# Commit and push
git commit -am "Travis build: $TRAVIS_BUILD_NUMBER"
git push git@github.com:${TRAVIS_REPO_SLUG}.git
