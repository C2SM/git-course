## Exercise 3

## Objective
   * Restore the version of files at some point in the Git history
   * Merge two branches (without merge conflicts)
   * Delete unused branches
   
## Structure
In this exercise we will continue working on the schedule for the two-day conference using *schedule_day1.txt* and *schedule_day2.txt* for each day's schedule. First, we need to revert the schedules back to a specific commit. Then we modify the same file, but on different branches. Finally, we merge all our changes back to the *main* branch.

Again, this exercise will consist of short descriptions of specific Git commands, followed by a hands-on part where you will be able to execute the corresponding Git commands.

## Helper Functions
The following helper functions in the file *helpers.sh* are written by C2SM and are **NOT** **part of Git**. They will set up simple repositories for you that have a short Git history, so that you have something to work with.

For this exercise, we will use the following functions from this file:
   * **init_exercise:** This will create the *beginners_git* directory in the parent directory of the *git-course* directory. It will also delete any old version of the *beginners_git* directory, so don't use the *beginners_git* directory to save any work.
   * **reset:** This will delete the *beginners_git* directory and allows you a clean restart of the exercise in case you messed it up completely.
   * **init_repo:** This sets up a Git repository as in Exercise 2, but with more commits.

## Remarks
_**Reminder:** Any text enclosed in `<>` denotes a placeholder to be replaced with a specific string appropriate to your context, i.e. delete `<>` and replace it with the appropriate word._

_**Reminder:** Always run `git commit` and `git merge` with a git message `-m <meaningful_message>`. Otherwise Git may try to open the Git editor, which does not work on jupyter notebook and will break your current session._

### Initialization


```bash
# check current directory with "pwd"

# go to folder of this exercise using "cd"

```

**To initialize the exercise properly, run this code at the very beginning. Check the Helper Functions section above for more explanation.**


```bash
# source the helpers.sh file to be able to use its functions
source ../helpers.sh
# init exercise
init_exercise
```

***
### Optional: clear notebook and restart
**In case you messed up your notebook completely, execute** ***reset*** **in the following cell. Check the Helper Functions section above for more explanation.**


```bash
## only execute in case of (serious) trouble ##
## it will delete your entire beginners_git directory ##
reset
```

***
## Exercise

### Restore versions of files at any point in the Git history

First, we will set up a simple Git repository for you using one of the helper functions:


```bash
# this line will setup a simple Git repository for you
init_repo
```

Review the schedules for the two days by opening the files as before:

   * On the start page, go to the folder *beginners_git* (outside of *git-course*)
   * Navigate to the folder *conference_planning*
   * Open *schedule_day1.txt* and *schedule_day2.txt*

The schedules for both days start with talks.

Originally we planned poster sessions in the morning, but the invited professors only had time in the morning to give their talks, so we changed the poster sessions to talks (see history).

However, the professors have now canceled their talks and we want to have the poster sessions in the morning again.

To avoid doing the same work twice, we want to reuse the old schedules that we designed in the first place.

We can use `git restore` to get any version of a file along its Git history.

Just run `git restore --source=<specific_commit_hash> <your_schedule>`.

Let's try it out for *schedule_day1.txt* first!


```bash
# restore the version of schedule_day1.txt before commit: "Change poster sessions to talks"
# "git restore --source=<commit_hash> <file_to_restore>"
# (Alternative - includes "git add": "git checkout <commit_hash> <file_to_restore>")

```

Refresh the jupyter notebook page with *schedule_day1.txt* and take a look at it.
You will see that we now have a poster session in the morning again.

Do the same for *schedule_day2.txt*.


```bash
# restore schedule_day2.txt before commit "Change poster sessions to talks"

```


```bash
# check if Git tracked our changes

```


```bash
# add and commit your updated schedules


```


```bash
# "git log" to see the Git history

```

Each *commit hash* is unique, so you can always go to any version of the tracked files, *even* across different branches.

