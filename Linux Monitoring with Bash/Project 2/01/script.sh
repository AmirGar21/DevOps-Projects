#!/bin/bash

LOG_FILE="creation_log.txt"
MIN_FREE_SPACE_MB=1024

get_name() {
    local letters="$1"
    local name=""

    for ((i = 0; i < ${#letters}; i++)); do
        local letter="${letters:$i:1}"
        local repeat=$(( RANDOM % 8 + 4 )) 
        for ((j = 0; j < repeat; j++)); do
            name+="$letter"
        done
    done

    local date_str=$(date +%d%m%y)
    echo "${name}_${date_str}"
}


check_free_space() {
    free_mb=$(df --output=avail -m / | tail -1)
    if [ "$free_mb" -le "$MIN_FREE_SPACE_MB" ]; then
        echo "Error: Not enough free space (<= 1 GB)."
        exit 1
    fi
}

log_item() {
    local path="$1"
    local type="$2"
    local date_created=$(stat -c %y "$path")

    if [ "$type" = "file" ]; then
        local size=$(stat -c %s "$path")
        echo "$path | created: $date_created | size: $size bytes" >> "$LOG_FILE"
    else
        echo "$path | created: $date_created | folder" >> "$LOG_FILE"
    fi
}

current_path="$ABS_PATH"

for ((i=1; i<=NUM_FOLDERS; i++)); do
    check_free_space

    folder_name=$(get_name "$FOLDER_LETTERS") 
    mkdir -p "$current_path/$folder_name"
    log_item "$current_path/$folder_name" "folder"

    current_path="$current_path/$folder_name"

    for ((j=1; j<=NUM_FILES; j++)); do
        check_free_space

        file_name=$(get_name "$FILE_NAME_LETTERS")
        full_file="$current_path/$file_name.$FILE_EXT_LETTERS"

        dd if=/dev/zero of="$full_file" bs=1k count="$FILE_SIZE" &>/dev/null
        log_item "$full_file" "file"
    done
done
