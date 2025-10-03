#!/bin/bash

operation="$1"
shift
LOG_FILES=("$@")

if [[ "$operation" = 1 ]]; then
    awk '{ print $0 | "sort -k9n" }' "${LOG_FILES[@]}"
fi

if [[ "$operation" = 2 ]]; then
    awk '{ print $1 }' "${LOG_FILES[@]}" | sort -u
fi

if [[ "$operation" = 3 ]]; then
    awk 'match($0, /"[^"]*" ([45][0-9][0-9]) /, m) { print $0 }' "${LOG_FILES[@]}" 
fi


if [[ "$operation" = 4 ]]; then
     awk 'match($0, /"[^"]*" ([45][0-9][0-9]) /, m) { print $1 }' "${LOG_FILES[@]}" | sort -u
fi

