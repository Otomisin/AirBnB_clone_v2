#!/bin/bash

task_number=1

for file in ./*; do
    if [ -f "$file" ]; then
        message="$(basename "$file") Task"
        git add "$file"
        git commit -m "$task_number-$message"
        task_number=$((task_number+1))
    fi
done

git push
