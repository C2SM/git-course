#!/bin/bash

init_advanced_repo () {
    mkdir ../../advanced_git
    cd ../../advanced_git
    mkdir -p conference_planning
    cd conference_planning
    git init
    cp ../../git-course/advanced/examples/schedule_day1.txt .
    cp ../../git-course/advanced/examples/schedule_day2.txt .

    git add schedule_day1.txt && git commit -m "Add schedule_day1"
    git add schedule_day2.txt && git commit -m "Add schedule_day2"

    ed -s schedule_day1.txt  <<< $'/program/\na\n09:00-11:00: Poster session\n.\nw\nq' > /dev/null
    ed -s schedule_day2.txt  <<< $'/program/\na\n09:00-11:00: Poster session\n.\nw\nq' > /dev/null
    git add * && git commit -m "Add poster sessions in the morning"

    ed -s schedule_day1.txt  <<< $'/session/\na\n11:00-11:15: Coffee break\n.\nw\nq' > /dev/null
    ed -s schedule_day2.txt  <<< $'/session/\na\n11:00-11:15: Coffee break\n.\nw\nq' > /dev/null
    git add * && git commit -m "Add coffee break"
    git branch -m main

}
