#define _GNU_SOURCE
#include "s21_grep.h"

int main(int argc, char *argv[]) {
  flg_t flags = {0};
  char *files[MAX_FILES] = {NULL};
  int file_count = 0;

  parse_arguments(argc, argv, &flags, files, &file_count);

  for (int i = 0; i < file_count; i++) {
    grep_file(files[i], &flags, file_count);
  }

  free_pattern_buffer(&flags);

  return 0;
}

void handle_flag_e(flg_t *flags, const char *optarg) {
  if (flags->pattern_count >= MAX_PATTERNS) {
    exit(1);
  }
  flags->pattern_buffer[flags->pattern_count++] = strdup(optarg);
}

void free_pattern_buffer(flg_t *flags) {
  for (int i = 0; i < flags->pattern_count; i++) {
    free(flags->pattern_buffer[i]);
  }
}

void process_pattern_file(char *filename, flg_t *flags) {
  FILE *file = fopen(filename, "r");
  if (!file) {
    perror("fopen");
    exit(1);
  }

  char line[MAX_LINE_LENGTH];
  while (fgets(line, sizeof(line), file)) {
    line[strcspn(line, "\n")] = '\0';
    handle_flag_e(flags, line);
  }
  fclose(file);
}

void handle_remaining_arguments(int argc, char *argv[], flg_t *flags,
                                char **file, int *file_count, int optind) {
  if (optind < argc) {
    if (flags->pattern_count == 0) {
      handle_flag_e(flags, argv[optind++]);
    }

    for (int i = 0; optind < argc && i < MAX_FILES; i++, optind++) {
      file[(*file_count)++] = argv[optind];
    }
  }
}

void parse_arguments(int argc, char *argv[], flg_t *flags, char **file,
                     int *file_count) {
  int opt;
  while ((opt = getopt(argc, argv, "e:ivclnhsf:o")) != -1) {
    switch (opt) {
      case 'e':
        flags->e = 1;
        handle_flag_e(flags, optarg);
        break;
      case 'i':
        flags->i = 1;
        break;
      case 'v':
        flags->v = 1;
        break;
      case 'c':
        flags->c = 1;
        break;
      case 'l':
        flags->l = 1;
        break;
      case 'n':
        flags->n = 1;
        break;
      case 'h':
        flags->h = 1;
        break;
      case 's':
        flags->s = 1;
        break;
      case 'f':
        flags->f = 1;
        process_pattern_file(optarg, flags);
        break;
      case 'o':
        flags->o = 1;
        break;
      default:
        exit(1);
    }
  }
  handle_remaining_arguments(argc, argv, flags, file, file_count, optind);
}

void process_line(char *line, regex_t *regex, const flg_t *flags, char *file,
                  int line_number, int file_count, int *match_count,
                  int *file_output) {
  int match = 0;

  for (int i = 0; i < flags->pattern_count; i++) {
    int ret = regexec(&regex[i], line, 0, NULL, 0);
    if (ret == 0) {
      match = 1;
    } else if (ret != REG_NOMATCH) {
      perror("regexec");
      return;
    }
  }

  if (flags->v) {
    match = !match;
  }

  if (match) {
    (*match_count)++;

    if (flags->l && !*file_output) {
      printf("%s\n", file);
      *file_output = 1;
    }

    if (!flags->c && !flags->o) {
      if (file_count > 1 && !flags->h && !flags->l) {
        printf("%s:", file);
      }
      if (flags->n) {
        printf("%d:", line_number);
      }
      if (!flags->l) printf("%s", line);
    }

    if (flags->o) {
      print_matches_for_o(line, regex, flags->pattern_count, file_output, file,
                          file_count, flags);
    }
  }
}

void grep_file(char *file, const flg_t *flags, int file_count) {
  FILE *fp = fopen(file, "r");
  if (!fp) {
    if (!flags->s) {
      perror(file);
    }
    return;
  }

  int regex_flags = REG_EXTENDED | (flags->i ? REG_ICASE : 0);
  regex_t regex[MAX_PATTERNS];

  for (int i = 0; i < flags->pattern_count; i++) {
    int result = regcomp(&regex[i], flags->pattern_buffer[i], regex_flags);
    if (result != 0) {
      perror("regcomp");
      fclose(fp);
      return;
    }
  }

  char line[MAX_LINE_LENGTH];
  int line_number = 1;
  int match_count = 0;
  int file_output = 0;

  while (fgets(line, sizeof(line), fp)) {
    process_line(line, regex, flags, file, line_number++, file_count,
                 &match_count, &file_output);
  }

  if (flags->c) {
    if (file_count > 1 && !flags->h) {
      printf("%s:", file);
    }
    printf("%d\n", match_count);
  }

  for (int i = 0; i < flags->pattern_count; i++) {
    regfree(&regex[i]);
  }

  fclose(fp);
}

void print_matches_for_o(char *line, regex_t *regex, int pattern_count,
                         int *file_output, char *file, int file_count,
                         const flg_t *flags) {
  regmatch_t pmatch;
  for (int i = 0; i < pattern_count; i++) {
    int ret = regexec(&regex[i], line, 1, &pmatch, 0);
    if (ret == 0) {
      if (flags->o) {
        if (file_count > 1 && !*file_output && !flags->h) {
          printf("%s:", file);
          *file_output = 1;
        }
        printf("%.*s\n", (int)(pmatch.rm_eo - pmatch.rm_so),
               line + pmatch.rm_so);
      }
    }
  }
}