Suddenly we decide to not have the workshop on day 1 anymore. So we restore *schedule_day1.txt* before the "Add workshops" commit.


```bash
# restore schedule_day1.txt at right commit

```


```bash
# add and commit schedule_day1.txt


```


```bash
# execute "git log --oneline" for short summary

```

Your output should look similar to:
```
b7bd111 (HEAD -> main) Remove workshop on day1
f6c3f04 Change talks back to poster sessions
5889296 Change poster sessions to talks
464fc92 Add workshop
e53b1e0 Add coffee break
f1b23c1 Add poster sessions in the morning
f636890 Add schedule_day2
206f724 Add schedule_day1
1c1e740 Changed poster sessions to talks
154f0dc Add coffee break
a98abe7 Add poster sessions in the morning
ca117ca Add schedule_day2
b82e094 Add schedule_day1
```


### Merge two branches (without merge conflicts)
In this part of the exercise, we will continue working on *schedule_day1.txt*.
There are two sections in *schedule_day1.txt*, which we will change on separate branches:
   * *daily_program*
   * *evening_activity*
   
Note: Try to avoid merge conflicts by not changing the same part of a file in two branches you want to merge (usually the *main* branch and a branch you want to merge into the *main* branch). There are, of course, ways to deal with merge conflicts, and we will learn how to deal with them later in this course, but for now we will try to avoid them. If you follow the descriptions below, you should not run into a merge conflict.


```bash
# switch to a new branch for the evening activity

```

Open the schedules as described before and add evening activities and don't forget to save your changes. Come back here and commit the changes.


```bash
# add and commit your changes


```


```bash
# go back to the main branch using "git switch"

```

Now create another branch to add more to the daily program. Add at least one more event to the daily program.


```bash
# switch to a new branch and add more events to the daily program

```

Make changes in the files and save them.


```bash
# add and commit your changes


```


```bash
# switch back to branch main and run "git branch"


```

`git branch` should output something like this:
```
  evening_activity
* main
  daily_program
```

Let's put the pieces of the schedules together. For that we use the `git merge` functionality.  
It allows us to merge files with different text from different branches.


To merge all modification from a branch inte the current branch, we type `git merge <branch-to-be-merged>`


```bash
# merge evening activity into main (make sure you are on the main branch for that)

```

Git just performed a so called **Fast-forward merge**. This means that there is a linear path
between the two merged branches. See the slides for more detailed information about it. 

**Most important:**  
Git does **NOT** create an additional commit to perform the merge. It only appends the commit from the branch *evening_activity* to the HEAD.


```bash
# git log to see the added commit

```

Check the contents of the schedules.

As you can see, we successfully merged our changes from the *evening_activity* branch into the *main* branch.

Let's do the same, but for the changes in the branch for the daily program.


```bash
# merge daily_program into main 
# Important: add a merge message (-m "Merge daily_program") or your jupyter notebook may crash

```

For this merge, Git performs what is called a **3-way merge**, because the path between the two branches is no longer linear due to the merge of the branch for planning the evening activities. So Git creates a **merge commit** to merge the two histories together. Take a look at the schedules and see what they look like. Then check out the new history of your current branch.


```bash
# git log --oneline to see the history

```

Your Git log looks like the following:
```
c0d0459 (HEAD -> main) Merge daily_program
b1be3b4 (daily_program) Add talk
4d93eac (evening_activity) Add evening activity
dd09add No more workshop
cc345c6 Revert poster sessions
ebc8d06 Change poster sessions to talks
56c65e8 Add workshops
e0ced97 Add coffee break
90b9b5e Add poster sessions in the morning
2a00ec0 Add schedule_day2
20be4d2 Add schedule_day1
```

### Delete unused branches

After merging, it is good practice to delete merged branches.  

The command `git branch -d <branch_to_delete>` can do this.


```bash
# delete the evening_activity branch

```


```bash
# delete the daily_program branch

```

**Congrats, your Git skills are getting better and better!**
