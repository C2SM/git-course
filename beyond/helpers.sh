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

init_beyond_repo () {
    mkdir -p "$script_dir/../../beyond_git"
    cd "$script_dir/../../beyond_git" || return 1
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
    echo -e "\033[31m\033[1mYou have been moved to the 'conference_planning' directory within the 'beyond_git' directory. This is where you start your exercise.\033[0m"
}

# Creates a local bare repository, glossary-tool.git, that stands in for a small
# external project - the kind of thing Exercise 2's submodule points at. This
# keeps the submodule exercise entirely local; Exercise 8 covers the real
# equivalent, a fork on GitHub.
init_submodule_remote () {
    mkdir -p "$script_dir/../../beyond_git"
    cd "$script_dir/../../beyond_git" || return 1
    rm -rf glossary-tool.git glossary-tool_tmp
    mkdir glossary-tool_tmp
    cd glossary-tool_tmp || return 1
    git init -b main -q

    cat > README.md <<'EOF'
# glossary-tool

A tiny glossary of Git terms, used as a submodule in the C2SM Git course.
EOF
    cat > glossary.md <<'EOF'
# Glossary

- **Repository**: A project tracked by Git.
- **Commit**: A snapshot of the project at a point in time.
EOF
    git add README.md glossary.md && git commit -q -m "Add glossary"

    cd ..
    git clone -q --bare glossary-tool_tmp glossary-tool.git
    rm -rf glossary-tool_tmp
}

# Plays the part of a colleague who pushes a change straight to glossary-tool's
# main branch while you are working in the submodule.
commit_to_submodule_remote_by_colleague () {
    cd "$script_dir/../../beyond_git" || return 1
    rm -rf glossary-tool_colleague
    git clone -q glossary-tool.git glossary-tool_colleague
    cd glossary-tool_colleague || return 1
    insert_after 'Commit' '- **Branch**: A movable pointer to a line of commits.' glossary.md
    git commit -q -am "Add a glossary entry for branch"
    git push -q origin main
    cd ..
    rm -rf glossary-tool_colleague
}

# Throw away everything and start the exercises over from a clean state.
reset_beyond_repo () {
    echo "Restoring a clean working directory"
    rm -rf "$script_dir/../../beyond_git"
    init_beyond_repo &> /dev/null
    echo -e "\033[31m\033[1mHere we go again! You are in the 'conference_planning' directory.\033[0m"
    pwd
}
