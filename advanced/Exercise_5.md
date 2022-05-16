# Exercise 5 - Using git submodule

In this exercise, we will learn to use git submodule to nest a git repository inside another one. We will first add the git submodule and learn to update it when there are changes. We will also examine how the host and nested repositories deal with changes in their respective files.
  
* [Create a new repository and add it as a submodule](#submodule)

* [Create new content in the submodule and update the host](#update)

* [Examine how git deals with changes to both repositories](#examine)

## Create a new repository and add it as a submodule <a name="submodule"></a>

Navigate to the folder containing the `conference_planning` folder; in other words you should be in a folder that does not contain a git repository. Make a copy of the conference planning repository to use for adding the submodule.

```plaintext
cp -r conference_planning conference_submodule
```

Make a new folder, and initialize a new git repository there for our submodule. Let's use this submodule to hold our list of poster presentations for the conference we are planning.

```plaintext
mkdir posters;
cd posters;
git init
```

Add a file to the posters repository and commit it.

```plaintext
touch schedule;
git add schedule;
git commit -m "Add posters schedule file"
```

Let's add this new git repository as a submodule to our conference planning repository.

```plaintext
cd ../conference_submodule;
git submodule add ../posters
```

Check the status of the repository. 

```plaintext
git status
```

The output shows that there are some changes to the repository, and they are already staged for commit. We should commit them to finalize the adding of the submodule.

```plaintext
git commit -m "Add the posters submodule"
```

Note that the .gitsubmodules file has been added, which contains the path of the submodule in the host repository and the address where the submodule is hosted which is the file path in our case. It could also be a Github address or anywhere else a repository is hosted.

Check the status of the submodule.

```plaintext
git submodule status
```

The output shows us the SHA of the commit that the submodule is currently pointing to.  

## Create new content in the submodule and update the host <a name="update"></a>

Navigate back to the poster repository.

```plaintext
cd ../posters
```

Add some text to the `poster_schedule` file, and commit the change to the posters repository.

````plaintext
echo "Poster 1: Utilizing git to full potential" > poster_schedule;
git commit -am "Add Poster 1 to schedule"
```

Make a note of the SHA of the commit using git log.

```plaintext
git log
```

Switch back to the main repository.

```plaintext
cd ../conference_submodule
```

Let's use submodule update to get the main repository to use the new commit of the poster repository.

```plaintext
git submodule update --remote --merge 
```

The `--remote` option tells git to refer to the remote repository for the latest commit, in this case our poster repository. The `--merge` option tells git to merge the commit into our submodule to keep it up to date.

Examine the status of the submodule again.

```plaintext
git submodule status 
```

The SHA that the submodule points to has now been updated to our latest commit.

In order to finalize the update, we need to commit it to the main repository.

````plaintext
git commit -am "Update posters to latest commit"
```

## Examine how git deals with changes to both repositories <a name="examine"></a>

Let's make some changes in both the host repository and the submodule to understand how git deals with submodules.  

Start by making a change in the host repository. Let's add a lunch break to the schedule on day 1.

````plaintext
sed -i '/^11:00/a 12:00-13:00: Lunch break' schedule_day1
```

Check the status of the repository.

````plaintext
git status
```

You should see the change you just made listed as not staged for commit.

Now navigate into the submodule and check the status there.

```plaintext
cd posters;
git status
```

Here we see that there are no changes. The submodule is treated as a completely separate repository with it's own staging area and commits.

Now try making a change inside the submodule. Let's add another poster title to the poster schedule.

```plaintext
echo "Poster 2: Git submodules and you" >> poster_schedule
```

Check the status of the posters repository.

```plaintext
git status
```

Check the status of the conference planning repository.

```plaintext
cd ..;
git status
```

Git is now informing us that we now have modified content in the posters submodule.  

Go back into the posters submodule and add and commit the change we just made.

```plaintext
cd posters;
git commit -am "Add poster 2 to the schedule"
```

Check the status of both repositories again. Note that git is now notifying us from the host repository that there are new commits inside the submodule. 







