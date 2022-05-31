## Exercise 6

## Goals
   * Learn how to deal with merge conflicts:
       * Undo merge
       * Choose preferred version
       * Adapt file directly
    
## Structure

In this exercise we will change the same file on different branches in a way that we create a merge conflict. There will also be a change in the remote repository, which will equally lead into a merge conflict when trying to pull from that branch.
Again, the exercise consists of short descriptions about a specific Git command, followed by a practical part where you can execute appropriate Git commands.

In order to allow a smooth exercise, there are some functions written by C2SM in the file *helpers.sh* that are **NOT** part of Git. For this exercise we use the following functions from that file:
   * **init_exercise:** It will create the *work* directory and navigate into it 
   * **reset:** It will delete the *work* folder and enable you a clean restart of the exercise in case you completely mess it up
   * **init_repo_remote:** setup a Git repository containing a first version of _schedule_day1_ and a remote repo containing the same version of _schedule_day1_ on a different branch called "updated_schedules".

_**Reminder:** all text enclosed with `<>` denotes a placeholder to be replaced by a specific string appropriate in your context._

_**Reminder:** Always run `git commit` and `git merge` with a git message `-m <meaningful_message>`. Otherwise Git may try to open the Git editor, which does not work on jupyter notebook and will break your current session._

### Initialization


```bash
# check current directory with "pwd"
pwd
# go to folder of this exercise using "cd"

```


```bash
# execute this code at the very beginning to get access to the helper functions
source ../helpers.sh
init_exercise
```

***
### Optional: clear notebook and restart
**In case you mess up your notebook completely,  
execute** ***reset*** **in the following cell. This will restore a clean environment!**



```bash
## only execute in case of (serious) trouble ##
## it will delete your entire work-directory ##
reset
```

***
## Exercise

In this exercise we are going to use a repository together with a remote repository containing the file _schedule_day1_. Let's initialize it with our helper function.


```bash
# this line will setup the local and the remote Git-repositories
init_repo_remote
```

### Now let's make a change in the schedule and commit it
Remember to do all modifications of the schedules directly via Jupyter Notebooks:
   * Go to folder ~*Exercise_6/work/conference_planning*
   * Open _schedule_day1_
   * Change the workshop to a poster session


```bash
# Change the workshop to a poster session and commit

```

### Add a remote repository

Let's add the remote repository to our local repository like in the previous exercise.

The setup script has already created one that you can use at: 

**../conference_planning_remote**

Use the line above as *remote_path* to the remote repository.


```bash
# use "git remote add <some_remote_name> <remote_path>" to add the remote 

```


```bash
# Get information from remote branch with "git fetch <my_remote>

# Check which branches are available

```

### Now make a different change in the same file on the _updated_schedules_ branch
  * Switch to the _**updated_schedules**_ branch
  * Change the workshop to a talk in ~*Exercise_6/work/conference_planning/schedule_day1*
  * Commit your changes


```bash
# Switch to updated_schedules

```


```bash
# Change workshop to talk and commit

```

### Merge the _updated_schedules_ branch into the _main_ branch
We decided to use the schedule on the _**updated_schedules**_ branch. Therfore, we want to merge this branch into the _**main**_ branch.


```bash
# Go to main branch and merge the updated_schedules branch
# make sure to always add a commit message when merging with -m <my commit message>

```

### Solve merge conflict
If you've done everything "right", something has gone "wrong" and the output should look like the following:
```
CONFLICT (content): Merge conflict in schedule_day1
Automatic merge failed; fix conflicts and then commit the result.
```

We apparently run into a merge conflict. This happened because we did changes on the _**main**_ branch and the _**updated_schedules**_ branch at the same part of the file and Git doesn't know which changes it should take. Let's see how to solve this. 

Have a look into the file _schedule_day1_. You will see something like this:
``` 
<<<<<<< HEAD
13:30-15:00: Poster session
=======
13:30-15:00: Talk professor C.
>>>>>>> updated_schedules 
```

The upper line is the HEAD, referring to the branch you are currently on (here _**main**_), and the second line refers to the branch you wanted to merge (here _**updated_schedules**_).

