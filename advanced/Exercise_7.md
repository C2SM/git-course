# Exercise 7 - Using git subtree

This exercise is designed to be paired with Exercise 6 to help you compare and contrast the two main methods for embedding a git repository into another git repository. In this exercise, we will learn to use git subtree to nest a git repository inside another one. We will first add the git subtree and examine how the host and nested repositories deal with changes in their respective files. We will then learn how to pull and push changes to and from the sub-repository.

This exercise uses the same git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the `Initialize the git repository` section [here](./Exercise_3.md).

* [Add the posters repository using git subtree](#subtree)

* [Examine how git deals with changes to both repositories](#examine)

* [Create new content locally and update the sub-repository](#push)

* [Create new content in the sub-repository and update the local repository](#pull)

## Add the posters repository using git subtree <a name="subtree"></a>

Navigate to the folder containing the `conference_planning` folder; in other words you should be in a folder that does not contain a git repository. Make a copy of the conference planning repository to use for adding the subtree.

```plaintext
cp -r conference_planning conference_subtree
```

Let's add your `posters` Github fork we created in Exercise 6 as a subtree to our conference planning repository.

```plaintext
cd conference_subtree
git subtree add --prefix posters YOUR_FORK_ADDRESS main --squash
```

The `--prefix` option gives a folder name relative to the root of the parent repository where the subtree will be installed. And the `--squash` option squashes the history of the posters repository into one commit in the parent repository.

Check the status of the repository.

```plaintext
git status
```

In this case, unlike the submodule, we don't have to make a commit to finalize the addition of the subtree. If you have a look at the log, you will see that git has added a couple of commits automatically to do this.

```plaintext
git log
```

Note that there is no equivalent command to `git submodule status` that will allow us to list our subtrees and their status.  


## Examine how git deals with changes to both repositories <a name="examine"></a>

Let's make some changes in both the host repository and the subtree to understand how git deals with subtrees.  

Start by making a change in the host repository. Let's add a presentation session to the schedule on day 1. The following gives examples using the `sed` command line tool, which were tested on Linux but may not work on other platforms. You can also simply open the file in a file editor to make the change.

```plaintext
sed -i '/^11:00/a 11:30-12:30: Presentation session' schedule_day1
```

Check the status of the repository.

```plaintext
git status
```

You should see the change you just made listed as not staged for commit.

Now navigate into the subtree and check the status there.

```plaintext
cd posters
git status
```

Here we see the same change listed as not staged for commit. This is a difference to the behavior we saw with submodules. With git subtrees, git considers both the host and nested repository to have the same staging area. The commits from the subtree are all put directly into the commit list of the host repository, unlike with git submodule where they are kept completely separate.

Now try making a change inside the submodule. Let's add another poster title to the poster schedule.

```plaintext
echo "Poster 3: 3 easy steps to git mastery" >> schedule
```

Check the status of the repository.

```plaintext
git status
```

Now we see both changes listed as not staged for commit. This means that we could potentially now make a commit that included content from the host repository AND the subtree, and git would allow it. This could create problems with the history of the repository further down the line, so this should be avoided. The user simply needs to know not to do this, as git will not do anything to stop this.

## Create new content locally and update the sub-repository <a name="push"></a>

Let's push the change we've made to the subtree to the Github fork.
First we need to commit this change.

```plaintext
git add schedule
git commit -m "Add Poster 3"
```

Now, we need to go to the root of the host repository and use `git subtree push` to send this commit to our Github fork.

```plaintext
cd ..
git subtree push --prefix=posters YOUR_FORK_ADDRESS main
```

If you check your Github fork now, you should see that the change has appeared there.  

## Create new content in the sub-repository and update the local repository <a name="pull"></a>

Finally, let's learn how to pull changes from the subtree into our host repository.  

Navigate back to your fork of the poster repository on Github, and make a change to the schedule file and commit it. You can do this directly on the web interface by simply selecting the file and using the edit button.

Let's update the main repository with the new content of the poster repository.
You can't do this if there are any changes in your working tree, so you should discard the changes we made to the day 1 schedule first.

```plaintext
git checkout schedule_day1
```

Use `git subtree pull` to get the newest commit from your Github fork.

```plaintext
git subtree pull --prefix posters YOUR_FORK_ADDRESS main --squash
```

Git will prompt you to enter a merge commit message, because it is treating this new information addition as a merge.

Look at the contents of the posters subtree to see that the change you made has been added.

```plaintext
cat posters/schedule
```

Have a look at the log to see exactly how git has handled the subtree and it's updates.

```plaintext
git log
```
