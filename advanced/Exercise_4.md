# Exercise 4 - Using git stash and git worktree

In this exercise, you will learn how to use `git stash` to save changes not yet ready to be committed. Then you will learn how to recover those changes in your git repository. Next you will use `git worktree` to learn how to work with simultaneous checkouts of the same repository in one place, allowing you work on and transfer files between different git branches easily.   

This exercise uses the same git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the `Initialize the git repository` section [here](./Exercise_3.md).

* [Stash your changes](#stash)

* [Use git worktree to create parallel branch checkouts](#worktree)

## Stash your changes <a name="stash"></a>

Let's make a change to the repository by adding a conference breakfast to the schedule on day 1.

```plaintext
sed -i '/Daily/ a 08:30-09:00: Conference breakfast' schedule_day1
```

Now let's suppose that you decide that you aren't ready to commit this change, but you don't want to discard it either. Use `git stash` to save the change and revert the repository back the latest commit.

```plaintext
git stash save "Add breakfast to day 1"
```

If you check the status of your repository now, you can see that the change you made is no longer listed as unstaged.

```plaintext
git status
```

You can save more than one stash if you like. Examine the list of your stashes (currently just the one you just created).

```plaintext
git stash list
```

Let's assume you have now decided you would like to recover these changes and keep working with them. Let's recover the stash using it's identifier from the list (`stash@{0}`).

```plaintext
git stash pop stash@{0}
```

Note that you can make any changes or commits in between saving the stash and reapplying it to your repository. If there are conflicts between the stash and the new commits in your repository, you will need to resolve those conflicts manually before proceeding, and a merge commit will be generated. You should also know that the stash is only saved in your local repository copy and cannot be pushed to a remote repository to be used by other people.

## Use git worktree to create parallel branch checkouts <a name="worktree"></a>

Next you will use `git worktree` to checkout multiple instances of the git repository in parallel. This can be very useful for transferring changes between branches or working on different features simultaneously.

In order to use `git worktree`, you must work in a bare git repository. Remember that a bare git repository is one where there is no working directory. Instead it just consists of the files and objects git uses to register the changes you make to your working directory.

Let's make a bare clone of the conference_planning git repository.

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

Let's make a folder containing the files as they currently are in the main branch of our repository.

```plaintext
git worktree add main
```

A folder called `main` has been created, and if you examine it you will find the checked out files from the main branch. You can make changes and add and commit them as you normally would from this new folder.

Let's suppose that in addition to working in the main branch of the repository, you would also like to work in a feature branch in parallel. You can do this easily now. Let's add a feature branch.

```plaintext
git worktree add feature
```

Because the branch `feature` did not already exist, one has been created from the main branch. It is now located in the `feature` folder, and you can now navigate there and work as you normally would in your git working directory. Note that you can also push and fetch commits as you normally would to and from remote repositories if you need to.
