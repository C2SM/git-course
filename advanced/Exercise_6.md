# Exercise 6 - Using git subtree

In this exercise, we will learn to use git subtree to nest a git repository inside another one. We will first add the nested git repository and learn to update it when there are changes in the external subtree repository. We will also examine how the host and nested repositories deal with changes in their respective files.
  
* [Create a new repository and add it as a subtree](#subtree)

* [Create new content in the subtree and update the host](#update)

* [Examine how git deals with changes to both repositories](#examine)

## Create a new repository and add it as a subtree <a name="subtree"></a>

Navigate to the folder containing the `conference_planning` folder; in other words you should be in a folder that does not contain a git repository. Make a copy of the conference planning repository to use for adding the subtree.

```plaintext
cp -r conference_planning conference_subtree
```

Let's add the `posters` repository we created in Exercise 5 as a subtree to our conference planning repository.

```plaintext
cd conference_subtree;
git subtree add --prefix posters ../posters master --squash
```

Check the status of the repository. 

```plaintext
git status
```

In this case, unlike the submodule, we don't have to make a commit to finalize the addition of the subtree. If you have a look at the log, you will see that git has added a couple of commits automatically to do this.

```plaintext
git log
```

Note that there is no equivalent command to `git submodule status` that will allow us to list our subtrees and their status.  

## Create new content in the subtree and update the host <a name="update"></a>

Navigate back to the poster repository.

```plaintext
cd ../posters
```

Add some text to the `poster_schedule` file, and commit the change to the posters repository.

```plaintext
echo "Poster 3: Which is better: subtree or submodule?" > poster_schedule;
git commit -am "Add Poster 3 to schedule"
```

Switch back to the main repository.

```plaintext
cd ../conference_subtree
```

Let's update the main repository with the new content of the poster repository.

```plaintext
git subtree pull --prefix posters ../posters master --squash
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

## Examine how git deals with changes to both repositories <a name="examine"></a>

Let's make some changes in both the host repository and the subtree to understand how git deals with subtrees.  

Start by making a change in the host repository. Let's add a lunch break to the schedule on day 2.

```plaintext
sed -i '/^11:00/a 12:00-13:00: Lunch break' schedule_day2
```

Check the status of the repository.

```plaintext
git status
```

You should see the change you just made listed as not staged for commit.

Now navigate into the subtree and check the status there.

```plaintext
cd posters;
git status
```

Here we see the same change listed as not staged for commit. This is a difference to the behavior we saw with submodules. With git subtrees, git considers both the host and nested repository to have the same staging area. The commits from the subtree are all put directly into the commit list of the host repository, unlike with git submodule where they are kept completely separately.

Now try making a change inside the submodule. Let's add another poster title to the poster schedule.

```plaintext
echo "Poster 4: 3 easy steps to git mastery" >> schedule
```

Check the status of the repository.

```plaintext
git status
```

Now we see both changes listed as not staged for commit. This means that we could potentially now make a commit that included content from the host repository AND the subtree, and git would allow it. This could create problems with the history of the repository further down the line, so this should be avoided. The user simply needs to know not to do this, as git will not do anything to stop this.

