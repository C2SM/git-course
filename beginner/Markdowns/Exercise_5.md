# Exercise 5

# Goals
* Add a remote repository
* Examine remote branches
* Exchange information with a remote repository

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

In this exercise we are going to use the same simple repository that we used in Exercise 2. Let's initialize it with our helper function.   



```bash
# this line will setup the simple Git-repository from Exercise 2 for you
init_simple_repo_remote
```

### Add a remote repository

Let's add a remote repository to our local repository.  

The setup script has already created one that you can use at: 

**../conference_planning_remote**

Use the line above as *remote_path* to the remote repository.


```bash
# use "git remote add <some_remote_name> <remote_path>" to add the remote 

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

So far all we have done is given our local repository the location of the remote repository.  Now, we should get the information from the remote repository.





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

You can see that you now have local branches (`main`), and remote branches (`remotes/<remote_name>/<branch_name>`).  


### Add to local repository

The remote repository has a branch called `updated_schedules`.
Let's check out this branch to work on it.  


```bash
# use "git switch updated_schedules"

```

The output should look like this:
```
Branch 'updated_schedules' set up to track remote branch 'updated_schedules' from 'my_remote'.
Switched to a new branch 'updated_schedules'
```

Git has automatically created a local branch in our local repository that tracks the remote branch from the remote repository.  

Next, let's make a change in the "updated_schedules" branch.  

Make a change in your local repository.
Remember to do all modifications of the schedules directly via Jupyter Notebooks:
   * Go to folder *work* and enter *conference_planning*
   * Open *schedule_day1*
   * Add more information to your schedule, i.e. talks, workshops, etc.
   
**Don't forget to save your modifications before coming back!**


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

Finally, we will send the changes we made to the remote repository.  


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


```bash

```
