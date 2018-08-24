#!/usr/bin/env bash

set -e

# Note that $TRAVIS_BRANCH is only equal to correct branch if
# this deploy script is not a pull request or tag build
git checkout $TRAVIS_BRANCH

git add .
git commit -m "Travis build: $TRAVIS_BUILD_NUMBER [skip ci]"
git remote set-url --push origin git@github.com:${TRAVIS_REPO_SLUG}.git
git push
