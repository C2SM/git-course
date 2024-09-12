# Exercise 4 - Using git stash and git worktree

In this exercise, you will learn how to use `git stash` to store changes that are not yet ready for commit. Then you will learn how to recover those changes in your Git repository. Next, you will use `git worktree` to learn how to work with simultaneous checkouts of the same repository in one place, making it easy to work on and transfer files between different git branches.

This exercise uses the same Git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the [Initialize the Git repository](./Exercise_3_gitignore.md#initialize) section of Exercise 3.

* [Stash your changes](#stash)

* [Use git worktree for parallel development](#worktree)

## Stash your changes <a name="stash"></a>

Let's make a change to the repository by adding a conference breakfast to the schedule on day 1. The following command is an example of how to use the `sed` command line tool, which was tested on **Linux** but may not work on other platforms, i.e. **MacOS**. It will add '08:30-09:00: Conference breakfast' after the line containing the word 'Daily' in *schedule_day1.txt*. If this does not work on your platform, simply open the file in a file editor to make the change.

```plaintext
sed -i '/Daily/ a 08:30-09:00: Conference breakfast' schedule_day1.txt
```

Now let's suppose that you decide that you aren't ready to commit this change, but you don't want to discard it either. Use `git stash` to store the change and revert the repository back to the last commit.

```plaintext
git stash save "Add breakfast to day 1"
```

If you check the status of your repository now, you will see that the change you made is no longer listed as unstaged.

```plaintext
git status
```

You can save more than one stash if you like. Examine the list of your stashes (currently only the one you just created).

```plaintext
git stash list
```

Let's assume you have now decided you would like to recover these changes and keep working with them. Let's recover the stash using its identifier from the list (`stash@{0}`).

```plaintext
git stash pop stash@{0}
```

Note that you can make any changes or commits in between saving the stash and reapplying it to your repository. If there are conflicts between the stash and the new commits in your repository, you will need to resolve those conflicts manually before proceeding, and a merge commit will be generated. You should also know that the stash is only stored in your local copy of the repository, and cannot be pushed to a remote repository to be used by other people.

## Use git worktree for parallel development <a name="worktree"></a>
You can use `git worktree` to check out multiple instances of a Git repository at the same time. This is useful for transferring changes between branches, or working on different features at the same time. It is especially helpful when working with code that requires compilation, as switching branches would normally require recompiling. Using `git worktree` keeps the compiled versions in separate folders, saving time.

Here's how to set up `git worktree` in the way we find most useful:

First, create a new folder, *conference_worktree*, where you will store the repository folders for the different branches.
Then clone the *conference_planning* repository inta a folder called *main*, which will be used for the `main` branch.

```plaintext
cd ..
mkdir conference_worktree
cd conference_worktree
git clone ../conference_planning main
cd main
```

You are now on the `main` branch, and can make changes, additions, and commits as usual.

To work on a feature branch alongside the `main` branch, add a new working tree. Make sure you do this from the *main* folder, not a worktree.

```plaintext
git worktree add ../feature
```

If the `feature` branch does not exist, it will be created from the `main` branch. You can now navigate to the *feature* folder and work as usual, while being on the `feature` branch. You can also push and fetch commits to and from remote repositories as you would in a normal Git working directory.