# Exercise 6 - Using git cherry-pick

In this exercise, we will learn to use git to cherry pick a commit. We will add a series of commits to a feature branch, and then use cherry pick to apply only one of these commits to the main branch.

This exercise uses the same git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the `Initialize the git repository` [section of Exercise 3](./Exercise_3.md).

* [Add feature branch and commits](#feature)

* [Use git cherry-pick](#cherry)

## Add feature branch and commits <a name="feature"></a>

Navigate to the `conference_planning` folder.

Add a feature branch.  

```plaintext
git switch -c cherry_feature
```

Let's add a couple of commits to this branch.

Add a keynote speech to the schedule for day 1. You can use a file editor to open the file, or use a command line tool to change the file. The following gives examples using the `sed` command line tool, which were tested on Linux but may not work on other platforms.  

```plaintext
sed -i '/^Daily/a 08:00-09:00: Keynote speech' schedule_day1
```

Add and commit this change. Remember to use a meaningful commit message.

```plaintext
git commit -am "Add keynote speech to day 1"
```

Add an excursion to the schedule for day 2, and add and commit this change as well.

```plaintext
sed -i '/^12:30/a 13:30-15:00: Excursion' schedule_day2
git commit -am "Add excursion to day 2"
```

Extend the coffee break on day 1 to be half an hour in length. Add and commit this change.

```plaintext
sed -i '/Coffee/c\11:00-11:30: Coffee break' schedule_day1
git commit -am "Extend coffee break on day 1"
```

Use git log to have a look at the history. Make a note of the SHA of the commit you just made.

## Use git cherry-pick <a name="cherry"></a>

Switch to the main branch, and cherry-pick the last commit, substituting the SHA of the commit you just made for `<SHA>` in the following commands.

```plaintext
git switch main
git cherry-pick <SHA>
```

Have a look at the repository using the log, and examine the files as well. There's a couple important things to note here. First, notice that git has created an entirely new commit and SHA for the commit you cherry picked. This means that the feature branch should NOT be merged into the main branch anymore, because you will end up with two commits with exactly the same content. Therefore, cherry picking should really be reserved for saving useful changes from abandoned branches. If the branch is still actively being developed, then `git merge` should be used instead.

The other important thing to notice here is that git has only applied the changes in the last commit, i.e. the extension of the coffee break. The other changes we made before in previous commits (adding the keynote and excursion) are not applied.
