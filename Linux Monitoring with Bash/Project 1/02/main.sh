#!/bin/bash

#!/bin/bash

if [ $# -eq 0 ]; then
    chmod +x print.sh save.sh
    source ./print.sh
    source ./save.sh
else
    echo "ОШИБКА: скрипт не принимает параметры."
    exit 1
fi

exit 0