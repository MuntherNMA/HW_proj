#!/bin/bash

rm fput

for ((i = 0; i < 8; i++)); do
  file_suffix=""

  if ((i & 1)); then
    file_suffix="${file_suffix}w"
  fi

  if ((i & 2)); then
    file_suffix="${file_suffix}n"
  fi

  if ((i & 4)); then
    file_suffix="${file_suffix}f"
  fi

  if ((i & 1)); then
    rm "output_${file_suffix}.txt"
  fi
done
