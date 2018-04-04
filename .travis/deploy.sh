#!/usr/bin/env bash

# Initialize a new git repo
git init /tmp/gh-pages

# Move assets into this repo
mv *.tgz index.yaml /tmp/gh-pages

cd /tmp/gh-pages

git add .

git commit -m "chore(CI): $TRAVIS_BUILD_NUMBER"

git push --force --quiet git@github.com:nlnwa/charts.git master:gh-pages