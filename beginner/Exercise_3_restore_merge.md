# Exercise 3

## Objective
   * Restore the version of files at some point in the Git history
   * Merge two branches (without merge conflicts)
   * Delete unused branches
   
## Structure
In this exercise, we will continue working on the schedule for the two-day conference using *schedule_day1.txt* and *schedule_day2.txt* for each day's schedule. First, we need to revert the schedules back to a specific commit. Then we modify the same file, but on different branches. Finally, we merge all our changes back to the *main* branch.

Again, this exercise will consist of short descriptions of specific Git commands, followed by a hands-on part where you will be able to execute the corresponding Git commands.

## Helper Functions
The following helper functions in the file *helpers.sh* are written by C2SM and are **NOT** **part of Git**. They will set up simple repositories for you that have a short Git history, so that you have something to work with.

For this exercise, we will use the following functions from this file:
   * `init_exercise`: This will create the *beginners_git* directory in the parent directory of the *git-course* directory. It will also delete any old version of the *beginners_git* directory, so don't use the *beginners_git* directory to save any work.
   * `reset`: This will delete the *beginners_git* directory and allows you a clean restart of the exercise in case you messed it up completely.
   * `init_repo`: This sets up a Git repository as in Exercise 2, but with more commits.

## Remarks   

> **Note:** Any text enclosed in `<>` denotes a placeholder to be replaced with a specific string appropriate to your context, i.e. delete `<>` and replace it with the appropriate word.

> **Note:** Some exercises may require the use of basic Unix commands. If you are unfamiliar with Unix systems, refer to the file [Basic Unix Commands](Unix_Commands.md) for a list of all necessary commands.

If everything is still set up from the last exercise, you can continue with [this exercise](#exercise) directly.
Otherwise, please refer to the [Initialization from Exercise 1](Exercise_1_basic_commands.md#initialization).

## Exercise

### Restore versions of files at any point in the Git history

First, we will set up a simple Git repository for you using one of the helper functions:

```bash
init_repo
```

1. Review the schedules for the two days in the files *schedule_day1.txt* and *schedule_day2.txt*.

The schedules for both days start with talks.

Originally we planned poster sessions in the morning, but the invited professors only had time in the morning to give their talks, so we changed the poster sessions to talks.

2. Check the Git history for the commit that changed the poster sessions to talks.

The professors have now canceled their talks and we want to have the poster sessions in the morning again.

To avoid doing the same work twice, we want to reuse the old schedules that we designed in the first place.

We can use `git restore` to get any version of a file along its Git history.

Just run `git restore -s <specific_commit_hash> <your_schedule>`.

**Note**: 
For simplicity, we've used the `-s` option in the `git restore` command. Note that `-s` is a shorthand for `--source`, which you can also use interchangeably. The primary difference lies in the syntax: use `-s <commit_hash>` for a shorter command, or `--source=<commit_hash>` if you prefer a more explicit approach. Both options perform the same function: specifying the source from which to restore. Whether you prefer `-s` for brevity or `--source` for clarity is up to you.

2. Undo "Change poster sessions to talks" by restoring the *schedule_day1.txt* to the commit before the change.

3. Review *schedule_day1.txt* to see if the talk has been changed back to a poster session.

4. Do exactly the same for *schedule_day2.txt*.

5. Check if Git tracked the changes.

6. Add and commit your updated schedules

7. Now check the Git history

Each *commit hash* is unique, so you can always go to any version of the tracked files, *even* across different branches.

8. You decide to not have the workshop on day 1 anymore. So restore *schedule_day1.txt* before the "Add workshops" commit.

9. Add and commit *schedule_day1.txt*.

10. Check the Git history with `git log --oneline` for a short summary.

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

1. Switch to a new branch for the evening activity.

2. Open the schedules add evening activities.

3. Add and commit the changes.

4. Go back to the *main* branch using `git switch` (if you don't go back to the *main* branch but create a new branch, it will be based on the current branch and not the *main* branch).

5. Now create another branch to add more to the daily program. Add at least one more event to the daily program.

6. Add and commit your changes

7. Now switch back to branch *main* and run `git branch`

The output should look like:
```
  evening_activity
* main
  daily_program
```

Let's put the pieces of the schedules together. For that we use the `git merge` functionality.  
It allows us to merge files with different text from different branches.


To merge all modifications from a branch into the current branch, we type `git merge <branch-to-be-merged>`

8. Merge evening activity into the *main* branch (make sure you are on the main branch for that).

Git just performed a so-called **fast-forward merge**. This means that there is a linear path
between the two merged branches. See the slides for more detailed information about it. 

**Most important:**  
Git does **NOT** create an additional commit to perform the merge. It only appends the commit from the branch *evening_activity* to the HEAD.

9. Check Git history to see the added commit.

Check the contents of the schedules.

As you can see, we successfully merged our changes from the *evening_activity* branch into the *main* branch. After merging a branch, it is always good practice to delete it.

10. Delete the branch for the evening activities with `git branch -d <evening activities branch>`.

Let's do the same, but for the changes in the branch for the daily program.

11. Merge the branch for the daily program into the *main* branch.

For this merge, Git performs what is called a **3-way merge**, because the path between the two branches is no longer linear due to the merge of the branch for planning the evening activities. So Git creates a **merge commit** to merge the two histories together.

12. Take a look at the schedules and see what they look like. Then check out the new history of your current branch.

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

13. Again, make sure to delete the branch you just merged.

**Congrats, your Git skills are getting better and better!**
