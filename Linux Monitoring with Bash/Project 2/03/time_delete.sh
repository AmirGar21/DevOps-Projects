#!/bin/bash

if [ -z "$2" ] || [ -z "$3" ]; then
    echo "Insert date in the format of 'YYYY-MM-DD HH:MM':"
    read start_time_input
    echo "Insert date in the format of 'YYYY-MM-DD HH:MM':"
    read end_time_input
else
    start_time_input=$2
    end_time_input=$3
fi

start_epoch=$(date -d "$start_time_input" +%s 2>/dev/null)
end_epoch=$(date -d "$end_time_input" +%s 2>/dev/null)

if [ -z "$start_epoch" ] || [ -z "$end_epoch" ]; then
    echo "Incorrect date form"
    exit 1
fi

while IFS= read -r line; do

    if [[ "$line" != */* ]]; then
        continue
     fi
    path=$(echo "$line" | cut -d '|' -f 1 | xargs)

    if [ -e "$path" ]; then
        created_time=$(stat -c %Y "$path")

        if [ "$created_time" -ge "$start_epoch" ] && [ "$created_time" -le "$end_epoch" ]; then
            rm -rf "$path"
            if [ $? -eq 0 ]; then
                echo "Deleted: $path"
            else
                echo "Failed to delete: $path"
            fi
        fi
    else
        echo "Not found (already deleted?): $path"
    fi
done < "$LOG_FILE"
