# Exercise 6

## Objective
   * Learn how to deal with merge conflicts:
       * Undo merge
       * Choose preferred version
       * Modify file directly
    
## Structure

In this exercise, we will change the same file on different branches in a way that causes a merge conflict. We will also have to deal with a merge request when trying to pull from a remote repository because "someone else" made a conflicting change remotely.

## Helper Functions
The following helper functions in the file *helpers.sh* are written by C2SM and are **NOT** **part of Git**. They will set up simple repositories for you that have a short Git history, so that you have something to work with.

For this exercise, we will use the following functions from this file:
   * `init_exercise`: This will create the *beginners_git* directory in the parent directory of the *git-course* directory. It will also delete any old version of the *beginners_git* directory, so don't use the *beginners_git* directory to save any work.
   * `reset`: This will delete the *beginners_git* directory and allows you a clean restart of the exercise in case you messed it up completely.
   * `init_repo_remote`: This will set up a Git repository with a first version of *schedule_day1.txt* and a remote repository containing the same version of *schedule_day1.txt* on a different branch called *updated_schedules*.
   * `commit_to_remote_by_third_party`: This will make a commit to the remote Git repository to create an artificial merge conflict when pulling.

## Remarks
_**Reminder:** Any text enclosed in `<>` denotes a placeholder to be replaced with a specific string appropriate to your context, i.e. delete `<>` and replace it with the appropriate word._

### Initialization

**Note:** You don't need to do the following, if everything is still set up from the last exercise, but you can jump to the exercise directly.

If the `pwd` command returns something like `/home/juckerj/git-course/beginner`, everything is fine:
```bash
pwd
```
If it returns something like `/home/juckerj`, change to the correct directory:
```bash
cd <path to git-course directory>/beginner
```

**To initialize the exercise properly, run this code at the very beginning. Check the Helper Functions section above for more explanation.**


