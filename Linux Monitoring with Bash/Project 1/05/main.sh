#!/bin/bash

if [ $# -eq 1 ]; then
start_time=$(date +%s)
 chmod +x get_info.sh
 source ./get_info.sh
 end_time=$(date +%s)
 execution_time=$(($start_time - $end_time))
 echo "Execution time (in seconds) $execution_time"
else
    echo "Скрипт принимает только один параметр."
    exit 1
fi

exit 0

