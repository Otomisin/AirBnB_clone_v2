#!/bin/bash

# add all new and modified files to the staging area
git add .

# loop through the modified files
for file in $(git diff --name-only --cached); do
  # ignore files in the appenv/ directory
  if [[ "$file" == appenv/* ]]; then
    continue
  fi
  
  # get the filename without the path and extension
  filename=$(basename "$file" .$(echo "$file" | awk -F . '{print $NF}'))
  # create the commit with the filename as the commit message
  git commit -m "$filename" "$file"
done
