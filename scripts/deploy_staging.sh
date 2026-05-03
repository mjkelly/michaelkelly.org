#!/bin/bash
set -u
set -e
cfg=$HOME/.aws/config
profile=admin
bucket=s3://staging.michaelkelly.org
dir=public
cf_id=
scripts=$(dirname $0)

which aws || (echo "'aws' command not found. Aborting."; exit 2)
[ -f $cfg ] || (echo "Config file $cfg does not exist. Aborting."; exit 2)

echo "=== Building ==="
${scripts}/generate.sh

echo "=== Deploying ==="

echo "Special handling for .well-known directory..."
aws --profile="$profile" \
  s3 cp "$dir/.well-known/openpgpkey" "$bucket/.well-known/openpgpkey" \
  --recursive \
  --content-type=application/octet-stream \
  --cache-control=max-age=3600

echo "Synchronizing directory $PWD/$dir ..."
aws --profile="$profile" \
  s3 sync "$dir" "$bucket" \
  --cache-control=max-age=3600

if [[ -n "$cf_id" ]]; then
  echo "Invalidating CloudFront..."
  aws --profile=admin \
    cloudfront create-invalidation \
    --distribution-id "${cf_id}" \
    --paths "/*"
fi
