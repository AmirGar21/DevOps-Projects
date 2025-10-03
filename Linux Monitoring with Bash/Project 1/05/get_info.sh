#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Програма $0 требует путь к катологу"
    exit 1
fi

if [[ ! -d "$1" ]]; then 
    echo "Ошибка: "$1" не является каталогом"
    exit 1
fi 

folder_amount=$(find "$1" -type d | wc -l)

echo "Total number of folders(including all nested ones): $folder_amount"

top5=$(du -h "$1" --max-depth=1 2>/dev/null | sort -hr | head -n 5 | awk '{print $2, $1}')

echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
printf "%s\n" "$top5"


file_num=$(find "$1" -type f | wc -l)

echo "Total number of files = $file_num"

conf_files=$(find "$1" -type f -name "*.conf" | wc -l)
text_files=$(find "$1" -type f -name "*.txt" | wc -l)
executables=$(find "$1" -type f -executable | wc -l)
log_files=$(find "$1" -type f -name "*.log" | wc -l)
archives=$(find "$1" -type f \( -name "*.tar" -o -name "*.gz" -o -name "*.zip" \) | wc -l)
links=$(find "$1" -type l | wc -l)

printf "Number of:\n"
printf " Configuration files (with the .conf extension) = %d\n" "$conf_files"
printf " Text files = %d\n" "$text_files"
printf " Executable files = %d\n" "$executables"
printf " Log files (with the extension .log) = %d\n" "$log_files"
printf " Archive files = %d\n" "$archives"
printf " Symbolic links = %d\n" "$links"


top10_files=$(find "$1" -type f -exec stat --format="%s %n" {} + | sort -n -r | head -n 10 | while read size file; do
    file_type=$(file -b "$file" | cut -d' ' -f1)
    human_size=$(numfmt --to=iec-i --suffix=B "$size")
    echo " - $file, $human_size, $file_type"
done | nl)

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$top10_files"

top10_exec=$(find "$1" -type f -executable -exec stat --format="%s %n" {} + | sort -nr | head -n 10 | while read -r size path; do
    human_size=$(echo "$size" | numfmt --to=iec)  
    md5sum "$path" | awk -v s="$human_size" '{print "- " $2, s, $1}'
done | nl)


echo " TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file): "
echo "$top10_exec"