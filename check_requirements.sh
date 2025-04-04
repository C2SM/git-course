#!/bin/bash

# Define the log file
LOG_FILE="check_requirements.log"

# Redirect all output to both the terminal and the log file
exec > >(tee -a "$LOG_FILE") 2>&1

# Check if git is installed
if command -v git >/dev/null 2>&1; then
    echo "Git is installed."
    # Check git version
    git_version=$(git --version | awk '{print $3}')
    major_version=$(echo "$git_version" | cut -d. -f1)
    minor_version=$(echo "$git_version" | cut -d. -f2)
    if [[ "$major_version" -lt 2 || ( "$major_version" -eq 2 && "$minor_version" -lt 28 ) ]]; then
        echo "Git version is less than 2.28. Please update Git."
    else
        echo "Git version is 2.28 or higher."
    fi
else
    echo "Git is not installed. Please install Git."
fi

# Check if python is installed
if command -v python >/dev/null 2>&1 || command -v python3 >/dev/null 2>&1; then
    echo "Python is installed."
else
    echo "Python is not installed. Please install Python."
fi

# Check GitHub account and SSH key by trying to clone a repository
if git clone git@github.com:C2SM/git-course.git test_ssh_key >/dev/null 2>&1; then
    echo "GitHub account and SSH key are set up correctly."
    rm -rf test_ssh_key
else
    echo "GitHub account or SSH key is not set up correctly. Please check your settings."
fi