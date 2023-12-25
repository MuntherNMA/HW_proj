#!/bin/bash

gcc -Wall -o fput fput.c

log_w="redirecting to file"
log_n="using newlines"
log_f="using fflush"

for ((i = 1; i < 8; i++)); do
  experiment=""
  file_suffix=""
  description=""

  if ((i & 1)); then
    experiment="${experiment}-w "
    file_suffix="${file_suffix}w"
    description="${log_w}, ${description}"
  fi

  if ((i & 2)); then
    experiment="${experiment}-n "
    file_suffix="${file_suffix}n"
    description="${log_n}, ${description}"
  fi

  if ((i & 4)); then
    experiment="${experiment}-f "
    file_suffix="${file_suffix}f"
    description="${log_f}, ${description}"
  fi

  echo "Experiment: $experiment: ${description%, }"
  ./fputs_experiment "$experiment"

  if ((i & 1)); then
    mv output.txt "output_${file_suffix}.txt"
  fi

done