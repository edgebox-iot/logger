#!/bin/bash

if [ ! -r "$1" ]; then
  echo "Error: file '$1' does not exist or is not readable" >&2
  exit 1
fi

# Open the input file name as first argument of script and read line by line
# For each line, run "make log service=<line>" in the logger directory

while read line; do
    echo "Running make logs service=$line"
    make logs service=$line
done < $1