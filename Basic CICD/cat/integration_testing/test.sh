#!/bin/bash

first_file="test_cat_2.txt"
second_file="test_cat.txt"

# Используем собранный файл из build/
s21_cat_bin="../build/s21_cat"


if [ ! -f "$s21_cat_bin" ]; then
  echo "ERROR: Executable not found: $s21_cat_bin"
  exit 1
fi

echo -e "\n== Running integration tests for s21_cat ==\n"

fails=0

test_1=$(cat $first_file)
test_1_my=$($s21_cat_bin $first_file)

if [ "$test_1" = "$test_1_my" ]; then
    echo -e "default_test: \033[32mSUCCESS\033[0m"
else
    echo -e "default_test: \033[31mFAIL\033[0m"
    fails=$((fails+1))
fi

echo
for flag in -b -n -e -v -s -t; do
    test_2=$(cat $flag $first_file)
    test_2_my=$($s21_cat_bin $flag $first_file)
    if [ "$test_2" = "$test_2_my" ]; then
        echo -e "flags_test ($flag): \033[32mSUCCESS\033[0m"
    else
        echo -e "flags_test ($flag): \033[31mFAIL\033[0m"
        fails=$((fails+1))
    fi
done

echo
test_3=$(cat $first_file $second_file)
test_3_my=$($s21_cat_bin $first_file $second_file)
if [ "$test_3" = "$test_3_my" ]; then
    echo -e "test_many_files: \033[32mSUCCESS\033[0m"
else
    echo -e "test_many_files: \033[31mFAIL\033[0m"
    fails=$((fails+1))
fi


echo
if [ "$fails" -eq 0 ]; then
    echo -e "\033[32mAll integration tests passed.\033[0m"
    exit 0
else
    echo -e "\033[31mSome tests failed: $fails failure(s).\033[0m"
    exit 1
fi
