#!/usr/bin/env bash

git config user.name "$(git log -1 $TRAVIS_COMMIT --pretty="%aN")"
git config user.email "$(git log -1 $TRAVIS_COMMIT --pretty="%cE")"
git checkout gh-pages
#git clone --quiet --branch=gh-pages git@github.com:nlnwa/charts.git /tmp/gh-pages
#mv *.tgz index.yaml /tmp/gh-pages
#cd /tmp/gh-pages
#git add .
#git commit -fm "chore(travis): $TRAVIS_BUILD_NUMBER"
#git push -fq origin gh-pages