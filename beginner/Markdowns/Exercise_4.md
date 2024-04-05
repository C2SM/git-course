## Exercise 4

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
_**Reminder:** Any text enclosed in `<>` denotes a placeholder to be replaced with a specific string appropriate to your context, i.e. delete `<>` and replace it with the appropriate word._

_**Reminder:** Always run `git commit` and `git merge` with a git message `-m <meaningful_message>`. Otherwise Git may try to open the Git editor, which does not work on jupyter notebook and will break your current session._

### Initialization


```bash
# check current directory with "pwd"

# in case you are in the wrong directory, navigate to Exercise_4 using "cd"

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

### Practice typical Git workflow

First, we will set up a simple Git repository for you using one of the helper functions:


```bash
# this line will create the directory `conference_planning` and the empty schedule `conference_schedule.txt` in it
init_repo_empty_schedule
```


```bash
# init Git repository

```


```bash
# execute "ls -a" to also see the hidden git folder

```

### Understanding *.gitignore*

The *.gitignore* file is an essential and commonly used feature in Git. It specifies intentionally untracked files that Git should ignore. It's particularly useful for excluding files generated during execution or build processes—like log files, compiled code, or local configuration files—that don't need to be shared within the repository. Creating a *.gitignore* file and listing the file patterns to exclude achieves this.

**Typical Ingredients of *.gitignore*:**

Once your *.gitignore* is created, you can specify:

- **Patterns**: Direct patterns such as *my_file_to_ignore.txt* to exclude specific files or *my_directory_to_ignore/* to exclude specific directories. For example, *.ipynb_checkpoints/* is often added to the *.gitignore* when working with Jupyter Notebooks to ignore checkpoint folders created during development.
- **Wildcards**: Broad patterns like `*.log` to exclude all log files created across the project.
- **Exceptions**: If you've used a wildcard but want to track specific files, precede the exception with `!`. For instance, *!important_log.log* ensures this file is tracked despite the `*.log` exclusion.

Remember, the *.gitignore* file should be committed into your repository, so it is shared with other developers, ensuring that everyone working on the project is ignoring the same files.

**Practical Application:**

Now that you have seen and understood the concept of the *.gitignore* file, you can proceed with your exercises. At a certain point, after you run `git status`, you might notice a file named *.ipynb_checkpoints*. This is created by Jupyter Notebooks to save checkpoint files and it's exactly the type of content we aim to exclude from our Git repository, as it is specific to your local Jupyter Notebook environment. It thus presents a perfect opportunity to apply what you've just learned. Follow these steps to create a *.gitignore* and specify the patterns. Remember to add and commit your *.gitignore* after creating it. 




```bash
# Create `.gitignore` and add the `.ipynb_checkpoints pattern` (Note: make sure you are in the conference_planning directory when running the following command)
echo ".ipynb_checkpoints/" >> .gitignore

```


```bash
# Add and commit your .gitignore


```

### Go on with your Exercise

Add events to the schedule.

Remember to make any changes to the schedule directly in Jupyter Notebooks:
   * Go to folder *beginners_git/conference_planning*
   * Open *conference_schedule.txt*
   * Change file

**Don't forget to save your modifications before coming back!**

Please use this way of editing files throughout the exercise.

- Add a talk, coffee break, workshop


```bash
# commit your changes


```

The workshop has been canceled and we will have a poster session instead.

Adjust your document accordingly.


```bash
# commit the adapted "conference_schedule.txt"


```

We continue to plan. Add these three events to *conference_schedule.txt*:
   * Lunch break
   * Another talk
   * Second poster session


```bash
# commit your changes


```

Check if all of your changes are really tracked by Git.



```bash
# check Git status

# check Git log

```

If you don't have any untracked changes in your repository, proceed to the next part of this exercise.



**It is late at night and your concentration is not very high...**

By accident you delete all of your existing files...


```bash
# CAUTION: executing this panel deletes all files in the current directory
rm *
```

Thanks to Git we can easily restore files, even if they are deleted.


```bash
# check Git status

```


```bash
# restore deleted files

```

As a next step, create a new branch and edit the schedule there, since we are not sure yet if Professor X will accept the talk in the morning. 

**Always make sure to reload your file before changing it**
   * Change the talk to a workshop


```bash
# create new branch and adjust the schedule

```


```bash
# commit changes


```

Switch back to branch *main* and create another branch on top of it.
We want to plan an evening activity but are not sure what it will be. Therefore, we create two branches with different activities.


```bash
# switch to main

# create new branch and add an evening activity

```

Add an evening activity and commit the changes. Don't forget to reload your file before changing!


```bash
# commit changes


```

Switch to branch *main* and create another branch on top of it, to add an alternative evening activity.


```bash
# switch to main branch

# create new branch and add another evening activity

```


```bash
# commit changes


```

It's time to get an overview of what we just did.
Our repository has currently 4 branches (names may be different for your case):
   * *main* (base version of all subsequent branches)
   * *alternative_talk* (workshop instead of talk)
   * *evening_activity* (First planned activity)
   * *evening_activity_alternative* (Alternative activity)
   
Ensure your repository contains the same amount of different branches.


```bash
# display all branches of the Git repository

```

The talk in the morning has not been accepted.
Therefore merge the branch *alternative_talk* into *main*.

**Remark:** Make sure you are in the *main* branch before starting the merge, because Git always merges a branch **into** your current branch.



```bash
# merge schedule branch into the main branch


```


```bash
# follow good practice and delete the merged branch

```

The last step of the planning is to choose one of the two evening activities.
Decide which one you prefer.

Merge the corresponding branch into *main*.

**Don't forget to add a commit message!**


```bash
# merge your preferred evening activity into main

```


```bash
# delete merged branch

```

There is one unused branch left in our repository.
We want to keep the repository clean and nice. So please delete the unmerged branch as well.

**Remark:** Since we did not merge the remaining branch, it has to be done differently before. But don't worry, Git will tell you what to do.


```bash
# delete unused branch

```

**Congrats, you already know the most essential Git commands for the local use of Git.**
