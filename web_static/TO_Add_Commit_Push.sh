#!/bin/bash

# Add all new, modified, and deleted files to Git
git add -A

# Check if there are any changes to commit
if git diff --quiet --cached; then
    echo "No changes to commit."
else
    # Commit changes for all files
    for file in $(git diff --name-only --cached); do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            message="Task ${filename%.*}"
            git commit -m "$message" "$file"
        else
            message="Deleted file: $file"
            git commit -m "$message"
        fi
    done
    
    # Push changes to remote repository
    git push
    
    echo "Changes committed and pushed to remote repository."
fi
