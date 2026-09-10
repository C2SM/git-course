#!/bin/bash

# Tests the helper functions of the beyond course. Run it on every platform the
# course is taught on (Linux, macOS, Git Bash) before the course, see issue #147.

# Calculate the absolute path to helpers.sh
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
HELPERS_PATH="$SCRIPT_DIR/../helpers.sh"
REPO="$SCRIPT_DIR/../../../git_beyond/conference_planning"

if [ ! -f "$HELPERS_PATH" ]; then
    echo -e "\033[31m\033[1mError: helpers.sh not found at $HELPERS_PATH\033[0m"
    exit 1
fi

# shellcheck source=/dev/null
source "$HELPERS_PATH"

# Array to store test results
declare -a TEST_RESULTS
FAILED=0

fail_test () {
    TEST_RESULTS+=("$1: \033[31m\033[1mFAIL\033[0m")
    FAILED=1
}

pass_test () {
    TEST_RESULTS+=("$1: \033[32m\033[1mPASS\033[0m")
}

check () {
    if [ "$2" = "$3" ]; then
        pass_test "$1"
    else
        fail_test "$1 (expected '$3', got '$2')"
    fi
}

# Test insert_after function
echo "Testing insert_after function..."
tmpfile=$(mktemp)
printf 'alpha\nbeta\n' > "$tmpfile"
insert_after 'alpha' 'INSERTED' "$tmpfile"
check "insert_after function" "$(sed -n 2p "$tmpfile")" "INSERTED"
rm -f "$tmpfile"

# Test init_beyond_repo function
echo "Testing init_beyond_repo function..."
init_beyond_repo > /dev/null 2>&1
if [ -d "$REPO/.git" ]; then
    pass_test "init_beyond_repo creates the repository"
else
    fail_test "init_beyond_repo creates the repository"
fi

cd "$REPO" || exit 1

check "init_beyond_repo default branch" "$(git branch --show-current)" "main"
check "init_beyond_repo commit count" "$(git rev-list --count HEAD)" "4"
check "init_beyond_repo clean tree" "$(git status --porcelain)" ""
check "poster session inserted" "$(sed -n 3p schedule_day1.txt)" "09:00-11:00: Poster session"
check "coffee break inserted" "$(sed -n 4p schedule_day2.txt)" "11:00-11:15: Coffee break"

# Test that init_beyond_repo is idempotent (it is re-run by participants who get stuck)
echo "Testing init_beyond_repo is repeatable..."
init_beyond_repo > /dev/null 2>&1
check "init_beyond_repo is repeatable" "$(git rev-list --count HEAD)" "4"

# Test reset_beyond_repo function
echo "Testing reset_beyond_repo function..."
echo "leftover junk" >> schedule_day1.txt
git switch -c stray_branch > /dev/null 2>&1
reset_beyond_repo > /dev/null 2>&1
check "reset_beyond_repo discards changes" "$(git status --porcelain)" ""
check "reset_beyond_repo returns to main" "$(git branch --show-current)" "main"

# Print summary
echo -e "\n\033[1mTest Summary:\033[0m"
for result in "${TEST_RESULTS[@]}"; do
    echo -e "$result"
done

exit $FAILED
