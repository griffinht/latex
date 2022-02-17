#!/bin/bash

FILE="$1"
if [ -z "$FILE" ]; then
  FILE='*'
fi

inotifywait -e close_write -m -r --format %w%f . |
  while read -r file; do
    echo "$file"
    if [[ "$file" == $FILE.md ]]; then
      pandoc -i "$file" -o "$(echo $file | rev | cut -f 2- -d '.' | rev).pdf";
    fi;
  done

