# Exercise 2

## Objective
- Learn how to work with branches and switch between them using `git switch`.
- Note: `git checkout` can be used as an alternative to `git switch`. However, it has different features that have caused confusion among users in the past. So we won't use it here, but show the alternative commands in brackets, as some older Git versions don't have this option yet.

## Structure
In this exercise, we will work on scheduling a two-day conference using two files that contain the schedules for day 1 and day 2 (*schedule_day1.txt* and *schedule_day2.txt*). To add events to the schedules (e.g., talks, poster sessions, etc.), we will work on separate branches so as not to mix things up.

Again, this exercise will consist of short descriptions of specific Git commands, followed by a hands-on part where you will be able to execute the corresponding Git commands.

## Helper Functions
The following helper functions in the file *helpers.sh* are written by C2SM and are **NOT** **part of Git**. They will set up simple repositories for you that have a short Git history, so that you have something to work with.

For this exercise, we will use the following functions from this file:
- `init_exercise`: This will create the *beginners_git* directory in the parent directory of the *git-course* directory. It will also delete any old version of the *beginners_git* directory, so don't use the *beginners_git* directory to save any work.
- `reset`: This will delete the *beginners_git* directory and allows you a clean restart of the exercise in case you messed it up completely.
- `init_simple_repo`: This will set up a Git repository containing a first version of *schedule_day1.txt* and *schedule_day2.txt* on the *main* branch.

## Remarks
_**Reminder:** Any text enclosed in `<>` denotes a placeholder to be replaced with a specific string appropriate to your context, i.e. delete `<>` and replace it with the appropriate word._

_**Note:** Always run `git commit` and `git merge` with a Git message `-m <meaningful_message>`. Otherwise, Git may try to open the Git editor, which does not work on Jupyter Notebook and will break your current session._

---

## Optional: Clear notebook and restart
**In case you messed up your notebook completely, execute** `reset` **. Check the Helper Functions section above for more explanation.**

```bash
reset
```

# Exercise

## Learn how to work with branches and switch between them using `git switch`

First, we will set up a simple Git repository for you using one of the helper functions:

In the output above, we see two files:
- *schedule_day1.txt*
- *schedule_day2.txt*

Let's have a look at them using the `cat` command:

```bash
cat schedule_day1.txt
```

As you can see, there is still a lot of free time available to add talks, poster sessions, breaks, etc.

To keep things organized, we will do this in two different Git branches, one for scheduling day 1 and one for scheduling day 2.

### Let's get started!

1. Create a new branch for planning day 1.
2. Use `git switch -c <branch_name>` to create a new branch (alternative: `git checkout -b <branch_name>`

From now on, we will make all modifications to the schedules directly in Jupyter Notebooks.
- On the start page, go to the folder *beginners_git* (outside of *git-course*).
- Navigate to the folder *conference_planning*.
- Open *schedule_day1.txt*.
- Add more information to the schedule, such as planned talks, poster sessions, lunch, etc.

**Remember to save your changes before you come back!**

After saving, we run `git status` to see if Git has tracked our changes.

The output should look like:

```
  On branch planning_day1
  Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
          modified: schedule_day1.txt

  no changes added to commit (use "git add" and/or "git commit -a")
```

Now do a commit with those changes.

For the planning of the other day, we want to use another Git branch.  
To keep track of all the different branches, Git provides the `git branch` command to see all branches of a repository.  
The `*` indicates our current branch.

We can easily switch between these branches using the `git switch` command.  
Don't worry -> Git will keep all your work done on that branch.

Create a new branch for scheduling day 2 and extend the *schedule_day2.txt* file in that branch, similar to what was done for the *schedule_day1.txt* file.

Now open *schedule_day2.txt*, make changes, and save them. Proceed to commit your changes.

The output should look like this:
```
    main
    planning_day1
    * planning_day2
```

Our Git repository now contains:
- Branch *planning_day1* with modifications to *schedule_day1.txt*
- Branch *planning_day2* with modifications to *schedule_day2.txt*
- Branch *main* with the original version of *schedule_day1.txt* and *schedule_day2.txt*

Using `git switch`, it is easy to jump between these branches and modify our schedules further.  
To show its capabilities, we will quickly switch between the branches and see how our schedules change.

You should see that the output for the two files is slightly different depending on which branch you are on.


