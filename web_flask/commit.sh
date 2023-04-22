#!/bin/bash

for file in ./*; do
    if [ -f "$file" ]; then
        message=$(basename "$file")
        git add "$file"
        git commit -m "$message"
    fi
done

git push
