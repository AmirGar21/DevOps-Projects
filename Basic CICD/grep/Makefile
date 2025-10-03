s21_grep:
	gcc -Wextra -Werror -Wall -std=c11 s21_grep.c -o s21_grep

rebuild: clean s21_grep

test: s21_grep
	sh test.sh

style:
	clang-format -style=google -n *.c *.h

clang:
	clang-format -style=google -i *.c *.h

clean:
	rm s21_grep
