## Exercise 3

## Goals
   * Restore version of files at some point in the Git history
   * Merge two branches (without merge conflicts)
   * Delete unused branches
   
## Structure
In this exercise we will continue working on planning the two-day conference using schedule_day1 and schedule_day2 for planning each day. First we need to revert the schedules to a specific commit. Then we modify the same file, but in different branches. Finally, we merge all our changes into branch main.

Again the exercise consists of short descriptions about a specific Git command (less detailed than in previous exercises), followed by a hands-on part for you to execute appropiate git commands.

In order to allow a smooth exercise, there are some functions written by C2SM in the file *helpers.sh* that are **NOT** part of Git. For this exercise we us the following functions from that file:
   * **init_exercise:** It will create the *work* directory and navigate into it 
   * **reset:** It will delete the *work* folder and enable you a clean restart of the exercise in case you completely mess it up
   * **init_broken_repo:** setup a Git repository as in exercise 2, but with commits, that we need to revert first.

_**Reminder:** all text enclosed with `<>` denotes a placeholder to be replaced by a specific string appropriate in your context._

_**Reminder:** Always run `git commit` and `git merge` with a git message `-m <meaningful_message>`. Otherwise Git may try to open the Git editor, which does not work on jupyter notebook and will break your current session._

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

### Restore versions of files at some point in the Git history


```bash
# this line will setup a simple Git repository for you
init_broken_repo
```

To see the schedules or make changes we use the Jupyter Notebook again:
   * On the start page go to folder *~/Exercise_3/work/conference_planning*
   * Open *schedule_day1* and *schedule_day2*
   
As you can see, the schedules of both days now start with talks.

Initially we planned poster sessions in the mornings but the invited professors had only time in the morning to give their talks, so we changed the poster sessions to talks.

However, the professors have now cancelled their talks and we want to have the poster sessions in the morning again.

To not do the work twice, we want to reuse the old schedules we designed in the first place.

We can use `git restore` to get any version of a file along its Git history.

Simply execute `git restore --source=<specific_commit_hash> <your_schedule>`.

Let's try it out for schedule_day1 first!


```bash
# restore the version of schedule_day1 before commit: "Change poster sessions to talks"
# "git restore --source=<commit_hash> <file_to_restore>"
# (Alternative - includes 'git add': git checkout <commit_hash> <file_to_restore>)

```

Refresh the jupyter notebook page showing schedule_day1 and have a look at it.
You see, we now have a poster session in the morning again.

Do the same for schedule_day2.


```bash
# restore schedule_day2 before commit "Change poster sessions to talks"

```


```bash
# check if git tracked our changes

# add and commit our updated schedules

```


```bash
# git log to see the Git-history

```

Every *commit hash* is unique, so you can always go to any version of the tracked files, *also* across different branches.

All of a sudden we decide to not have the workshop on day 1 anymore. Therefore
restore schedule_day1 before the commit "Add workshops"


```bash
# restore schedule_day1 at right commit

# commit schedule_day1

```


```bash
# execute git log --oneline for short summary

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
In this part of the excercise we continue writing on *schedule_day1*.
There are two sections in schedule_day1 to modify in a seperate branch:
   * daily-program
   * evening activity
   
Note: Try to avoid merge conflicts by not changing the same part of a file in two branches you want to merge (usually the main branch and a branch you plan to merge into the main branch). There are *of course* ways to deal with merge conflicts and we will learn how to deal with them later in this course. However, if you just follow the descriptions below, you should not run into a merge conflict.


```bash
# switch to a new branch for the evening activity

```

To edit the schedules use jupyter notebook as described before.
   
**Do not forget to save schedule_day1 before coming back here**


```bash
# make commit

```


```bash
# go back to the main branch using git switch

```

Now create another brunch for adding more to the daily program and add at least one other event to the daily program.


```bash
# switch to a new branch and add more events to the daily program

```

**To edit the schedules, follow the instructions above!**


```bash
# make commit

```


```bash
# go back to branch main and run "git branch"

```

`git branch` should output something like that:
```
  evening_activity
* main
  daily_program
```

Let's put the pieces of the schedules together. For that we use the *git merge* functionality.  
It allows us to merge files with different text from different branches.


To merge all modification from branch *evening_activity* into branch *main* we type:

`git merge evening_activity`


```bash
# merge evening activity into main

```

Git just performed a so called *Fast-forward merge*. This means, that there is a linear path
between the two merged branches. See the slides for more detailed information about it. 

**Most important:**  
Git does **NOT** create an additional commit to perform the merge. It only appends the commit from the branch *evening_activity* to the HEAD.


```bash
# git log to see the added commit

```


```bash
# display content of schedule_day1 using "cat"

```

**As you see, we succesfully took over our changes from branch evening_activity**

Let's do the same, but for the modifications in branch *daily_program*


```bash
# merge daily_program into main 
# Important: add a merge message (-m "Merge daily_program") or your jupyter notebook may crash

```

For this merge, Git performs a so-called *3-way merge*, because the path between the two branches is not linear anymore due to the merge of branch *evening_activity*.
Therefore Git creates a *merge-commit* to bring the two histories together.



```bash
# display content of schedule day1 using "cat"

```


```bash
# git log --oneline to see the added commit

```

Your git log looks like the following:
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

After merging it is good practice to delete merged branches.  

The command `git branch -d <branch_to_delete>` can do this.


```bash
# delete branch evening_activity

```


```bash
# delete branch daily_program

```

**Congrats, your Git skills are getting better and better!**
