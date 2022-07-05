# Exercise 1 - Examining your repository with git log and git diff

In this exercise, you will play around with a few different techniques for examining your repository and it's history. We will start by initializing a simple git repository and adding a few commits to it to make the history more interesting. Then we will examine the repository using both git log and git diff from the command line. Finally, we will use third party visualization tools to make examining the repository even easier. 

* [Initialize the git repository](#initialization)

* [Add a few commits](#commits)

* [Use git log and git diff from command line](#cli)

* [Use third party tools to examine the git repository](#tools)

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

Take some time to familiarize yourself with the git repository by examining the files and using `git status`, `git log`, `git diff`, etc.  

## Add a few commits <a name="commits"></a>

Let's add a branch and a few commits to make the history a bit more interesting. First, add a feature branch.

```plaintext
git switch -c feature
```

Make a change in a file and add it as a git commit. Note that the `-am` options of the `git commit` command can be used to add all changed files to the staging area and commit them with a message in one single operation.

```plaintext
sed -i '/Coffee/ a 11:15-12:30: Presentation session' schedule_day1;
git commit -am "Add presentation session to day 1"
```

Switch back to the main branch and add a commit there.

```plaintext
git switch main;
sed -i '/Evening/ i Dinner break' schedule_day1;
git commit -am "Add dinner break to day 1"
```

Merge the feature branch into the main branch.

```plaintext
git merge feature
```

## Use git log and git diff from command line <a name="cli"></a>
Now we will examine the repository and it's history using git log and git diff. Each of those has multiple options that can be used to tailor them for specific uses. Atlassian provides an excellent tutorial for both git log and git diff, so we are going to follow them now. Go to the following websites and apply the different techniques described there to the repository we just created.

https://www.atlassian.com/git/tutorials/git-log

https://www.atlassian.com/git/tutorials/saving-changes/git-diff

## Use third party tools to examine the git repository <a name="tools"></a>


