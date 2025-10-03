#ifndef S21_GREP_H
#define S21_GREP_H
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_FILES 100
#define MAX_PATTERNS 100
#define MAX_LINE_LENGTH 1024

typedef struct {
  int e, i, v, c, l, n, h, s, f, o;
  char *pattern_buffer[MAX_PATTERNS];
  int pattern_count;
} flg_t;

void handle_flag_e(flg_t *flags, const char *optarg);
void free_pattern_buffer(flg_t *flags);
void process_pattern_file(char *filename, flg_t *flags);
void handle_remaining_arguments(int argc, char *argv[], flg_t *flags,
                                char **file, int *file_count, int optind);
void parse_arguments(int argc, char *argv[], flg_t *flags, char **file,
                     int *file_count);
void free_regex(regex_t *regex, int count);
void process_line(char *line, regex_t *regex, const flg_t *flags, char *file,
                  int line_number, int file_count, int *match_count,
                  int *file_output);
void grep_file(char *file, const flg_t *flags, int file_count);
void print_matches_for_o(char *line, regex_t *regex, int pattern_count,
                         int *file_output, char *file, int file_count,
                         const flg_t *flags);

#endif
