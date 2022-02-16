#!/bin/bash

FILE="$1"
if [ -z "$FILE" ]; then
  FILE='*'
fi

inotifywait -e close_write -m -r --format %f . | 
  while read -r file; do 
    echo "$file"
    if [[ "$file" == $FILE.md ]]; then
      pandoc -i "$file" -o "$(echo $file | cut -f 1 -d '.').pdf";
    fi;
  done

