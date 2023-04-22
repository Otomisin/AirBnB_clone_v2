#!/bin/bash

for file in ./*; do
    if [ -f "$file" ]; then
        message=$(cat "$file")
        git add "$file"
        git commit -m "$message"
    fi
done

git push
