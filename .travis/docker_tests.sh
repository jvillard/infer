#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# assumes we are in .travis/
cd "${SCRIPT_DIR}/../docker"

docker build -t infer .

echo 'Running `infer -- javac /infer/examples/Hello.java`'
docker run -t infer \
  /bin/bash -c \
    'infer -- javac /infer/examples/Hello.java | grep -q "NULL_DEREFERENCE: *1"'
echo

echo 'Running `infer -- clang -c /infer/examples/hello.c`'
docker run -t infer \
  /bin/bash -c \
    'infer -- clang -c /infer/examples/hello.c | grep -q "NULL_DEREFERENCE: *1"'
echo

