#!/bin/bash

set -e

# Calculate the absolute path to helpers.sh
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
HELPERS_PATH="$SCRIPT_DIR/../helpers.sh"

if [ ! -f "$HELPERS_PATH" ]; then
    echo -e "\033[31m\033[1mError: helpers.sh not found at $HELPERS_PATH\033[0m"
    exit 1
fi

source "$HELPERS_PATH"

# Function to handle test failures
fail_test() {
    echo -e "\033[31m\033[1m$1: FAIL\033[0m"
    exit 1
}

# Test reset function
echo "Testing reset function..."
reset_output=$(reset)
if [[ "$reset_output" == *"restore clean working directory"* ]]; then
    echo -e "\033[32m\033[1mreset function: PASS\033[0m"
else
    fail_test "reset function"
fi

# Test get_default_branch_name function
echo "Testing get_default_branch_name function..."
default_branch=$(get_default_branch_name)
if [[ "$default_branch" == "main" || "$default_branch" == "master" ]]; then
    echo -e "\033[32m\033[1mget_default_branch_name function: PASS\033[0m"
else
    fail_test "get_default_branch_name function"
fi

# Test init_exercise function
echo "Testing init_exercise function..."
init_exercise
if [[ -d "$SCRIPT_DIR/../../../beginners_git" ]]; then
    echo -e "\033[32m\033[1minit_exercise function: PASS\033[0m"
else
    fail_test "init_exercise function"
fi

# Test init_repo_empty_schedule function
echo "Testing init_repo_empty_schedule function..."
init_repo_empty_schedule
if [[ -f "$SCRIPT_DIR/../../../beginners_git/conference_planning/conference_schedule.txt" ]]; then
    echo -e "\033[32m\033[1minit_repo_empty_schedule function: PASS\033[0m"
else
    fail_test "init_repo_empty_schedule function"
fi

# Test init_simple_repo function
echo "Testing init_simple_repo function..."
init_simple_repo
if [[ -d "$SCRIPT_DIR/../../../beginners_git/conference_planning/.git" ]]; then
    echo -e "\033[32m\033[1minit_simple_repo function: PASS\033[0m"
else
    fail_test "init_simple_repo function"
fi

# Test init_simple_repo_remote function
echo "Testing init_simple_repo_remote function..."
init_simple_repo_remote
if [[ -d "$SCRIPT_DIR/../../../beginners_git/conference_planning_remote/.git" ]]; then
    echo -e "\033[32m\033[1minit_simple_repo_remote function: PASS\033[0m"
else
    fail_test "init_simple_repo_remote function"
fi

# Test init_repo function
echo "Testing init_repo function..."
init_repo
if [[ -d "$SCRIPT_DIR/../../../beginners_git/conference_planning/.git" ]]; then
    echo -e "\033[32m\033[1minit_repo function: PASS\033[0m"
else
    fail_test "init_repo function"
fi

# Test init_repo_remote function
echo "Testing init_repo_remote function..."
init_repo_remote
if [[ -d "$SCRIPT_DIR/../../../beginners_git/conference_planning/.git" && -d "$SCRIPT_DIR/../../../beginners_git/conference_planning_remote/" ]]; then
    echo -e "\033[32m\033[1minit_repo_remote function: PASS\033[0m"
else
    fail_test "init_repo_remote function"
fi

# Test commit_to_remote_by_third_party function
echo "Testing commit_to_remote_by_third_party function..."
commit_to_remote_by_third_party
if [[ -d "$SCRIPT_DIR/../../../beginners_git/conference_planning/.git" && -d "$SCRIPT_DIR/../../../beginners_git/conference_planning_remote/" ]]; then
    echo -e "\033[32m\033[1mcommit_to_remote_by_third_party function: PASS\033[0m"
else
    fail_test "commit_to_remote_by_third_party function"
fi