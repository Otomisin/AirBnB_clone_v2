#!/usr/bin/env bash

# Add all the Python files to the staging area
git add *.py

# Commit the changes with the filename as the commit message
for file in *.py
do
  filename=$(basename -- "$file")
  extension="${filename##*.}"
  filename="${filename%.*}"
  git commit -m "$filename"
done

# Push the changes to the remote repository
git push
