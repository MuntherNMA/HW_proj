#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define OPTSTRING "nfw"

typedef struct params_s {
  bool use_newline;
  bool use_flush;
  bool redirect_to_file;
} params_t;

static void
fill_default_params(params_t* params)
{
  params->use_newline = false;
  params->use_flush = true;
  params->redirect_to_file = false;
}

static void
get_params(int argc, char *argv[], params_t* params)
{
  int opt;

  fill_default_params(params);

  while ((opt = getopt(argc, argv, OPTSTRING)) != -1) {
    switch (opt) {
    case 'n':
      params->use_newline = true;
      break;
    case 'f':
      params->use_flush = true;
      break;
    case 'w':
      params->redirect_to_file = true;
      break;
    default:
      fprintf(stderr, "Usage: %s [-n] [-f] [-w]\n", argv[0]);
      exit(EXIT_FAILURE);
    }
  }
}

int main(int argc, char *argv[])
{
  params_t params;

  get_params(argc, argv, &params);

  if (params.redirect_to_file) {
    freopen("output.txt", "w", stdout);
    freopen("output.txt", "w", stderr);
  }

  if (params.use_newline)
    fputs("STDOUT\n", stdout);
  else
    fputs("STDOUT", stdout);

  if (params.use_flush)
    fflush(stdout);

  if (params.use_newline)
    fputs("STDERR\n", stderr);
  else
    fputs("STDERR", stderr);

  if (params.use_flush)
    fflush(stderr);

  return 0;
}