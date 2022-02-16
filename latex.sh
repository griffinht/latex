#!/bin/bash

FILE="$1"
if [ -z "$FILE" ]; then
  FILE='*'
fi

trap 'rm -r '"$FILE"'.aux '"$FILE"'.log '"$FILE"'.dvi' SIGINT

inotifywait -e close_write -m -r --format %f . | 
  while read -r file; do 
    if [[ "$file" == $FILE.tex ]]; then
      latex -interaction nonstopmode "$file";
    fi;
  done

