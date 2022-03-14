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
    mkdir -p party_planning
    cd party_planning
    touch partyplan.txt
}

init_simple_repo () {
    mkdir -p conference_planning
    cd conference_planning
    git init
    cp ../../../examples/schedule_day1 .
    cp ../../../examples/schedule_day2 .

    git add schedule_day1 && git commit -m "Add schedule_day1"
    git add schedule_day2 && git commit -m "Add schedule_day2"

    echo "09:00-11:00: Poster session" >> schedule_day1
    echo "09:00-11:00: Poster session" >> schedule_day2
    git add * && git commit -m "Add poster sessions in the morning"

    echo "11:00-11:15: Coffee break" >> schedule_day1
    echo "11:00-11:15: Coffee break" >> schedule_day2
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
    mkdir -p party_planning
    cd party_planning
    git init
    cp ../../../examples/flyer_A .
    cp ../../../examples/flyer_B .

    git add flyer_A && git commit -m "add flyer_A"
    git add flyer_B && git commit -m "add flyer_B"

    echo "Doors: 22:00" >> flyer_A
    echo "Doors: 21:00" >> flyer_B
    git add * && git commit -m "add opening time"

    echo "Happy Hour: 23:00 - 24:00" >> flyer_A
    echo "Happy Hour: 22:00 - 24:00" >> flyer_B
    git add * && git commit -m "add happy-hour"

    cd ..
    git clone party_planning party_planning_remote
    cd party_planning_remote
    git checkout -b "updated_flyers"
    echo "Happy Hour: 17:00 - 18:00" >> flyer_A
    echo "Happy Hour: 26:00 - 18:00" >> flyer_B
    git add * && git commit -m "update the flyers"
    git checkout master 
   
    cd ../party_planning
    ls
}

init_broken_repo () {
    init_simple_repo &> /dev/null

    echo "Music: Heavy Metal" >> flyer_A
    echo "Music: Heavy Metal" >> flyer_B

    git add * && git commit -m "Metal Music added"

    sed  's/Heavy Metal/Classical Music/g' flyer_A > flyer_A_tmp
    sed  's/Heavy Metal/Classical Music/g' flyer_B > flyer_B_tmp

    mv -f flyer_A_tmp flyer_A
    mv -f flyer_B_tmp flyer_B

    git add * && git commit -m "Classical Music added"

    echo ""
    echo "Your commits so far:"
    echo ""
    git log

    echo""
    echo "Your flyers:"
    echo""
    ls
}
