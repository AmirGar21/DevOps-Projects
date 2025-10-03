#!/bin/bash

if [ "$#" -ne 6 ]; then
  echo "Usage: $0 <abs_path> <num_folders> <folder_letters> <num_files> <file_letters> <file_size_kb>"
  exit 1
fi

ABS_PATH="$1"
NUM_FOLDERS="$2"
FOLDER_LETTERS="$3"
NUM_FILES="$4"
FILE_LETTERS="$5"
FILE_SIZE_RAW="$6"


if [[ "$ABS_PATH" != /* ]]; then
  echo "Error: Path must be absolute."
  exit 1
fi

if ! [[ "$NUM_FOLDERS" =~ ^[0-9]+$ ]] || [ "$NUM_FOLDERS" -le 0 ]; then
  echo "Error: Number of folders must be a positive integer."
  exit 1
fi

if ! [[ "$NUM_FILES" =~ ^[0-9]+$ ]] || [ "$NUM_FILES" -le 0 ]; then
  echo "Error: Number of files must be a positive integer."
  exit 1
fi

if [[ "$FILE_SIZE_RAW" =~ ^([0-9]+)([kK][bB])$ ]]; then
  FILE_SIZE="${BASH_REMATCH[1]}"
else
  echo "Error: File size must be in format like 3kb."
  exit 1
fi

if [ "$FILE_SIZE" -gt 100 ]; then
  echo "Error: File size must not exceed 100kb."
  exit 1
fi

FILE_NAME_LETTERS=$(echo "$FILE_LETTERS" | cut -d '.' -f 1)
FILE_EXT_LETTERS=$(echo "$FILE_LETTERS" | cut -d '.' -f 2)

if ! [[ "$FOLDER_LETTERS" =~ ^[a-zA-Z]+$ ]]; then
  echo "Error: Folder letters must contain only English letters (a-z or A-Z)."
  exit 1
fi

if [ "${#FOLDER_LETTERS}" -gt 7 ]; then
  echo "Error: Folder letters length must not exceed 7."
  exit 1
fi


if [ "${#FILE_NAME_LETTERS}" -gt 7 ]; then
  echo "Error: File name letters length must not exceed 7."
  exit 1
fi

if ! [[ "$FILE_NAME_LETTERS" =~ ^[a-zA-Z]+$ ]]; then
  echo "Error: File name letters must contain only English letters (a-z or A-Z)."
  exit 1
fi

if ! [[ "$FILE_EXT_LETTERS" =~ ^[a-zA-Z]+$ ]]; then
  echo "Error: File extension letters must contain only English letters (a-z or A-Z)."
  exit 1
fi

if [ "${#FILE_EXT_LETTERS}" -gt 3 ]; then
  echo "Error: File extension letters length must not exceed 3."
  exit 1
fi

chmod +x script.sh
source ./script.sh
