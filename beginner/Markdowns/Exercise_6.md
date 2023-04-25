## Exercise 6

## Objective
   * Learn how to deal with merge conflicts:
       * Undo merge
       * Choose preferred version
       * Modify file directly
    
## Structure

In this exercise we will change the same file on different branches in a way that causes a merge conflict. We will also have to deal with a merge request when trying to pull from a remote repository because "someone else" made a conflicting change remotely.

## Helper Functions
The following helper functions in the file *helpers.sh* are written by C2SM and are **NOT** **part of Git**. They will set up simple repositories for you that have a short Git history, so that you have something to work with.

For this exercise, we will use the following functions from this file:
   * **init_exercise:** This will create the *beginners_git* directory in the parent directory of the *git-course* directory. It will also delete any old version of the *beginners_git* directory, so don't use the *beginners_git* directory to save any work.
   * **reset:** This will delete the *beginners_git* directory and allows you a clean restart of the exercise in case you messed it up completely.
   * **init_repo_remote:** This will set up a Git repository with a first version of *schedule_day1.txt* and a remote repository containing the same version of *schedule_day1.txt* on a different branch called *updated_schedules*.
   * **commit_to_remote_by_third_party:** This will make a commit to the remote Git repository to create an artificial merge conflict when pulling.

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

In this exercise we are going to use a repository together with a remote repository containing the file _schedule_day1.txt_. Let's initialize it with our helper function.


```bash
# this line will set up a local and a remote Git repository
init_repo_remote
```

### Now let's make a change in the schedule and commit it
Remember to do all modifications of the schedules directly via Jupyter Notebooks:
   * Go to folder *beginners_git/conference_planning*
   * Open _schedule_day1.txt_
   * Change the workshop to a second poster session


```bash
# Change the workshop to a poster session and commit


```

### Add a remote repository

Let's add the remote repository to our local repository as we did in the previous exercise.

The setup script has already created one for you to use at: 

**../conference_planning_remote**

Use the above line as the *remote_path* to the remote repository.


```bash
# use "git remote add <some_remote_name> <remote_path>" to add the remote 

```


```bash
# Get information from remote branch with "git fetch <my_remote>"

```


```bash
# Check which branches are available

```

### Now make a different change in the same file on the _updated_schedules_ branch
  * Switch to the *updated_schedules* branch
  * Change the workshop to a talk in *beginners_git/conference_planning/schedule_day1.txt*
  * Commit your changes


```bash
# Switch to updated_schedules

```


```bash
# Change workshop to talk and commit


```

### Merge the *updated_schedules* branch into the *main* branch
We have decided to use the schedule on the *updated_schedules* branch. So we want to merge that branch into the *main* branch.
* Switch to *main* branch
* Merge *updated_schedules* into *main* branch


```bash
# Go to the main branch

```


```bash
# Merge the updated_schedules branch into the main branch
# make sure to always add a commit message when merging with "-m <my commit message>"

```

### Solve merge conflict
If you've done everything "right", something went "wrong" and the output should look like this:
```
CONFLICT (content): Merge conflict in schedule_day1.txt
Automatic merge failed; fix conflicts and then commit the result.
```

Looks like we run into a merge conflict. This happened because we made changes on the *main* branch and the *updated_schedules* branch at the same part of the file, and Git doesn't know which changes it should take. Let's see how to fix this. 

Have a look into the file _schedule_day1.txt_. You will see something like this:
``` 
<<<<<<< HEAD
13:30-15:00: Poster session
=======
13:30-15:00: Talk professor C.
>>>>>>> updated_schedules 
```

The top line is the HEAD, referring to the branch you are currently on (here *main*), and the second line refers to the branch you wanted to merge (here *updated_schedules*).

Here are two ways to resolve a merge conflict:

1) You can adjust the file directly and delete the lines, which were added by the merge conflict except the lines you want to keep. Now the merge conflict is resolved and you can add _schedule_day1.txt_ and finally make a commit of the merge.

2) If you know you want to just use the version of the file on the *HEAD* branch (_ours_) or the version on the merging branch (_theirs_), you can select the preferred version with ```git restore schedule_day1.txt --ours``` or ```git restore schedule_day1.txt --theirs``` respectively. The restored file must be added before the final merge is being committed.

If you're afraid that everything is screwed up and you don't know what to do, just run ```git merge --abort``` and everything will be back to where it was before your tried to merge.

Let's deal with the merge conflict!

### Abort merge


```bash
# Abort the merge commit and check if the file is set back to its previous version

```

### 1) Edit file directly to resolve conflict
Create the same merge conflict again by trying to merge the *updated_schedules* branch into the *main* branch.


```bash
# Merge again

```

Now go to the file and select the version you want. To do this, remove all of the conflict markers from the file (<<<<<<< HEAD, =======, >>>>>>> updated_schedules) and the lines belonging to *HEAD* or the merging branch (*updated_schedules*) depending on which solution you want to keep.

Stage the file once you have resolved the conflict with `git add`. Staging the file tells Git that the conflicts have been resolved. Note that Git does not check the file for conflict tags; it trusts you that you to have removed them all, so you need to be sure.
* Go to the conflicting file and delete the appropriate lines (don't forget saving)
* Stage the adapted file
* Commit merge


```bash
# Stage schedule_day1.txt

```


```bash
# Finalize merge commit (don't forget to add a commit message)

```

### 2) Restore preferred version from command line
First, we need to create a new conflict. To do this, go to the *main* and *updated_schedules* branches, respectively, and make different changes on the SAME line. Don't forget to commit the changes before switching between the branches.


```bash
# Make a change to the schedule and commit it to the main branch


```


```bash
# Switch to the updated_schedules branch

```


```bash
# Make a change at the SAME line and commit


```


```bash
# Go back to the main branch and try to merge the updated_schedules branch


```

Now try to solve the merge conflict with ```git restore schedule_day1.txt --theirs/ours```.


```bash
# Restore the version of your favorite branch

```


```bash
# Add and commit your favorite solution


```

### Merge conflict when trying to pull remote branch
We will now learn how to deal with another type of merge conflict that can easily occur when working with remote branches that other people are working on at the same time.

To clean things up, let's first switch to the *updated_schedules* branch and push our latest commits to the remote branch.


```bash
# Switch to updated_schedules

```

As you can see from the Git message, we are ahead of the remote branch. So before we continue, we want to push our local changes.


```bash
# Push changes to remote branch

```

Now change the first event to "Introduction talk" in _/conference_planning/schedule_day1.txt_ and commit.


```bash
# Change the first event to "Introduction" and commit your changes


```

What we didn't realize is that someone changed something on the remote branch while we were working on the file. If we now try to pull the remote branch, we will run into a merge conflict.

To mimic a person making changes to the same file at the same time, we use another helper function.


```bash
# Run helper function to commit to the same file remotely
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