```bash
# source the helpers.sh file to be able to use its functions
source helpers.sh
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

Let's make a change in the schedule and commit it.

1. Change the workshop to a poster session in *schedule_day1.txt*.

2. Add and commit the file.

### Add a remote repository

Let's add the remote repository to our local repository as we did in the previous exercise.

The setup script has already created one for you at: 

**../conference_planning_remote**

Use the above line as the *remote_path* to the remote repository.

1. Add the remote to your repository (`git remote add <some_remote_name> <remote_path>`)

2. Get information from remote branch with `git fetch <my_remote>`.

3. Check which branches are available on the remote (`git branch -a`).

### Now make a different change in the same file on the _updated_schedules_ branch

1. Switch to the *updated_schedules* branch.
2. Change the workshop to a talk in *schedule_day1.txt*.
3. Add and commit your changes.


### Merge the *updated_schedules* branch into the *main* branch
We have decided to use the schedule on the *updated_schedules* branch. So we want to merge that branch into the *main* branch.

1. Switch to *main* branch.
2. Merge the *updated_schedules* branch into the *main* branch.

### Solve merge conflict
If you've done everything "right", something went "wrong" and the output should look like this:

```
CONFLICT (content): Merge conflict in schedule_day1.txt
Automatic merge failed; fix conflicts and then commit the result.
```

It looks like we ran into a merge conflict. This happened because we made changes on the *main* branch and the *updated_schedules* branch at the same part of the file. Git doesn't know which changes it should accept. Let's see how to fix this. 

Have a look at the file *schedule_day1.txt*. You will see something like this:

``` 
<<<<<<< HEAD
13:30-15:00: Poster session
=======
13:30-15:00: Talk professor C.
>>>>>>> updated_schedules 
```

The top line is the HEAD, referring to the branch you are currently on (here *main*), and the second line refers to the branch you wanted to merge (here *updated_schedules*).

Here are two ways to resolve a merge conflict:

1. **Adjust the file directly:**

    * Edit the file to resolve the conflict: You can adjust the file directly and delete the lines, which were added by the merge conflict except the lines you want to keep. Now the merge conflict is resolved.

    * Add your changes: Use `git add` to stage the resolved changes within _schedule_day1.txt_.

    * Commit your changes:  Commiting your changes will finalize the merge process that was interrupted by the conflict.

2. **Simplifying Conflict Resolution with `git restore`**

   Sometimes, you'll find that the entire version of the file from one branch is preferred over the other. In such cases, you can bypass manual edits by leveraging `git restore` to quickly choose between the version on your current branch (HEAD, referred to as _ours_) and the version from the branch you're merging from (_theirs_).

   * To adopt the version from your current branch (HEAD), use the command:  
     ```git restore schedule_day1.txt --ours```
     
   * Conversely, to accept the version from the merging branch, switch to:  
     ```git restore schedule_day1.txt --theirs```
    
    These commands replace the conflicted file in your working directory with the selected version. It's important to understand that `git restore` directly overwrites the file content, so use it when you're certain of wanting to keep only one branch's changes.

   After restoring the file:

     * Add your changes: Use `git add` to stage the resolved file within _schedule_day1.txt_.

     * Commit your changes:  Commiting your changes will finalize the merge process that was interrupted by the conflict.


**Important note when dealing with merge conflicts**: After resolving the conflict, **no new merge command is required**. The original merge operation was paused, not stopped, when the conflict was detected. By resolving the conflict and committing the changes, you are completing the paused merge process.

**Abort merge**:

If you're afraid that everything is screwed up and you don't know what to do, just run ```git merge --abort``` and everything will be back to where it was before you tried to merge.

Let's deal with the merge conflict!

### Abort merge

1. Abort the merge.

### Adjust the file directly to resolve conflict
1. Create the same merge conflict again by trying to merge the *updated_schedules* branch into the *main* branch.

2. Now go to the file and select the version you want. To do this, remove all of the conflict markers from the file (*<<<<<<< HEAD, =======*, *>>>>>>> updated_schedules*) and the lines belonging to *HEAD* or the merging branch (*updated_schedules*) depending on which solution you want to keep.

3. Stage the file with `git add` to tell Git that the conflicts have been resolved. Note that Git does not check the file for conflict tags; it trusts you that you to have removed them all, so you need to be sure.

4. Finalize the merge by running `git commit`.

### Restore preferred version from command line
First, we need to create a new conflict. To do this, go to the *main* and *updated_schedules* branches, respectively, and make different changes on the SAME line. Don't forget to commit the changes before switching between the branches.

1. Switch to the *updated_schedules* branch and make a change to the file.
2. Add and commit the change and switch back to the *main* branch.
3. Make a change to the SAME line of the file as you did on the *updated_schedules* branch.
4. Add and commit your changes.
5. Try to merge the *updated_schedules* branch into the *main* branch.
6. Solve the merge conflict with `git restore schedule_day1.txt --theirs/ours` (choose your preferred version).
7. Add your solution to the merge.
8. Finalize merge by committing.

### Merge conflict when trying to pull remote branch
We will now learn how to deal with another type of merge conflict that can easily occur when working with remote branches that other people are working on at the same time.

To clean things up, let's first switch to the *updated_schedules* branch and push our latest commits to the remote branch.

1. Switch to the *updated_schedules* branch.
As you can see from the Git message, we are ahead of the remote branch. So before we continue, we want to push our local changes.
2. Push changes to the remote branch with `git push`.
3. Now change the first event to "Introduction talk" in *schedule_day1.txt* and commit the change.

What we didn't realize is that someone changed something on the remote branch while we were working on the file. If we now try to pull the remote branch, we will run into a merge conflict.

4. To mimic a person making changes to the same file at the same time, we use another helper function. Run the following to do so:
```bash
commit_to_remote_by_third_party
```

5. Now make sure you are on the *updated_schedules* branch and try to pull with `git pull`.

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

6. Choose and set your preferred way of pulling.

7. Try to pull again and solve the merge conflict in your preferred way.