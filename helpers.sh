#!/bin/bash

if [[ ! -z $dir_at_startup ]]; then
    echo "You cannot source this file twice"
else
    dir_at_startup=$(pwd)
fi

reset () {
    echo "Go back to $dir_at_startup"
    cd $dir_at_startup

    echo "Restore clean working directory"
    mkdir -p work
    rm -rf work
    mkdir work
    cd work

    echo "Here we go again!"
}

init_exercise () {
    cd $dir_at_startup
    mkdir -p work
    cd work
    echo "Working directory prepared"
}

init_directory_with_empty_file () {
    mkdir -p conference_planning
    cd conference_planning
    touch conference_schedule.txt
}

init_simple_repo () {
    mkdir -p conference_planning
    cd conference_planning
    git init
    cp ../../../examples/schedule_day1 .
    cp ../../../examples/schedule_day2 .

    git add schedule_day1 && git commit -m "Add schedule_day1"
    git add schedule_day2 && git commit -m "Add schedule_day2"

    ed -s schedule_day1  <<< $'/program/\na\n09:00-11:00: Poster session\n.\nw\nq' > /dev/null
    ed -s schedule_day2  <<< $'/program/\na\n09:00-11:00: Poster session\n.\nw\nq' > /dev/null
    git add * && git commit -m "Add poster sessions in the morning"

    ed -s schedule_day1  <<< $'/session/\na\n11:00-11:15: Coffee break\n.\nw\nq' > /dev/null
    ed -s schedule_day2  <<< $'/session/\na\n11:00-11:15: Coffee break\n.\nw\nq' > /dev/null
    git add * && git commit -m "Add coffee break"

    echo ""
    echo "Your commits so far:"
    echo ""
    git log

    echo""
    echo "Your schedules:"
    echo""
    ls
}

init_simple_repo_remote () {
    mkdir -p conference_planning
    cd conference_planning
    git init
    cp ../../../examples/schedule_day1 .
    cp ../../../examples/schedule_day2 .

    git add schedule_day1 && git commit -m "Add schedule_day1"
    git add schedule_day2 && git commit -m "Add schedule_day2"

    ed -s schedule_day1  <<< $'/program/\na\n09:00-11:00: Poster session\n.\nw\nq' > /dev/null
    ed -s schedule_day2  <<< $'/program/\na\n09:00-11:00: Poster session\n.\nw\nq' > /dev/null
    git add * && git commit -m "Add poster sessions in the morning"

    ed -s schedule_day1  <<< $'/session/\na\n11:00-11:15: Coffee break\n.\nw\nq' > /dev/null
    ed -s schedule_day2  <<< $'/session/\na\n11:00-11:15: Coffee break\n.\nw\nq' > /dev/null
    git add * && git commit -m "Add coffee breaks"

    cd ..
    git clone conference_planning conference_planning_remote
    cd conference_planning_remote
    git checkout -b "updated_schedules"
    ed -s schedule_day1  <<< $'/session/\na\n11:15:-12:15: Talk professor A.\n.\nw\nq' > /dev/null
    ed -s schedule_day2  <<< $'/session/\na\n11:15:-12:15: Talk professor B.\n.\nw\nq' > /dev/null
    git add * && git commit -m "update schedules"
    git checkout master 
   
    cd ../conference_planning
    ls
}

init_broken_repo () {
    init_simple_repo &> /dev/null

    ed -s schedule_day1  <<< $'/break/\na\n11:15-12:15: Workshop ice crystal formation\n.\nw\nq' > /dev/null
    ed -s schedule_day2  <<< $'/break/\na\n11:15-12:12: Workshop secondary ice\n.\nw\nq' > /dev/null
    git add * && git commit -m "Add workshops"

    sed  's/Poster session/Talk professor C./g' schedule_day1 > schedule_day1_tmp
    sed  's/Poster session/Talk professer D./g' schedule_day2 > schedule_day2_tmp

    mv -f schedule_day1_tmp schedule_day1
    mv -f schedule_day2_tmp schedule_day2

    git add * && git commit -m "Change poster sessions to talks"

    echo ""
    echo "Your commits so far:"
    echo ""
    git log

    echo""
    echo "Your schedules:"
    echo""
    ls
}
