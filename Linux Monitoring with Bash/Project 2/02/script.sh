    #!/bin/bash

    LOG_FILE="creation_log.txt"
    MIN_FREE_SPACE_MB=1024

    start_time=$(date +%s)
    start_time_str=$(date '+%Y-%m-%d %H:%M:%S')

    check_free_space() {
    free_mb=$(df --output=avail -m / | tail -1)
    if [ "$free_mb" -le "$MIN_FREE_SPACE_MB" ]; then
        echo "Error: Not enough free space (<= 1 GB)."
        exit 1
    fi
    }
    
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

    readable_dirs=$(find /home /tmp /var -type d 2>/dev/null | grep -vE '/(bin|sbin)(/|$)')

    mapfile -t dirs_array <<< "$readable_dirs"

    total_dirs=${#dirs_array[@]}


    for ((i = 0; i < 100; i++)); do
        check_free_space
        rand_index=$((RANDOM % total_dirs))
        random_dir="${dirs_array[$rand_index]}"
        
        if [ -w "$random_dir" ]; then
            current_path="$random_dir/$(get_name "$FOLDER_LETTERS")"
            mkdir "$current_path"
        fi

         log_item "$current_path" "folder"

        rand_files=$((RANDOM % 30))

        for ((j=0; j < rand_files; j++)); do 
            check_free_space
            file_name=$(get_name "$FILE_NAME_LETTERS")
            full_file="$current_path/$file_name.$FILE_EXT_LETTERS"
            dd if=/dev/zero of="$full_file" bs=1M count="$FILE_SIZE" &>/dev/null
            log_item "$full_file" "file"
        done
    done

end_time=$(date +%s)
end_time_str=$(date '+%Y-%m-%d %H:%M:%S')
duration=$((end_time - start_time))

echo "Script started at: $start_time_str"
echo "Script ended at:   $end_time_str"
echo "Total duration:    $duration seconds"

echo "Script started at: $start_time_str" >> "$LOG_FILE"
echo "Script ended at:   $end_time_str" >> "$LOG_FILE"
echo "Total duration:    $duration seconds" >> "$LOG_FILE"

