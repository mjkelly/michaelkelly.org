#!/bin/bash
JEKYLL_ENV=production bundle exec jekyll build
./scripts/git-revision-stamp.sh > ./_site/revision.txt
