#!/bin/bash

if [[ ! -z $dir_at_startup ]]; then
    echo "You cannot source this file twice"
else
    dir_at_startup=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
fi

reset () {
    echo "Going back to $dir_at_startup and restore clean working directory"
    init_exercise &> /dev/null
    echo "Here we go again!"
    pwd
}

# determine main or master for default branch name
get_default_branch_name() {
    # Attempt to identify the default branch by querying the remote repository
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')

    # Check if the default branch was found; if not, check local references for main, i.e., master branch
    if [ -z "$default_branch" ]; then
        if git show-ref --verify --quiet refs/heads/main; then
            default_branch="main"
        elif git show-ref --verify --quiet refs/heads/master; then
            default_branch="master"
        else
            echo "Error: Could not determine the default branch name."
            exit 1
        fi
    fi

    echo $default_branch
}

init_exercise () {
    cd $dir_at_startup
    rm -rf ../../beginners_git
    mkdir -p ../../beginners_git
    cd ../../beginners_git
    echo -e "Working directory prepared."
    echo -e "\033[31m\033[1mYou've been moved to the 'beginners_git' directory. This is where you start your exercise.\033[0m"
}


init_repo_empty_schedule () {
    cd $dir_at_startup
    rm -rf ../../beginners_git/conference_planning
    mkdir -p ../../beginners_git/conference_planning
    cd ../../beginners_git/conference_planning
    cp ../../git-course/beginner/examples/schedule_day1.txt conference_schedule.txt
    echo -e "Working directory prepared."
    echo -e "\033[31m\033[1mYou've been moved to the 'conference_planning' directory within the 'beginners_git' directory. This is where you start your exercise.\033[0m"
}

init_simple_repo () {
    cd $dir_at_startup
    rm -rf ../../beginners_git/conference_planning
    mkdir -p ../../beginners_git/conference_planning
    cd ../../beginners_git/conference_planning
    git init

    cp ../../git-course/beginner/examples/schedule_day1.txt .
    cp ../../git-course/beginner/examples/schedule_day2.txt .

    git add schedule_day1.txt && git commit -m "Add schedule_day1"
    git add schedule_day2.txt && git commit -m "Add schedule_day2"

    sed -i '/program/a 09:00-11:00: Poster session' schedule_day1.txt > /dev/null
    sed -i '/program/a 09:00-11:00: Poster session' schedule_day2.txt > /dev/null
    git add * && git commit -m "Add poster sessions in the morning"

    sed -i '/session/a 11:00-11:15: Coffee break' schedule_day1.txt > /dev/null
    sed -i '/session/a 11:00-11:15: Coffee break' schedule_day2.txt > /dev/null
    git add * && git commit -m "Add coffee break"

    echo ""
    echo "Your commits so far:"
    echo ""
    git --no-pager log

    echo""
    echo "Your schedules:"
    echo""
    ls

    echo -e "\033[31m\033[1mYou've been moved to the 'conference_planning' directory within the 'beginners_git' directory. This is where you start your exercise.\033[0m"
}

init_simple_repo_remote () {
    init_simple_repo &> /dev/null
    cd ..
    rm -rf conference_planning_remote
    git clone conference_planning conference_planning_remote
    cd conference_planning_remote
    git checkout -b "updated_schedules"
    sed -i '/break/a 11:15-12:15: Talk professor A.' schedule_day1.txt > /dev/null
    sed -i '/break/a 11:15-12:15: Talk professor B.' schedule_day2.txt > /dev/null
    git add * && git commit -m "update schedules"

    # Dynamically get the default branch name and switch to it
    default_branch=$(get_default_branch_name)
    git checkout "$default_branch"

    cd ../conference_planning

}

