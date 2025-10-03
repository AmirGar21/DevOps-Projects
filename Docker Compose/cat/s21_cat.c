#define _GNU_SOURCE
#include "s21_cat.h"

int flg_parser(int argc, char *argv[], flg_t *flg);
int read_file(char *argv[], flg_t *flg);

int main(int argc, char *argv[]) {
  flg_t flg = {0};
  int error = flg_parser(argc, argv, &flg);

  while (optind < argc) {
    error = read_file(argv, &flg);
    optind++;
  }
  return error;
}

int flg_parser(int argc, char *argv[], flg_t *flg) {
  int c;
  int pars_result = 0;
  int index;
  static struct option options[] = {
      {"number-nonblank", 0, 0, 'b'},
      {"number", 0, 0, 'n'},
      {"squeeze-blank", 0, 0, 's'},
      {0, 0, 0, 0},
  };

  while ((c = getopt_long(argc, argv, "bEnsTvet", options, &index)) != -1) {
    switch (c) {
      case 'b':
        flg->b = 1;
        break;
      case 'E':
        flg->e = 1;
        break;
      case 'n':
        flg->n = 1;
        break;
      case 's':
        flg->s = 1;
        break;
      case 'T':
        flg->t = 1;
        break;
      case 'v':
        flg->v = 1;
        break;
      case 'e':
        flg->e = 1;
        flg->v = 1;
        break;
      case 't':
        flg->t = 1;
        flg->v = 1;
        break;
      default:
        pars_result = -1;
        break;
    }
  }
  return pars_result;
}

void v_output(char ch) {
  if (iscntrl(ch) && ch != '\n' && ch != '\t' && ch != 127) {
    putchar('^');
    putchar(ch + 64);
  } else if (ch == 127) {
    putchar('^');
    putchar('?');
  } else {
    putchar(ch);
  }
}

void linecounter(int *str_count, int ch, int first_line, flg_t *flg,
                 int *last_symbol) {
  if (flg->b) {
    if ((ch != '\n' && *last_symbol == '\n') || first_line == 1) {
      printf("%6d\t", *str_count);
      (*str_count)++;
    }
  } else if (flg->n) {
    if (*last_symbol == '\n' || first_line == 1) {
      printf("%6d\t", *str_count);
      (*str_count)++;
    }
  }
  *last_symbol = ch;
}

int read_file(char *argv[], flg_t *flg) {
  int read_result = 0;
  FILE *file;
  file = fopen(argv[optind], "r");

  if (file != NULL) {
    int str_count = 1;
    int empty_str_count = 0;
    int last_symbol = 0;
    int first_line = 1;

    while (1) {
      int cur_c = fgetc(file);
      if (cur_c == EOF) {
        break;
      }

      if (flg->s && cur_c == '\n' && last_symbol == '\n') {
        empty_str_count++;
      } else {
        empty_str_count = 0;
      }

      if (!(empty_str_count > 1)) {
        linecounter(&str_count, cur_c, first_line, flg, &last_symbol);

        if (flg->e && cur_c == '\n') {
          printf("$");
        }

        if (flg->t && cur_c == '\t') {
          printf("^");
          cur_c = 'I';
        }

        if (flg->v) {
          v_output(cur_c);
        } else {
          putchar(cur_c);
        }
      }

      first_line = 0;
      last_symbol = cur_c;
    }
    fclose(file);
  } else {
    read_result = -1;
  }
  return read_result;
}
