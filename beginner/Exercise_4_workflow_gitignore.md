# Exercise 4

## Objective
   * Practice the typical Git workflow
   * Understand the function of a *.gitignore* file, and learn the steps involved in creating and configuring it within a Git repository.
   
## Structure

In this exercise, we won't be learning any new Git commands. Rather, we will review all the commands and workflows we learned in the previous exercises. We will do this by working on the *conference_schedule.txt* document and simulating a possible workflow. Since this is a review, there will be less explanation for that part of this exercise.

In addition to that, we will explore a crucial aspect of Git: the *.gitignore* file. We'll learn how to create and configure this file to manage the files that Git should ignore, enhancing our typical workflow.

## Helper Functions
The following helper functions in the file *helpers.sh* are written by C2SM and are **NOT** **part of Git**. They will set up simple repositories for you that have a short Git history, so that you have something to work with.

For this exercise, we will use the following functions from this file:
   * `init_exercise`: This will create the *beginners_git* directory in the parent directory of the *git-course* directory. It will also delete any old version of the *beginners_git* directory, so don't use the *beginners_git* directory to save any work.
   * `reset`: This will delete the *beginners_git* directory and allows you a clean restart of the exercise in case you messed it up completely.
   * `init_repo_empty_schedule`: This will create the directory *conference_planning* and a file *conference_schedule.txt* with an empty schedule.

## Remarks   

> **Note:** Any text enclosed in `<>` denotes a placeholder to be replaced with a specific string appropriate to your context, i.e. delete `<>` and replace it with the appropriate word.

> **Note:** Some exercises may require the use of basic Unix commands. If you are unfamiliar with Unix systems, refer to the file [Basic Unix Commands](Unix_Commands.md) for a list of all necessary commands.

If everything is still set up from the last exercise, you can continue with [this exercise](#exercise) directly.
Otherwise, please refer to the [Initialization from Exercise 1](Exercise_1_basic_commands.md#initialization).

## Exercise

### Understanding *.gitignore*

The *.gitignore* file is an essential and commonly used feature in Git. It specifies intentionally untracked files that Git should ignore. It's particularly useful for excluding files generated during execution or build processes—like log files, compiled code, or local configuration files—that don't need to be shared within the repository. Creating a *.gitignore* file and listing the file patterns to exclude achieves this.

**Typical Ingredients of *.gitignore*:**

Once your *.gitignore* is created, you can specify:

- **Patterns**: Direct patterns such as *my_file_to_ignore.txt* to exclude specific files or *my_directory_to_ignore/* to exclude specific directories. 
- **Wildcards**: Broad patterns like `*.log` to exclude all log files created across the project.
- **Exceptions**: If you've used a wildcard but want to track specific files, precede the exception with `!`. For instance, *!important_log.log* ensures this file is tracked despite the `*.log` exclusion.

Remember, the *.gitignore* file should be committed into your repository, so it is shared with other developers, ensuring that everyone working on the project is ignoring the same files.

**Practical Application:**

1. Navigate to the root of your *git-course* repository.

2. Execute `ls -a` to also see the hidden Git folder. You should see the *.gitignore* file. Have a look into it.

3. Run the *check_requirements.sh* file (as you should have done as preparation for the course):

```bash
./check_requirements.sh
```

4. Check the status of your Git repository. You should now see the log file from running the requirement check.

Log files are typically generated for debugging and monitoring purposes but are not meant to be part of the Git repository. Since they change frequently and can grow large, they are usually added to the *.gitignore* file to keep the repository clean and prevent unnecessary clutter.

5. Add a wildcard to the *.gitignore* file to exclude all log files.

6. Check the status of *git-course* repository. Does the log file still show up?

Use *.gitignore* whenever files clutter your Git repository, but shouldn't be committed.

### Practice typical Git workflow

1. First, we will set up a simple Git repository for you using one of the helper functions. It will create the directory *conference_planning* and the empty schedule *conference_schedule.txt* in and navigate you to the folder.

```bash
init_repo_empty_schedule
```

2. Initialise the folder as a Git repository.
3. Add and commit the *conference_schedule.txt* file.
4. Add a talk, coffee break, workshop to your schedule.
5. Add and commit your changes.
6. The workshop has been canceled and we will have a poster session instead. Adjust your document accordingly.
7. Add and commit the changes.
We continue to plan.
8. Add a lunch break, another talk and a second poster session to the schedule and commit your changes.
9. Check if all of your changes are really tracked by Git by checking the status and the history.

If you don't have any untracked changes in your repository, proceed to the next part of this exercise.


### It is late at night and your concentration is not very high...

1. By accident you delete all of your existing files...


```bash
# CAUTION: executing this panel deletes all files in the current directory
rm *
```

Thanks to Git we can easily restore files, even if they are deleted.

2. Check the Git status.
3. Restore the deleted files

### As a next step we will make changes on a different branch

1. Create a new branch.
2. We are not sure yet if Professor X will accept the talk in the morning, therefore change the talk to a workhop on this branch as an alternative schedule.
3. Add and commit your changes.
4. Now switch back to branch *main*.

We want to plan an evening activity, but we are not sure what it will be. Therefore, we create two branches with different activities.

5. Create a new branch and add an evening activity.
6. Add and commit the change.

7. Switch to branch *main* and create another branch on top of it to add an alternative evening activity.

It's time to get an overview of what we just did.

Our repository should currently have four branches (names may be different for your case):
   * *main* (base version of all subsequent branches)
   * *alternative_talk* (workshop instead of talk)
   * *evening_activity* (first planned activity)
   * *evening_activity_alternative* (alternative activity)
   
8. Ensure your repository contains the same amount of different branches by displaying the available branches.

The talk in the morning has finally been cancelled.

9. Merge the branch containing the workshop instead of the talk into the *main* branch.

**Remark:** Make sure you are in the *main* branch before starting the merge, because Git always merges a branch **into** your current branch.

10. Follow good practice and delete the merged branch.

The last step of the planning is to choose one of the two evening activities.
Decide which one you prefer.

11. Merge your preferred evening activity into the *main* branch.

12. Delete the merge branch.

There is one unused branch left in our repository.

13. We want to keep the repository clean and nice. So please delete the unmerged branch as well.

**Remark:** Since we did not merge the remaining branch, it has to be done differently before. But don't worry, Git will tell you what to do.

**Congrats, you already know the most essential Git commands for the local use of Git.**