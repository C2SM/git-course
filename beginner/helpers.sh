#!/bin/bash

set -e  # stop the script if any command fails

if [[ ! -z $dir_at_startup ]]; then
    echo "You cannot source this file twice"
else
    dir_at_startup=$(pwd)
fi

reset() {
    echo "Go back to $dir_at_startup and restore clean working directory"
    init_exercise &> /dev/null
    echo "Here we go again!"
}

init_exercise() {
    cd "$dir_at_startup"
    rm -rf beginners_git  # remove the directory to start fresh
    mkdir -p beginners_git/conference_planning
    cd beginners_git/conference_planning
    echo "Working directory prepared"
}

init_repo_empty_schedule() {
    cd "$dir_at_startup"
    rm -rf beginners_git  # remove the directory to start fresh
    mkdir -p beginners_git/conference_planning
    cd beginners_git/conference_planning
    cp ../../git-course/beginner/examples/schedule_day1.txt conference_schedule.txt
}

init_simple_repo() {
    cd "$dir_at_startup"
    rm -rf beginners_git  # remove the directory to start fresh
    mkdir -p beginners_git/conference_planning
    cd beginners_git/conference_planning
    git init
    cp ../../git-course/beginner/examples/schedule_day1.txt .
    cp ../../git-course/beginner/examples/schedule_day2.txt .

    git add schedule_day1.txt && git commit -m "Add schedule_day1"
    git add schedule_day2.txt && git commit -m "Add schedule_day2"

    ed -s schedule_day1.txt <<<$'/program/\na\n09:00-11:00: Poster session\n.\nw\nq' > /dev/null
    ed -s schedule_day2.txt <<<$'/program/\na\n09:00-11:00: Poster session\n.\nw\nq' > /dev/null
    git add * && git commit -m "Add poster sessions in the morning"

    ed -s schedule_day1.txt <<<$'/session/\na\n11:00-11:15: Coffee break\n.\nw\nq' > /dev/null
    ed -s schedule_day2.txt <<<$'/session/\na\n11:00-11:15: Coffee break\n.\nw\nq' > /dev/null
    git add * && git commit -m "Add coffee break"

    echo ""
    echo "Your commits so far:"
    echo ""
    git log

    echo ""
    echo "Your schedules:"
    echo ""
    ls
}

init_simple_repo_remote() {
    init_simple_repo &> /dev/null
    cd ..
    git clone conference_planning conference_planning_remote
    cd conference_planning_remote
    git checkout -b "updated_schedules"
    ed -s schedule_day1.txt <<<$'/break/\na\n11:15-12:15: Talk professor A.\n.\nw\nq' > /dev/null
    ed -s schedule_day2.txt <<<$'/break/\na\n11:15-12:15: Talk professor B.\n.\nw\nq' > /dev/null
    git add * && git commit -m "Update schedules"
    git checkout main
   
    cd ../conference_planning
    ls
}

#!/bin/bash

init_repo () {
    init_simple_repo &> /dev/null

    ed -s schedule_day1.txt  <<< $'/break/\na\n11:15-12:15: Workshop ice crystal formation\n.\nw\nq' > /dev/null
    ed -s schedule_day2.txt  <<< $'/break/\na\n11:15-12:15: Workshop secondary ice\n.\nw\nq' > /dev/null
    git add schedule_day1.txt schedule_day2.txt && git commit -m "Add workshops"

    sed -i 's/Poster session/Talk professor C./g' schedule_day1.txt
    sed -i 's/Poster session/Talk professor D./g' schedule_day2.txt

    git add schedule_day1.txt schedule_day2.txt && git commit -m "Change poster sessions to talks"

    echo ""
    echo "Your commits so far:"
    echo ""
    git log

    echo ""
    echo "Your schedules:"
    echo ""
    ls
}

init_repo_remote () {
    cd $dir_at_startup
    mkdir -p ../../../beginners_git/conference_planning
    cd ../../../beginners_git/conference_planning
    git init
    cp ../../git-course/beginner/examples/schedule_day1.txt .

    git add schedule_day1.txt && git commit -m "Add schedule_day1"

    ed -s schedule_day1.txt  <<< $'/program/\na\n09:00-11:00: Poster session\n.\nw\nq' > /dev/null
    git add schedule_day1.txt && git commit -m "Add poster sessions in the morning"

    ed -s schedule_day1.txt  <<< $'/session/\na\n11:00-11:15: Coffee break\n.\nw\nq' > /dev/null
    git add schedule_day1.txt && git commit -m "Add coffee breaks"

    ed -s schedule_day1.txt  <<< $'/break/\na\n11:15-12:15: Talk professor A.\n12:15-13:30: Lunch\n13:30-15:00: Workshop\n15:00-16:00: Talk professor B.\n.\nw\nq' > /dev/null
    git add schedule_day1.txt && git commit -m "Add rest of daily program"

    cd ..
    git clone conference_planning conference_planning_remote
    cd conference_planning_remote
    git checkout -b updated_schedules
    git checkout main

    cd ../conference_planning
    ls
}

# Define the function
commit_to_remote_by_third_party() {

    # Navigate to the root directory of the project
    cd $dir_at_startup

    # Navigate to the remote repository
    cd ../../../beginners_git/conference_planning_remote

    # Create and checkout a new branch called "updated_schedules"
    git checkout -b updated_schedules

    # Copy the schedule_day1.txt file from the course examples to the remote repository
    cp ../../git-course/beginner/examples/schedule_day1.txt .

    # Use sed to replace "Poster session" with "Workshop" in the file
    sed  's/Poster session/Workshop/g' schedule_day1.txt > schedule_day1_tmp.txt

    # Move the modified file back to its original location with the original filename
    mv -f schedule_day1_tmp.txt schedule_day1.txt

    # Add the modified file to the staging area and commit the changes with a message
    git add * && git commit -m "Workshop in the morning"

    # Switch back to the main branch
    git checkout main

    # Navigate back to the local repository
    cd ../conference_planning
}
