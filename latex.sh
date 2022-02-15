#!/bin/bash

trap 'pdflatex *.tex && rm *.aux *.log *.dvi' SIGINT

latex *.tex;

inotifywait -e close_write -m -r --format %f . | 
  while read -r file; do 
    if [[ "$file" == *.tex ]]; then
      latex "$file";
    fi;
  done

