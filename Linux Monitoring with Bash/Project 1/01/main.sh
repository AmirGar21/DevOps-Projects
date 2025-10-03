#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Ошибка: Не введен ни один параметр"
    exit 1
fi 
if [ $# -ne 1 ]; then 
    echo "Ошибка: Принимается только один параметр"
    exit 1
fi
if [[ ! $1 =~ [0-9] ]];
then echo "Параметр $1"
else 
echo "Ошибка. Параметр содержит цифры"
exit 1
fi 

exit 0