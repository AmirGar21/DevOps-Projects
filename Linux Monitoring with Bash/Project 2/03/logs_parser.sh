#!/bin/bash



grep 'folder' "$LOG_FILE" | while IFS= read -r line; do
    path=$(echo "$line" | cut -d '|' -f 1 | xargs)

    if [ -e "$path" ]; then
        rm -rf "$path"
        if [ $? -eq 0 ]; then
            echo "Deleted: $path"
        else
            echo "Failed to delete: $path"
        fi
    else
        echo "Not found (already deleted?): $path"
    fi
done