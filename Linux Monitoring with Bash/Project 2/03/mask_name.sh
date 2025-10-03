#!/bin/bash

MASK_REGEX='.*/[a-zA-Z_]{4,}_[0-9]{6}$'

mapfile -t matches < <(find /home /tmp /var \
  \( -type f -o -type d \) \
  ! -path '*/bin/*' ! -path '*/sbin/*' \
  -regextype posix-extended \
  -regex "$MASK_REGEX")

if [[ ${#matches[@]} -eq 0 ]]; then
  echo "No files found"
else
  for path in "${matches[@]}"; do
    echo "Deleting: $path"
    rm -rf "$path"
  done
fi
