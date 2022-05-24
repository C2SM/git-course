## Exercise 4

## Goals
   * Practice the typical Git workflow
   
## Structure
In this exercise we won't learn any new git commands. We rather repeat all commands and workflows learned in the
previous exercises. To do so we work on the *conference_schedule.txt* document and simulate a possible workflow.
Because it is all repetition, there is less explanation provided.

The raw outline of this workflow:
   * Add events
   * Change events
   * Add more events
   * "Accidentially" delete all files, recover it
   * Change one event in another branch (alternative schedule)
   * Create two additional branches for different evening activity options
   * Merge the alternative schedule into main
   * Delete merged branch
   * Merge your preferred evening activity into main
   * Delete merged branch and unused branch

In order to allow a smooth exercise, there are some functions written by C2SM in the file *helpers.sh* that are **NOT** part of Git. For this exercise we us the following functions from that file:

   * **init_exercise:** It will create the *work* directory and navigate into it 
   * **reset:** It will delete the *work* folder and enable you a clean restart of the exercise in case you completely mess it up
   * **init_empty_folder:** create the directory `conference_planning` and the empty file `conference_schedule.txt` in it.
   
_**Reminder:** all text enclosed with `<>` denotes a placeholder to be replaced by a specific string appropriate in your context._

_**Reminder:** Always run `git commit` and `git merge` with a git message `-m <meaningful_message>`. Otherwise git may try to open the git editor, which does not work on jupyter notebook and will break your current session._

### Initialization


```bash
# check current directory with "pwd"
pwd
# go to folder of this exercise using "cd"

```


```bash
# execute this code at the very beginning to initialize the exercise properly
source ../helpers.sh
init_exercise
```

***
### Optional: clear notebook and restart
**In case you mess up your notebook completely,  
execute** ***reset*** **in the following cell. This will restore a clean environment!**



```bash
## only execute in case of (serious) trouble ##
## it will delete your entire work directory ##
reset
```

***
## Exercise

### Exercise typical Git workflow


```bash
# this line will create the directory `conference_planning` and the empty file `conference_schedule.txt` in it
init_directory_with_empty_file
```


```bash
# init git repository

```


```bash
# execute "ls -a" to also see the hidden git-folder

```

Add the events: talk, coffee break, workshop

Remember to do all modifications of the schedules directly via Jupyter Notebooks:
   * Go to folder *~/Exercise_4/work/conference_planning*
   * Open *conference_schedule.txt*
   * Change file
   * Save changes by clicking on *File* -> *Save*
   
**Don't forget to save your modifications before coming back!**

Please use this way of editing files throughout the exercise.


```bash
# commit your changes

```

The workshop was cancelled and we will do a poster session instead.

Adapt your document accordingly.


```bash
# commit the adapted "conference_schedule.txt"

```

We go on with the planning. Add those three events:
   * Lunch break
   * Another talk
   * Second poster session

Implement these points into your document.


```bash
# commit your changes

```

Check if all of your changes are really tracked by Git.



```bash
# git status

# git log

```

In case you don't have any untracked changes in your repository move on to the next part of this exercise.



**It is already late at night, our concentration is not very high anymore...**

By *accident* we delete all of our existing files...


```bash
# CAUTION: executing this panel deletes all files in the current directory
rm *
```

Thanks to Git we can easily restore files, even if they are deleted.


```bash
# restore deleted files

```

As a next step create a new branch and edit the schedule there, because we are not sure yet if professor X. will accept the talk in the morning.
   * Change talk to workshop


```bash
# create new branch and adjust schedule

```


```bash
# commit changes

```

Switch back to branch *main* and create another branch on top of it.
We want to plan an evening activity but are not sure what it will be:
   * Add an evening activity


```bash
# switch to main, create new branch and add an evening activity

```


```bash
# commit changes

```

Switch to branch *main* and create another branch on top of it:
   * Add an alternative evening activity


```bash
# switch to main, create new branch and add evening activity

```


```bash
# commit changes

```

It's time to get an overview of what we just did.
Our repository has currently 4 branches (names may be different for your case):
   * main (base version of all subsequent branches)
   * alternative_talk (workshop instead of talk)
   * evening_activity (First planned activity)
   * evening_activity_alternative (Alternative activity)
   
Ensure your repository contains the same amount of different branches.


```bash
# display all branches of the Git repository

```

The talk in the morning has not been accepted.
Therefore merge the branch *alternative_talk* into main.

**Remark:** Make sure you are in the main branch before starting the merge, because Git always merges a branch **into** your current branch.



```bash
# merge schedule branch into the main branch

```

Inspect the document and make sure the changes from the merged branch are present.

If everything is ok, make a commit


```bash
# commit merge

```


```bash
# follow good practice and delete merged branches

```

The last step of the planning is to choose one of the two evening activities.
Decide which one you prefer.

Merge the corresponding branch into main.


```bash
# merge your preferred evening activity into main

```


```bash
# delete merged branch

```

There is one unused branch left in our repository.
We want to keep the repository clean and nice. So please delete the unmerged branch as well.

**Remark:** Since we did not merge the remaining branch, a different option is needed to *git branch*


```bash
# delete unused branch

```

**Congrats** 

You already know the most essential Git commands for the local use of Git.

Further exercises will focus more on typical workflows with remote servers like GitHub or Gitlab.
