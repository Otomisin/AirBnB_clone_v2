#!/bin/bash
git add .
git status | grep 'new file\|modified' | grep -v 'appenv/' | awk '{print $2}' | xargs git commit -m "$1"
