#!/bin/bash

# Создаем временные файлы для тестов
echo "Welcome to Linux!
Linux is a free and opensource Operating system that is mostly used by
developers and in production servers for hosting crucial components such as web
and database servers. Linux has also made a name for itself in PCs.
Beginners times looking to experiment with Linux can get started with friendlier linux
distributions such as Ubuntu, Mint, Fedora and Elementary OS." > file1.txt

echo "11. Be attentive and do not miss important things. Check the repository carefully!
12. Always push only to the develop branch! The master branch will be ignored. Work in the src directory.
13. Remember that each task undergoes a series of checks: code style check, static analyzer check, check for correct work with memory, check with a set of autotests, check with a checklist. Be careful.
14. You will come across different tasks on your way. The tasks marked with the asterisk (*) are only for the most reckless ones. They are more difficult and not compulsory. But if you complete them, you will gain extra experience and knowledge.
15. Some things may seem important but they are actually not. 
16. Remember that ultimately the fact of completing the challenge is not as important as HOW you complete it.
17. The main goal of our journey is to understand what \"HOW\" means.
18. Separate the wheat from the chaff." > file2.txt

pattern=f.txt; 

s21_grep_bin="../build/s21_grep"


if [ ! -f "$s21_grep_bin" ]; then
  echo "ERROR: Executable not found: $s21_grep_bin"
  exit 1
fi

# Функция для сравнения результатов с помощью diff
compare_results() {
    expected_output="$1"
    actual_output="$2"

    diff_output=$(diff "$expected_output" "$actual_output")

    if [ -z "$diff_output" ]; then
        echo "Test Passed"
    else
        echo "Test Failed"
        echo "$diff_output"
    fi
}

echo "Testing no flag:"
$s21_grep_bin "linux" file1.txt > output.txt
grep "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -e flag:"
$s21_grep_bin -e "linux" file1.txt > output.txt
grep -e "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -e \"\" -e \"\" flag:"
$s21_grep_bin -e "linux" -e "also" file1.txt > output.txt
grep -e "linux" -e "also" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -i flag:"
$s21_grep_bin -i "linux" file1.txt > output.txt
grep -i "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -v flag:"
$s21_grep_bin -v "linux" file1.txt > output.txt
grep -v "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -c flag with single file:"
$s21_grep_bin -c "linux" file1.txt > output.txt
grep -c "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -l flag with single file:"
$s21_grep_bin -l "linux" file1.txt > output.txt
grep -l "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -n flag:"
$s21_grep_bin -n "linux" file1.txt > output.txt
grep -n "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -o flag:"
$s21_grep_bin -o "linux" file1.txt > output.txt
grep -o "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -h flag:"
$s21_grep_bin -h "linux" file1.txt > output.txt
grep -h "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -s flag:"
$s21_grep_bin -s "linux" file1.txt > output.txt
grep -s "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -f flag:"
$s21_grep_bin -f $pattern file1.txt > output.txt
grep -f $pattern file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -in flag:"
$s21_grep_bin -in "linux" file1.txt > output.txt
grep -in "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -iv flag:"
$s21_grep_bin -iv "linux" file1.txt > output.txt
grep -iv "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -cv flag:"
$s21_grep_bin -cv "linux" file1.txt > output.txt
grep -cv "linux" file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -nf flag:"
$s21_grep_bin -nf $pattern file1.txt > output.txt
grep -nf $pattern file1.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

# Тестируем флаги и несколько файлов
echo "Testing no flag with multiple files:"
$s21_grep_bin "linux" file1.txt file2.txt > output.txt
grep "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -e flag with multiple files:"
$s21_grep_bin -e "linux" file1.txt file2.txt > output.txt
grep -e "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -e \" \" -e \" \" flag with multiple files:"
$s21_grep_bin -e "linux" -e "also" file1.txt file2.txt > output.txt
grep -e "linux" -e "also" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -i flag with multiple files:"
$s21_grep_bin -i "linux" file1.txt file2.txt > output.txt
grep -i "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -v flag with multiple files:"
$s21_grep_bin -v "linux" file1.txt file2.txt > output.txt
grep -v "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -c flag with multiple files:"
$s21_grep_bin -c "linux" file1.txt file2.txt > output.txt
grep -c "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -l flag with multiple files:"
$s21_grep_bin -l "linux" file1.txt file2.txt > output.txt
grep -l "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -n flag with multiple files:"
$s21_grep_bin -n "linux" file1.txt file2.txt > output.txt
grep -n "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -o flag with multiple files:"
$s21_grep_bin -o "linux" file1.txt file2.txt > output.txt
grep -o "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -h flag with multiple files:"
$s21_grep_bin -h "linux" file1.txt file2.txt > output.txt
grep -h "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -s flag with multiple files:"
$s21_grep_bin -s "linux" file1.txt file2.txt > output.txt
grep -s "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -f flag with multiple files:"
$s21_grep_bin -f f.txt file1.txt file2.txt > output.txt
grep -f f.txt file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -lv flag with multiple files:"
$s21_grep_bin -lv "linux" file1.txt file2.txt > output.txt
grep -lv "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

echo "Testing -ho flag with multiple files:"
$s21_grep_bin -ho "linux" file1.txt file2.txt > output.txt
grep -ho "linux" file1.txt file2.txt > expected_output.txt
compare_results "expected_output.txt" "output.txt"

# Удаляем временные файлы
rm file1.txt file2.txt output.txt expected_output.txt