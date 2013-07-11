#!/bin/bash
# -----------------------------------------------------------------
# sync.sh -- Super simple script to upload to S3 using s3cmd.
# Copyright 2013 Michael Kelly (michael@michaelkelly.org)
#
# This program is released under the terms of the GNU General Public
# License as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# Wed Jul 10 23:51:20 EDT 2013
# -----------------------------------------------------------------

cfg=$HOME/.s3cfg
bucket=s3://www.michaelkelly.org
dir=www

if [[ ! -f $cfg ]]; then
  echo "Config file $cfg does not exist. Aborting."
  exit 2
fi

echo "Synchronizing directory $PWD/$dir"

s3cmd -n --acl-public sync $dir/ $bucket

echo -n "ok? [y/N] "
read ok

if [[ "$ok" != "y" ]]; then
  echo "No. Abort."
  exit 1
fi

s3cmd --acl-public sync $dir/ $bucket
