#!/bin/bash

echo "--- Building for Release ---"
mkdir -p bin
odin build ./src \
    -out:bin/timber \
    -vet \
    -strict-style \
    -vet-tabs \
    -disallow-do \
    -warnings-as-errors \
    -o:aggressive

# Check if the build command succeeded
if [ $? -ne 0 ]; then
    echo ""
    echo "BUILD FAILED."
    exit 1
fi

echo ""
echo "Release build 'timber' created successfully."

