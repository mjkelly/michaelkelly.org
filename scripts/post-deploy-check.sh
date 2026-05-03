#!/bin/bash
set -u

scripts=$(dirname $(realpath $0))
site=https://$1
results="$scripts/test-results"

# Helper functions: Use these in your tests

function compare() {
  actual_file="${results}/${_cur_test}.actual"
  expected_file="${results}/${_cur_test}.expected"
  if diff -u ${actual_file} ${expected_file}; then
    echo "===== $_cur_test OK ====="
    rm -f -- "$actual_file" "$expected_file"
    return 0
  else
    echo "===== $_cur_test FAILED ====="
    return 1
  fi
}

function expect_http_200() {
  local path=$1
  actual <(curl --silent -I "${site}${path}" | head -n 1 | awk '{print $2}')
  expected <(echo "200")
  compare
}

function actual() {
  _save actual "$@"
}

function expected() {
  _save expected "$@"
}

# Internal functions - these are forr the helpers. Don't call these from tests.
function _save() {
  local suffix=$1; shift
  local input_fd=$1; shift
  cat < "${input_fd}" > "${results}/${_cur_test}.${suffix}"
}

# Actual tests
# 
# Basic test pattern:
# function test_foo(){
#   test_name=openpgpkey
#   actual $test_name <(actual command that outputs the value)
#   expected $test_name <(echo "expected value")
#   compare $test_name
# }
#
# * use the actual, expected, and compare helpers to avoid managing output
#   files yourself, showing helpful diffs on msimatches.
# * tests must start with "test_" to be automatically called
#
# Did we push at all / did cloudfront invalidate?
function test_revision_txt() {
  actual <(curl --silent $site/revision.txt)
  expected <($scripts/git-revision-stamp.sh)
  compare
}

# test /
function test_top_level(){
  expect_http_200 ""
}

# check that we can access directories without the trailing slash
function test_directory_with_no_slash(){
  expect_http_200 "/projects"
}

# check that we can access directories with trailing slash but with no
# /index.html
function test_directory_with_slash(){
  expect_http_200 "/projects/"
}

# fully specify a file in a subdirectory - this should always work
function test_directory_with_index(){
  expect_http_200 "/projects/index.html"
}

# check files with odd headers / content-types
function test_openpgpkey(){
  actual <(
    curl --silent -I -H "Origin: https://example.com" "$site/.well-known/openpgpkey/hu/pcgudogicctdyjg4eiwtmbdr8mda3fze" \
    | grep -E 'access-control-allow-origin:|content-type:'
  )
  expected <(echo -e "content-type: application/octet-stream\r\naccess-control-allow-origin: *\r")
  compare
}

# test_revision_txt
# test_top_level
# test_directory_with_no_slash
# test_directory_with_slash
# test_directory_with_index
# test_openpgpkey

mkdir "${results}"

for test_func in $(compgen -A function "test_"); do
  _cur_test="$test_func"
  echo "===== $test_func ====="
  $test_func
done

rmdir --ignore-fail-on-non-empty -- "${results}"
