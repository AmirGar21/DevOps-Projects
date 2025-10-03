#!/bin/bash

LOG_FILE="../02/creation_log.txt"

if [ "$1" != "2" ]&&[ "$#" -ne 1 ]; then 
    echo "Usage: <1> - log file parsing, <2> - creation date parsing, <3> name's mask parsing unless you are using <2> mode where you have to specify the start date and the end date "
    exit 1
fi

if ! [[ "$1" =~ [1-3] ]]; then
    echo "Only 1,2,3 parameters are available"
    exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' not found!"
    exit 1
fi

if [ "$1" = "1" ]; then
    source ./logs_parser.sh
fi

if [ "$1" = "2" ]; then 
    source ./time_delete.sh 
fi

if [ "$1" = "3" ]; then
    source ./mask_name.sh
fi

