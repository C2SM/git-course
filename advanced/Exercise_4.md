# Exercise 4 - Using git cherry-pick

In this exercise, we will learn to use git to cherry pick a commit. We will add a series of commits to a feature branch, and then use cherry pick to apply only one of these commits to the main branch. We will use the same repository that we did in Exercises 1 and 2.  
  
* [Add feature branch and commits](#feature)

* [Use git cherry-pick](#cherry)

## Add feature branch and commits <a name="feature"></a>

Navigate to the `conference_planning` folder, if you are not already there.

Add a feature branch.  

```plaintext
git switch -c feature
```

Let's add a couple of commits to this branch. 

Add a keynote speech to the schedule for day 1. You can use a file editor to open the file, or use a command line tool to change the file.   
 
```plaintext
sed -i '/^Daily/a 08:00-09:00: Keynote speech' schedule_day1 
```

Add and commit this change. Remember to use a meaningful commit message.

```plaintext
git commit -am "Add keynote speech to day 1"
```

Add an excursion to the schedule for day 2, and add and commit this change as well.

```plaintext
sed -i '/^Coffee/a 13:00-15:00: Excursion' schedule_day2;
git commit -am "Add excursion to day 2"
```

Extend the coffee break on day 1 to be half an hour in length. Add and commit this change. 
```plaintext
sed -i '/Coffee/c\11:00-11:30: Coffee break' schedule_day1;
git commit -am "Extend coffee break on day 1"
```

Use git log to have a look at the history. Make a note of the SHA of the commit you just made.


## Use git cherry-pick <a name="cherry"></a>

Switch to the main branch, and cherry-pick the last commit.

```plaintext
git switch -c main
git cherry-pick SHA
```

Have a look at the repository using the log, and examine the files as well. There's a couple important things to note here. First, notice that git has created an entirely new commit and SHA for the commit you cherry picked. This means that the feature branch should NOT be merged into the main branch anymore, because you will end up with two commits with exactly the same content. Therefore, cherry picking should really be reserved for saving useful changes from abandoned branches. If the branch is still actively being developed, then `git merge` should be used instead.

The other important thing to notice here is that git has only applied the changes in the last commit, i.e. the extension of the coffee break. The other changes we made before in previous commits (adding the keynote and excursion) are not applied. 
