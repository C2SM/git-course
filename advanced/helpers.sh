#!/bin/bash

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Insert a line of text after the first line matching a pattern.
# Portable across GNU sed (Linux, Git Bash) and BSD sed (macOS): no -i, and the
# text to append is passed as a literal newline rather than with GNU's "a text".
insert_after () {
    local pattern="$1" text="$2" file="$3"
    local tmp
    tmp=$(mktemp)
    sed "/$pattern/a\\"$'\n'"$text" "$file" > "$tmp" && mv "$tmp" "$file"
}

init_advanced_repo () {
    mkdir -p "$script_dir/../../advanced_git"
    cd "$script_dir/../../advanced_git" || return 1
    rm -rf conference_planning
    mkdir -p conference_planning
    cd conference_planning || return 1
    git init -b main
    cp "$script_dir/examples/schedule_day1.txt" .
    cp "$script_dir/examples/schedule_day2.txt" .

    git add schedule_day1.txt && git commit -m "Add schedule_day1"
    git add schedule_day2.txt && git commit -m "Add schedule_day2"

    insert_after 'program' '09:00-11:00: Poster session' schedule_day1.txt
    insert_after 'program' '09:00-11:00: Poster session' schedule_day2.txt
    git add . && git commit -m "Add poster sessions in the morning"

    insert_after 'session' '11:00-11:15: Coffee break' schedule_day1.txt
    insert_after 'session' '11:00-11:15: Coffee break' schedule_day2.txt
    git add . && git commit -m "Add coffee break"

    echo -e "Working directory prepared."
    echo -e "\033[31m\033[1mYou have been moved to the 'conference_planning' directory within the 'advanced_git' directory. This is where you start your exercise.\033[0m"
}

# Throw away everything and start the exercises over from a clean state.
reset_advanced_repo () {
    echo "Restoring a clean working directory"
    rm -rf "$script_dir/../../advanced_git"
    init_advanced_repo &> /dev/null
    echo -e "\033[31m\033[1mHere we go again! You are in the 'conference_planning' directory.\033[0m"
    pwd
}
