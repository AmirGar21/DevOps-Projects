#!/bin/bash

if [ "$#" -ne 3 ]; then 
    echo "Usage: <folder_letters> <file_letters> <file_size_mb>"
    exit 1
fi

FOLDER_LETTERS="$1"
FILE_LETTERS="$2"
FILE_SIZE_RAW="$3"

# Проверки
if [ "${#FOLDER_LETTERS}" -gt 7 ]; then
    echo "Error: Folder letters must be at most 7 characters."
    exit 1
fi

if ! [[ "$FOLDER_LETTERS" =~ ^[a-zA-Z]+$ ]]; then
    echo "Error: Folder letters must contain only a-zA-Z."
    exit 1
fi

FILE_NAME_LETTERS=$(echo "$FILE_LETTERS" | cut -d '.' -f1)
FILE_EXT_LETTERS=$(echo "$FILE_LETTERS" | cut -d '.' -f2)

if ! [[ "$FILE_NAME_LETTERS" =~ ^[a-zA-Z]+$ ]]; then
    echo "Error: File name must contain only a-zA-Z."
    exit 1
fi

if [ "${#FILE_NAME_LETTERS}" -gt 7 ]; then
    echo "Error: File name must be at most 7 letters."
    exit 1
fi

if ! [[ "$FILE_EXT_LETTERS" =~ ^[a-zA-Z]+$ ]]; then
    echo "Error: File extension must contain only a-zA-Z."
    exit 1
fi

if [ "${#FILE_EXT_LETTERS}" -gt 3 ]; then
    echo "Error: File extension must be at most 3 letters."
    exit 1
fi

if [[ "$FILE_SIZE_RAW" =~ ^([0-9]+)([mM][bB])$ ]]; then
    FILE_SIZE="${BASH_REMATCH[1]}"
    if [ "$FILE_SIZE" -gt 100 ]; then
        echo "Error: Max file size is 100mb."
        exit 1
    fi
else
    echo "Error: File size must be in format like 10mb."
    exit 1
fi

source ./script.sh
