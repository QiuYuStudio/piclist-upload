#!/bin/bash
# PicList Upload Helper Script
# Usage: upload.sh <image-path> [image-path2 ...]

set -e

# Check if PicList server is running
if ! curl -s http://127.0.0.1:36677/heartbeat > /dev/null 2>&1; then
    echo "Error: PicList server is not running" >&2
    echo "Please start PicList and enable HTTP server (port 36677)" >&2
    exit 1
fi

# Check if at least one argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <image-path> [image-path2 ...]" >&2
    exit 1
fi

# Build JSON array of absolute paths
paths=()
for path in "$@"; do
    # Convert to absolute path
    abs_path=$(realpath "$path" 2>/dev/null || echo "$path")
    
    # Check if file exists
    if [ ! -f "$abs_path" ]; then
        echo "Error: File not found: $path" >&2
        exit 1
    fi
    
    paths+=("\"$abs_path\"")
done

# Join paths with commas
json_list=$(IFS=,; echo "${paths[*]}")

# Upload to PicList
response=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -d "{\"list\": [$json_list]}" \
    http://127.0.0.1:36677/upload)

# Check if upload was successful
if echo "$response" | jq -e '.success' > /dev/null 2>&1; then
    # Extract and print URLs
    echo "$response" | jq -r '.result[]'
else
    echo "Error: Upload failed" >&2
    echo "$response" | jq '.' >&2
    exit 1
fi
