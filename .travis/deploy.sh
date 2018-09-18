#!/usr/bin/env bash

set -e

PACKAGE_DIR=/tmp/out
mkdir -p ${PACKAGE_DIR}

# Package charts (except veidemann)
find repo/ -name Chart.yaml -printf "%h\n" | grep -v "repo/veidemann$" | xargs helm package -u -d ${PACKAGE_DIR}
# Package veidemann chart
helm package -u -d ${PACKAGE_DIR} repo/veidemann

# Checkout gh-pages
git remote set-branches origin gh-pages
git fetch
git checkout gh-pages

# Copy new packages to gh-pages
cp ${PACKAGE_DIR}/* .

# Create/merge helm repository index
helm repo index --url ${REPO_URL} --merge index.yaml .

# Stage packages and index file
git add *.tgz index.yaml

git commit -m "Travis build: $TRAVIS_BUILD_NUMBER"

# Push to gh-pages with ssh credentials
git push git@github.com:${TRAVIS_REPO_SLUG}.git
