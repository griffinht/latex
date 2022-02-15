#!/bin/bash

FILE="$1"
if [ -z "$FILE" ]; then
  FILE='*'
fi

trap 'rm -r '"$FILE"'.aux '"$FILE"'.log '"$FILE"'.dvi' SIGINT

latex $FILE.tex;

inotifywait -e close_write -m -r --format %f . | 
  while read -r file; do 
    if [[ "$file" == $FILE.tex ]]; then
      latex "$file";
    fi;
  done

