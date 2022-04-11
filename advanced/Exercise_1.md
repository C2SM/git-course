# Exercise 1 - Conflicting merges

In this exercise, you will first setup a simple git repository using helper scripts provided by C2SM.  Then, you will generate a merge conflict between a feature branch and the main branch in a git repository.  Finally, you will learn how to resolve the conflict and successfully complete the merge.  

[Initialize the git repository](#initialization)
[Create a merge conflict](#conflict)
[Resolve the merge conflict](#resolution)

## Initialize the git repository <a name="initialization"></a>

Use the helper scripts provided in https://www.github.com/C2SM/git-course to set up a simple git repository.

First, clone the git-course repository.  

```plaintext
git clone git@github.com:C2SM/git-course
```

Navigate into the repository.

```plaintext
cd git-course
```

Source the file containing the helper scripts: `helpers.sh`

```plaintext
source helpers.sh
```
Run the `init_advanced_repo` script.  This script will create a folder at the same level as the git-course repository containing a simple git repository called `conference_planning`.  

```plaintext
init_advanced_repo
```

Navigate to the new git repository, and take some time to familiarize yourself with it.  

```plaintext
cd ../conference_planning
```

## Create a merge conflict <a name="conflict"></a>

Create a feature branch in the conference planning repository that conflicts with a change in the main branch.  

First, create a new feature branch and switch to it.  

```plaintext
git switch -c feature
```

Make a change in one of the schedule files.  You can use your favorite file editor or a command line utility to do so.  

For example, you could use:

```plaintext
sed -i 's/Coffee/Tea/g' schedule_day1
```
Commit your change to the feature branch, remembering to make a meaningful commit message.  

```plaintext
git commit -am "Change coffee break to tea break on day 1"
```

Switch back to the main branch.

```plaintext
git checkout main
```

Make a different change to the SAME line in the file you changed in the feature branch using either the file editor or a command line utility.  For example, you could use:

```plaintext
sed -i 's/Coffee/Cocoa/g' schedule_day1
```

Commit this change to the main branch.  

```plaintext
git commit -am "Change coffee break to cocoa break on day 1"
```

Now, we will initiate the merge of the feature branch into the main branch.

```plaintext
git merge feature
```

Examine the git output carefully. It will indicate that there are conflicts that need to be resolved before the merge can be completed and which file(s) contain the conflicts.  

## Resolve the merge conflict <a name="resolution"></a>

Use a file editor to open the conflicted file and resolve the conflict. To do so, you must 
1. Decide which of the conflicting lines is the correct one, and delete the other one.
2. Remove all of the conflict markers from the file (<<<,===,>>>)

Stage the file once you have resolved the conflict.  Staging the file indicates to git that the conflicts have been resolved. Note that git does not check the file for conflict markers at this point; it is trusting you that you have removed them all, so you must be sure.  

```plaintext
git add schedule_day1
```

Run git commit to finalize the merge. A merge commit will be created, so you may be prompted to enter a commit message if you don't add one on the command line.  

```plaintext
git commit -m "Merge feature branch into main including resolved conflict"
```

