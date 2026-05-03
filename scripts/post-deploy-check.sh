#!/bin/bash
set -u

scripts=$(dirname $0)
site=https://$1

function _compare() {
  local test_name=$1
  actual_file=${test_name}.actual 
  expected_file=${test_name}.expected
  echo "===== ${test_name} ====="
  if diff -u ${actual_file} ${expected_file}; then
    echo "$test_name OK"
    rm -f -- "$actual_file" "$expected_file"
    return 0
  else
    echo "$test_name FAILED"
    return 1
  fi
}

function _expect_http_200() {
  test_name=$1
  path=$2
  actual_file=${test_name}.actual 
  expected_file=${test_name}.expected
  curl --silent -I "$site" | head -n 1 | awk '{print $2}' > "$actual_file"
  echo "200" > "$expected_file"
  _compare $test_name
}

# Did we push at all / did cloudfront invalidate?
function test_revision_txt() {
  test_name=revision_txt
  actual_file=${test_name}.actual 
  expected_file=${test_name}.expected
  curl --silent -o ${actual_file} $site/revision.txt > "$actual_file"
  $scripts/git-revision-stamp.sh > "$expected_file"
  _compare $test_name
}

# test /
function test_top_level(){
  _expect_http_200 top_level ""
}

# check that we can access directories without the trailing slash
function test_directory_with_no_slash(){
  _expect_http_200 directory_with_no_slash "projects"
}

# check that we can access directories with trailing slash but with no
# /index.html
function test_directory_with_slash(){
  _expect_http_200 directory_with_slash "projects/"
}

# fully specify a file in a subdirectory - this should always work
function test_directory_with_index(){
  _expect_http_200 directory_with_index "projects/index.html"
}

# check files with odd headers / content-types
function test_openpgpkey(){
  test_name=openpgpkey
  actual_file=${test_name}.actual 
  expected_file=${test_name}.expected
  curl -I -H "Origin: https://example.com" "$site/.well-known/openpgpkey/hu/pcgudogicctdyjg4eiwtmbdr8mda3fze" | grep -E 'access-control-allow-origin:|content-type:' > $actual_file
  echo -e "content-type: application/octet-stream\r\naccess-control-allow-origin: *\r" > $expected_file
  _compare $test_name
}

test_revision_txt
test_top_level
test_directory_with_no_slash
test_directory_with_slash
test_directory_with_index
test_openpgpkey
