## Exercise 5

## Objective
* Add a remote repository
* Explore remote branches
* Exchange information with a remote repository

## Structure
In this exercise we will start to learn about working with remote repositories. A remote repository is usually stored online at GitHub or GitLab. For simplicity, the remote repository for this exercise will be located in the same directory locally, but the workflow would be basically the same.

## Helper Functions
The following helper functions in the file *helpers.sh* are written by C2SM and are **NOT** **part of Git**. They will set up simple repositories for you that have a short Git history, so that you have something to work with.

For this exercise, we will use the following functions from this file:
   * **init_exercise:** This will create the *beginners_git* directory in the parent directory of the *git-course* directory. It will also delete any old version of the *beginners_git* directory, so don't use the *beginners_git* directory to save any work.
   * **reset:** This will delete the *beginners_git* directory and allows you a clean restart of the exercise in case you messed it up completely.
   * **init_simple_repo_remote:** This will create the same simple repository as before, along with a second repository to be used as a remote.

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

In this exercise, we will use the same simple repository that we used before, along with a remote repository. Let's initialize it with our helper function.


```bash
# this line sets up a simple Git repository along with a remote Git repository
init_simple_repo_remote
```

### Add a remote repository

Let's add a remote repository to our local repository.  

The setup script has already created one for you to use, which you can find here: 

**../conference_planning_remote**

Use the above line as the *remote_path* to the remote repository.


```bash
# use "git remote add <remote_name> <remote_path>" to add the remote 

```


```bash
# use "git remote -v" to check that the remote was added correctly

```

The output should look something like this:
```
my_remote  ../conference_planning_remote (fetch)
my_remote  ../conference_planning_remote (push)
```

### Get information from remote

So far we have only given our local repository the location of the remote repository. Now, we want to get the information from the remote repository.


```bash
# use "git fetch <remote_name>" to get information from the remote

```


```bash
# use "git branch -a" to view ALL of the branches in your local repository

```

The output should look like this:
```
* main
  remotes/my_remote/main
  remotes/my_remote/updated_schedules
```

You can see that you now have a local branch (*main*), and remote branches (*remotes/\<remote_name>/\<branch_name>*).
### Add remote branch to local repository and make changes

The remote repository has a branch called *updated_schedules*.
Let's check out this branch to work on it.  


```bash
# use "git switch updated_schedules"

```

The output should look like this:
```
branch 'updated_schedules' set up to track remote branch 'updated_schedules' from 'my_remote/updated_schedules'.
Switched to a new branch 'updated_schedules'
```

Git has automatically created a local branch in our local repository that tracks the remote branch from the remote repository.

Now let's make a change to the *updated_schedules* branch.
Remember to make all changes to the schedules directly in Jupyter Notebooks:
   * Go to folder *beginners_git/conference_planning*
   * Open *schedule_day1.txt*
   * Add more information to your schedule, i.e. talks, workshops, etc.

**Don't forget to save your changes before you come back!**


```bash
# add and commit your changes


```


```bash
# check the status of your repository

```

The output should look like this:
```
On branch updated_schedules
Your branch is ahead of 'my_remote/updated_schedules' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
```

### Send information to remote repository

Finally, we want to commit our changes back to the remote repository. To commit to a remote repository, use the `git push` command.


```bash
# use "git push"  

```

The output should look something like this:
```
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 8 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 350 bytes | 350.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
To ../conference_planning_remote
   1dacf13..80e64e8  updated_schedules -> updated_schedules
```

Now go to the folder *../conference_planning_remote* and check if you can see your changes in *schedule_day1.txt*.
Why can you not see them? (Think before you read the solution!)

**Solution**: In the remote repository you are still on the *main* branch. To change this, use the [Unix command](../Unix_Commands.ipynb) `cd` to navigate to *../conference_planning_remote* and switch to the *updated_schedules* branch. Can you now see your changes?


```bash
# Navigate to the remote repository

```


```bash
# Switch to the "updated_schedule" branch on the remote repository

```