init_repo () {
    init_simple_repo &> /dev/null

    sed -i '/break/a 11:15-12:15: Workshop ice crystal formation' schedule_day1.txt > /dev/null
    sed -i '/break/a 11:15-12:15: Workshop secondary ice' schedule_day2.txt > /dev/null
    git add * && git commit -m "Add workshops"

    sed  's/Poster session/Talk professor C./g' schedule_day1.txt > schedule_day1_tmp.txt
    sed  's/Poster session/Talk professor D./g' schedule_day2.txt > schedule_day2_tmp.txt

    mv -f schedule_day1_tmp.txt schedule_day1.txt
    mv -f schedule_day2_tmp.txt schedule_day2.txt

    git add * && git commit -m "Change poster sessions to talks"

    echo ""
    echo "Your commits so far:"
    echo ""
    git --no-pager log

    echo""
    echo "Your schedules:"
    echo""
    ls

    echo -e "\033[31m\033[1mYou've been moved to the 'conference_planning' directory within the 'beginners_git' directory. This is where you start your exercise.\033[0m"
}

init_repo_remote () {
    cd $dir_at_startup
    rm -rf ../../beginners_git/conference_planning
    mkdir -p ../../beginners_git/conference_planning
    cd ../../beginners_git/conference_planning
    git init

    cp ../../git-course/beginner/examples/schedule_day1.txt .

    git add schedule_day1.txt && git commit -m "Add schedule_day1"

    # Edit schedule_day1.txt
    sed -i '/program/a 09:00-11:00: Poster session' schedule_day1.txt > /dev/null
    git add * && git commit -m "Add poster sessions in the morning"

    sed -i '/session/a 11:00-11:15: Coffee break' schedule_day1.txt > /dev/null
    git add * && git commit -m "Add coffee breaks"

    sed -i "/break/a 11:15-12:15: Talk professor A.\n12:15-13:30: Lunch\n13:30-15:00: Workshop\n15:00-16:00: Talk professor B." schedule_day1.txt > /dev/null
    git add * && git commit -m "Add rest of daily program"

    cd ..

    # Clone non-bare remote repository
    rm -rf conference_planning_remote_tmp
    git clone conference_planning conference_planning_remote_tmp

    # Navigate into the cloned repository directory and create update_schedules branch
    cd conference_planning_remote_tmp
    git checkout -b "updated_schedules"

    # Dynamically get the default branch name (main or master, based on the version of git)
    head_ref=$(git symbolic-ref HEAD)
    default_branch=$(basename "$head_ref")

    # Switch to the dynamically determined default branch
    git checkout "$default_branch"

    cd ../

    # Clone bare remote repository and remove non-bare repository
    rm -rf conference_planning_remote
    git clone --bare conference_planning_remote_tmp conference_planning_remote
    rm -fr conference_planning_remote_tmp

    cd conference_planning

    echo""
    echo "Your schedules:"
    echo""
    ls

    echo -e "\033[31m\033[1mYou've been moved to the 'conference_planning' directory within the 'beginners_git' directory. This is where you start your exercise.\033[0m"
}

commit_to_remote_by_third_party() {
    cd $dir_at_startup
    cd ../../beginners_git

    rm -rf conference_planning_remote_tmp
    git clone conference_planning_remote conference_planning_remote_tmp

    cd conference_planning_remote_tmp
    git checkout updated_schedules
    cp ../conference_planning/schedule_day1.txt .
    sed '3s/.*/09:00-11:00: Workshop Git for advanced/' schedule_day1.txt > schedule_day1_tmp.txt
    mv -f schedule_day1_tmp.txt schedule_day1.txt
    git add * && git commit -m "Git workshop in the morning"

    # Dynamically get the default branch name (main or master, based on the version of git)
    default_branch=$(get_default_branch_name)

    # Switch to the dynamically determined default branch
    git checkout "$default_branch"

    cd ..
    rm -rf conference_planning_remote
    git clone --bare conference_planning_remote_tmp conference_planning_remote
    rm -rf conference_planning_remote_tmp

    cd conference_planning
}
