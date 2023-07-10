# Exercise 4 - Using git stash and git worktree

In this exercise, you will learn how to use `git stash` to store changes that are not yet ready for commit. Then you will learn how to recover those changes in your Git repository. Next, you will use `git worktree` to learn how to work with simultaneous checkouts of the same repository in one place, allowing you work on and transfer files between different Git branches easily.

This exercise uses the same Git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the *Initialize the Git repository* section in [Exercise 3](./Exercise_3.md).

* [Stash your changes](#stash)

* [Use git worktree to create parallel branch checkouts](#worktree)

## Stash your changes <a name="stash"></a>

Let's make a change to the repository by adding a conference breakfast to the schedule on day 1. The following command is an example of how to use the `sed` command line tool, which was tested on Linux but may not work on other platforms. It will add '08:30-09:00: Conference breakfast' after the line containing the word 'Daily' in *schedule_day1.txt*. If this does not work on your platform, simply open the file in a file editor to make the change.

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

## Use git worktree to create parallel branch checkouts <a name="worktree"></a>

Now you will use `git worktree` to checkout multiple instances of the Git repository in parallel. This can be very useful for transferring changes between branches, or working on different features simultaneously.

In order to use `git worktree`, you must work in a bare Git repository. A bare Git repository is one where there is no working directory. Instead, it consists only of the files and objects that Git uses to register the changes you make to your working directories.

Let's make a bare clone of the *conference_planning* Git repository. Therefore, navigate out of the *conference_planning* repository to its parent directory:

```plaintext
cd ..
git clone --bare conference_planning conference_bare
```

Navigate into the new repository and examine it.

```plaintext
cd conference_bare
ls
git status
```

Note that the `git status` command does not work because we are not in a working directory!

Let's make a folder containing the files as they currently are in the *main* branch of our repository.

```plaintext
git worktree add main
```

A folder called *main* has been created, and if you examine it you will find the files checked out from the *main* branch. You can make changes and add and commit them as you normally would from this new folder.

Let's suppose that in addition to working on the *main* branch of the repository, you also want to work on a parallel *feature* branch. You can do this easily now. Let's add a *feature* branch.

```plaintext
git worktree add feature
```

Since the *feature* branch did not already exist, one has been created from the *main* branch. It is now located in the *feature* folder, and you can now navigate there and work as you normally would in your Git working directory. Note that you can also push and fetch commits to and from remote repositories as you would in a normal Git working directory.
