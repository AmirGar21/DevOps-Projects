#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <1|2|3|4>"
    echo "1 - sort by response code"
    echo "2 - unique ips"
    echo "3 - error responses"
    echo "4 - unique ips among error responses"
    exit 1
fi

if ! [[ "$1" =~ [1-4] ]]; then
    echo "Only 1,2,3,4 parameters are available"
    exit 1
fi

operation="$1"

LOG_FILES=(../04/*.log)

./sorting.sh "$operation" "${LOG_FILES[@]}" > sorted.log