There are different ways to solve a merge conflict

1) If you are afraid that everything is messed up and you don't know what to do, just run ```git merge --abort``` and everything is set back to what it was before you were trying to merge.

2) You can adapt the file directly and delete the lines, which were added by the merge conflict except the lines you want to keep. Now the merge conflict is solved and you can add _schedule_day1_ and finally make a commit of the merge.

3) If you know you want to just use the file on the _**HEAD**_ branch (_ours_) or on the merging branch (_theirs_), you can select the preferred version with ```git restore schedule_day1 --ours``` or ```git restore schedule_day1 --theirs``` respectively. The restored file needs to be added before the final merge is being committed.

Let's try all of the three versions!

### 1) Abort merge


```bash
# Abort the merge commit and check if the file is set back to its previous version

```

### 2) Edit file directly to solve conflict


```bash
# Merge again

```

Now go to the file and select your preferred version. Therefore, remove all of the conflict markers from the file (<<<<<<< HEAD, =======, >>>>>>> updated_schedules) and the lines belonging to _**HEAD**_ or the merging branch (_**updated_schedules**_) depending on which solution you want to keep.

Stage the file once you have resolved the conflict with `git add`. Staging the file indicates to Git that the conflicts have been resolved. Note that Git does not check the file for conflict markers at this point; it is trusting you that you have removed them all, so you must be sure.


```bash
# Stage schedule_day1 and finalize the merge commit (don't forget to add a commit message)

```

### 3) Restore preferred version on command line
To create a new merge conflict adapt the schedule on the _**main**_ branch on the SAME line as on the _**updated_schedules**_ branch and commit the changes to the branches respectively.


```bash
# Make a change and commit on the main branch

```


```bash
# Switch to the updated_schedules branch

```


```bash
# Make a change at the same line and commit

```


```bash
# Go back to main branch and try to merge the updated_schedules branch

```

Now try to solve the merge conflict with ```git restore schedule_day1 --theirs/ours```.


```bash
# Restore the version of your favorite branch

```


```bash
# Commit the merge with your favorite solution (don't forget to add the solution first)

```

### Merge conflict when trying to pull remote branch
We just realized that we forgot an introduction talk to the conference. Switch to the _**updated_schedules**_ branch and change the first event to "Introduction" in _~/conference_planning/schedule_day1_ and commit your changes.


```bash
# Switch to updated_schedules

```


```bash
# Change the first event to "Introduction" and commit your changes"

```

What we didn't notice is that someone changed something on the remote branch while we were working on the file. When we now pull try to pull the remote, we will again run into a merge conflict.


```bash
# This command will do that "unnoticed" change on the remote branch
commit_to_remote_by_third_party
```


```bash
# Make sure you are on the updated_schedules branch and try to pull with "git pull"

```

Unless you already set how to pull in your Git config, you will get a message like this:
```
hint: You have divergent branches and need to specify how to reconcile them.
hint: You can do so by running one of the following commands sometime before
hint: your next pull:
hint: 
hint:   git config pull.rebase false  # merge
hint:   git config pull.rebase true   # rebase
hint:   git config pull.ff only       # fast-forward only
hint: 
hint: You can replace "git config" with "git config --global" to set a default
hint: preference for all repositories. You can also pass --rebase, --no-rebase,
hint: or --ff-only on the command line to override the configured default per
hint: invocation.
```
Read the hints and the explanations below carefully and choose your preferred setting.

`# merge`: This option will handle pull requests the same way as when merging a branch, i.e., the merge will not be automatically committed.

`# rebase`: This option will commit a merge directly in case there are no conflicts. Otherwise you will have to solve the conflicts before continuing (Git will tell you all necessary steps)

`# fast-forward only`: This option will only do a merge in case there are no conflicts, otherwise nothing will be done (we do not recommend this option, to undo it, you need to run `git config pull.ff false`)


```bash
# Choose your preferred way of pulling

```


```bash
# Now pull again

```

Again, you ran into a merge conflict. You are now ready to solve the conflict yourself!


```bash

```
