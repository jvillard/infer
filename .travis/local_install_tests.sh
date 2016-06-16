#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# go to the root of the repo -- assumes we are in .travis/
cd "${SCRIPT_DIR}/.."

echo 'Running `infer -- javac examples/Hello.java`'
infer -- javac examples/Hello.java | grep -q 'NULL_DEREFERENCE: *1'
echo

