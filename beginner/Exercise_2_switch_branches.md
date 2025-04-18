# Exercise 2

## Objective

   * Learn how to work with branches and switch between them using `git switch`.
   > **Note**: `git checkout` can be used as an alternative to `git switch`. However, it has different features that have caused confusion among users in the past. So we won't use it here, but show the alternative commands in brackets, as some older Git versions don't have this option yet.

## Structure

In this exercise, we will work on scheduling a two-day conference using two files that contain the schedules for day 1 and day 2 (*schedule_day1.txt* and *schedule_day2.txt*). To add events to the schedules (e.g., talks, poster sessions, etc.), we will work on separate branches so as not to mix things up.
Again, this exercise will consist of short descriptions of specific Git commands, followed by a hands-on part where you will be able to execute the corresponding Git commands.

## Helper Functions

The following helper functions in the file *helpers.sh* are written by C2SM and are **NOT** **part of Git**. They will set up simple repositories for you that have a short Git history, so that you have something to work with.

For this exercise, we will use the following functions from this file:
   * `init_exercise`: This will create the *beginners_git* directory in the parent directory of the *git-course* directory. It will also delete any old version of the *beginners_git* directory, so don't use the *beginners_git* directory to save any work.
   * `reset`: This will delete the *beginners_git* directory and allows you a clean restart of the exercise in case you messed it up completely.
   * `init_simple_repo`: This will set up a Git repository containing a first version of *schedule_day1.txt* and *schedule_day2.txt* on the *main* branch.

## Remarks   

> **Note:** Any text enclosed in `<>` denotes a placeholder to be replaced with a specific string appropriate to your context, i.e. delete `<>` and replace it with the appropriate word.

> **Note:** Some exercises may require the use of basic Unix commands. If you are unfamiliar with Unix systems, refer to the file [Basic Unix Commands](Unix_Commands.md) for a list of all necessary commands.

If everything is still set up from the last exercise, you can continue with [this exercise](#exercise) directly.
Otherwise, please refer to the [Initialization from Exercise 1](Exercise_1_basic_commands.md#initialization).

## Exercise

### Learn how to work with branches and switch between them using `git switch`

1. First, we will set up a simple Git repository for you using one of the helper functions.

The following command will set up a simple Git repository called *conference_planning* in the *beginners_git* directory for you and navigate you to it:
```bash
init_simple_repo
```

In the output above we see two files:
   * *schedule_day1.txt*
   * *schedule_day2.txt*

2. Let's have a look at them using the `cat` command:

```bash
cat schedule_day1.txt
```

As you can see, there is still a lot of free time available to add talks, poster sessions, breaks, etc.

To keep things organized, we will do this in two different Git branches, one for scheduling day 1 and one for scheduling day 2.

**Let's get started!**
1. Create a new branch for planning day 1:
```bash
git switch -c <meaningful_branch_name_A>
# (Alternative: "git checkout -b <meaningful_branch_name_A>")
```

2. Open *schedule_day1.txt* (you should find it in *<parent_path_to_git_repo>/beginners_git/conference_planning*) and add more information to the schedule, such as planned talks, poster sessions, lunch, etc.

3. After saving, we run `git status` to see if Git has tracked our changes.

The output should look like:
```
On branch planning_day1
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   schedule_day1.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

4. Add your changes to the staging area and commit them.

For the planning of the other day, we want to use another Git branch.
To keep track of all the different branches, Git provides the `git branch` command to see all branches of a repository.
The * indicates our current branch. Hit the `q` key to exit the branch view.

```bash
git branch
```

We can easily switch between these branches using the `git switch` command.
Don't worry -> Git will keep all your committed work on that branch.

5. Switch back to *main* branch:
```bash
git switch main
# (Alternative: "git checkout main")
```

6. Create a new branch for scheduling day 2 and extend the *schedule_day2.txt* file in that branch, similar to what was done for the *schedule_day1.txt* file.

7. Add and commit the changes of *schedule_day2.txt* in your new branch.

8. View all branches of your Git repository again

The output should look like this:

```
  main
  planning_day1
* planning_day2
```

Our Git repository now contains:
  * Branch *meaningful_branch_name_A* with modifications to *schedule_day1.txt*
  * Branch *meaningful_branch_name_B* with modifications to *schedule_day2.txt*
  * Branch *main* with the original version of *schedule_day1.txt* and *schedule_day2.txt*
  
Using `git switch` it is easy to jump between these branches and modify our schedules further.
To show its capabilities, we will quickly switch between the branches and see how our schedules change.

9. Display the content of *schedule_day1.txt* and *schedule_day2.txt* using `cat`.

10. Repeat displaying the content of the files after switching to the *main* branch and the branch for scheduling day 1.

You should see that the output for the two files is slightly different depending on which branch you are on.
