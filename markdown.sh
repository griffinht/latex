#!/bin/bash

FILE="$1"
if [ -z "$FILE" ]; then
  FILE='*'
fi

pandoc -i $FILE.md -o $FILE.pdf

inotifywait -e close_write -m -r --format %f . | 
  while read -r file; do 
    if [[ "$file" == $FILE.md ]]; then
      pandoc -i "$file" -o "$FILE".pdf;
    fi;
  done

