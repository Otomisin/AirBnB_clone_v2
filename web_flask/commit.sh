#!/bin/bash

# Add all changes
git add -A

# Get the list of files that have been modified
files=$(git diff --name-only)

# Loop through each file and commit with its filename as the commit message
for file in $files
do
  git commit -m "$file"
done

git push