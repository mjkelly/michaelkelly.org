#!/bin/bash
hugo --minify
./scripts/git-revision-stamp.sh > ./public/revision.txt
