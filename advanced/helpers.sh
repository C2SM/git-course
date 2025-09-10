#!/bin/bash

script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

init_advanced_repo () {
    mkdir $script_dir/../../advanced_git
    cd $script_dir/../../advanced_git
    mkdir -p conference_planning
    cd conference_planning
    git init
    cp $script_dir/examples/schedule_day1.txt .
    cp $script_dir/examples/schedule_day2.txt .

    git add schedule_day1.txt && git commit -m "Add schedule_day1"
    git add schedule_day2.txt && git commit -m "Add schedule_day2"

    # Insert "09:00-11:00: Poster session" after the line matching "program"
    sed -i '/program/a 09:00-11:00: Poster session' schedule_day1.txt
    sed -i '/program/a 09:00-11:00: Poster session' schedule_day2.txt
    git add * && git commit -m "Add poster sessions in the morning"

    # Insert "11:00-11:15: Coffee break" after the line matching "session"
    sed -i '/session/a 11:00-11:15: Coffee break' schedule_day1.txt
    sed -i '/session/a 11:00-11:15: Coffee break' schedule_day2.txt
    git add * && git commit -m "Add coffee break"

    git branch -m main

    echo -e "Working directory prepared."
    echo -e "\033[31m\033[1mYou have been moved to the 'conference_planning' directory within the 'advanced_git' directory. This is where you start your exercise.\033[0m"
}
