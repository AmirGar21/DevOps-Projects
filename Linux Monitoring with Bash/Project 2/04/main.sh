#!/bin/bash

for ((i=1; i<6; i++)); do
    LOG_FILE="access${i}.log"
    ./generation.sh "$LOG_FILE"
done