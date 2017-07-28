#!/bin/bash
# -----------------------------------------------------------------
# sync.sh -- Super simple script to upload to S3 using the AWS CLI.
# Copyright 2013 Michael Kelly (michael@michaelkelly.org)
#
# This program is released under the terms of the GNU General Public
# License as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# Sun Jan 18 16:33:35 EST 2015
# -----------------------------------------------------------------
set -u
set -e

cfg=$HOME/.aws/config
profile=mkorg
bucket=s3://www.michaelkelly.org
dir=www

which aws || (echo "'aws' command not found. Aborting."; exit 2)
[ -f $cfg ] || (echo "Config file $cfg does not exist. Aborting."; exit 2)

echo "Synchronizing directory $PWD/$dir"
aws --profile="$profile" \
  s3 sync "$dir" "$bucket" \
  --acl=public-read --cache-control=max-age=3600
