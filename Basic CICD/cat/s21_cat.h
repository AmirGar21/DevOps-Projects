#ifndef S21_CAT_H
#define S21_CAT_H

#include <ctype.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct flg {
  int b;
  int e;
  int n;
  int s;
  int t;
  int v;
} flg_t;

int flg_parser(int argc, char *argv[], flg_t *flg);
int read_file(char *argv[], flg_t *flg);
void linecounter(int *str_count, int ch, int first_line, flg_t *flg,
                 int *last_symbol);
void v_output(char ch);

#endif