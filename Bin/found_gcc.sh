#!/bin/bash
# found_gcc.sh - Auto-detect GCC paths

if [ -d "$GITHUB_WORKSPACE/gcc64" ]; then
    export GCC_64=$(find $GITHUB_WORKSPACE/gcc64 -name "aarch64-linux-gnu-*" -type f -executable 2>/dev/null | head -1 | xargs dirname 2>/dev/null | xargs dirname 2>/dev/null)
fi

if [ -d "$GITHUB_WORKSPACE/gcc32" ]; then
    export GCC_32=$(find $GITHUB_WORKSPACE/gcc32 -name "arm-linux-gnueabi-*" -type f -executable 2>/dev/null | head -1 | xargs dirname 2>/dev/null | xargs dirname 2>/dev/null)
fi
