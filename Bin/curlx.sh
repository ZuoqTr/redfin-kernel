#!/bin/bash
# curlx - Download with fallback options

URL="$1"
OUTPUT="$2"

if [ -z "$URL" ]; then
    echo "Usage: curlx <url> [output_file]"
    exit 1
fi

# Try curl first, then wget
if command -v curl &> /dev/null; then
    if [ -n "$OUTPUT" ]; then
        curl -sL "$URL" -o "$OUTPUT"
    else
        curl -sL "$URL"
    fi
elif command -v wget &> /dev/null; then
    if [ -n "$OUTPUT" ]; then
        wget -q "$URL" -O "$OUTPUT"
    else
        wget -qO- "$URL"
    fi
else
    echo "Neither curl nor wget found!"
    exit 1
fi
