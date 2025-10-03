#!/bin/bash

chmod +x print.sh

read -p "Save this to a file? (Y/N) " choice 
if [[ ${choice} =~ ^[Yy]$ ]]; then 
    filename="$(date +'%d_%m_%y_%H_%M_%S').status"
    ./print.sh > "${filename}"
echo "Information saved to ${filename}"
else 
    echo "information not saved"
fi 