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

> [!NOTE]
> Any text enclosed in `<>` denotes a placeholder to be replaced with a specific string appropriate to your context, i.e. delete `<>` and replace it with the appropriate word/sentence.

> [!TIP]
> Some exercises may require the use of basic Unix commands. If you are unfamiliar with Unix systems, refer to the file [Basic Unix Commands](../Unix_Commands.md) for a list of all necessary commands.

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

Just run `git restore -s <specific_commit_hash> <your_file(s)>`.

> [!NOTE]
> For simplicity, we've used the `-s` option in the `git restore` command. Note that `-s` is a shorthand for `--source`, which you can also use interchangeably. The primary difference lies in the syntax: use `-s <commit_hash>` for a shorter command, or `--source=<commit_hash>` if you prefer a more explicit approach. Both options perform the same function: specifying the source from which to restore. Whether you prefer `-s` for brevity or `--source` for clarity is up to you.

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
b7bd111 (HEAD -> main) Remove workshop on day 1
f6c3f04 Change talks back to poster sessions
5889296 Change poster sessions to talks
464fc92 Add workshops
e53b1e0 Add coffee break
f1b23c1 Add poster sessions in the morning
f636890 Add schedule_day2
206f724 Add schedule_day1
```


### Merge two branches (without merge conflicts)
In this part of the exercise, we will continue working on *schedule_day1.txt*.
There are two sections in *schedule_day1.txt*, which we will change on separate branches:
   * *daily_program*
   * *evening_activity*

#### Fast-forward merge
1. Create and switch to a new branch for the evening activity.

2. Open *schedule_day1.txt* and add evening activities only in the evening_activity section (e.g., add a dinner or social event).

3. Add and commit the changes.

4. Switch back to the *main* branch.

5. Create another branch to add more to the daily program.

6. Open *schedule_day1.txt* and add at least one more event only in the daily_program section (e.g., add a new talk or session).

7. Add and commit your changes.

8. Switch back to the *main* branch. Check your branches - it should look like that:

```bash
  daily_program
  evening_activity
* main
```

#### Fast-forward merge

9. Merge the *evening_activity* branch into *main*. To merge all modifications from a branch into the current branch, we type `git merge <branch-to-be-merged>`.

10. Check the history of your *main* branch. It should now include the commit from the *evening_activity* branch.

11. It is good practice to delete branches that have been merged: `git branch -d <branch-to-be-deleted>`.

#### 3-way merge

In our branch for the evening activitiy, we only changed the "Evening activity" section in our file. In the branch for daily program, we only changed the "Daily program" section, respectively. This will enusre a merge without a merge conflict in the end.

Since we merged *evening_activity* into *main*, the *main* branch has now a diverging history compared to the *daily_program* branch.
Thus, when merging *daily_program* into *main*, Git must create a merge commit (3-way merge).


12. Merge the *daily_program* branch into *main*. This time, we have to set a commit message: `git merge <branch_name> -m "Merge daily_program"`

13. Check the history and the contents of the schedules. The *main* branch should now contain both changes (daily program and evening activity).

Your Git log should look like the following:
```
c0d0459 (HEAD -> main) Merge daily_program
b1be3b4 (daily_program) Add talks
4d93eac Add evening activities
b7bd111 Remove workshop on day 1
f6c3f04 Change talks back to poster sessions
5889296 Change poster sessions to talks
464fc92 Add workshops
e53b1e0 Add coffee break
f1b23c1 Add poster sessions in the morning
f636890 Add schedule_day2
206f724 Add schedule_day1
```

14. Delete the branch you just merged.

**Congrats, your Git skills are getting better and better!**
