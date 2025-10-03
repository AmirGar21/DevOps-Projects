s21_cat:
	gcc -Wextra -Werror -Wall -std=c11  s21_cat.c -o s21_cat

rebuild: clean s21_cat

test: s21_cat
	sh test.sh

style:
	clang-format -style=google -n *.c *.h

clang:
	clang-format -style=google -i *.c *.h

clean:
	rm s21_cat
