# Exercise 1

## Objective

* Create a Git repository from scratch
* Track changes to files using `git add`, `git status`, and `git commit`
* Know the state of the Git repository using `git diff` and `git log`

## Structure

This exercise consists of short descriptions of specific Git commands, followed by a hands-on part where you will be able to execute the corresponding Git commands.

## Helper Functions

The following helper functions in the file *helpers.sh* are written by C2SM and are **NOT** **part of Git**. They will set up simple repositories for you that have a short Git history, so that you have something to work with.

For this exercise, we will use the following functions from this file:
   * `init_exercise`: This will create the *beginners_git* directory in the parent directory of the *git-course* directory. It will also delete any old version of the *beginners_git* directory, so don't use the *beginners_git* directory to save any work.
   * `reset`: This will delete the *beginners_git* directory and allows you a clean restart of the exercise in case you messed it up completely.


## Remarks   

> **Note:** Any text enclosed in `<>` denotes a placeholder to be replaced with a specific string appropriate to your context, i.e. delete `<>` and replace it with the appropriate word.

> **Note:** Some exercises may require the use of basic Unix commands. If you are unfamiliar with Unix systems, refer to the file [Basic Unix Commands](Unix_Commands.md) for a list of all necessary commands.

## Global Git Configuration Settings

Before we start using Git, we should set some global configurations. This only needs to be done once, and will be saved for all your future sessions.

1. First of all, we need to tell Git who we are.
To do this, run the following lines with your credentials:
```
git config --global user.name "<John Doe>"
git config --global user.email "<my_name@some.domain>"
```
> **Note:** Use your real first and last name as your username and set the same email as your GitHub account. Also, ensure your actual name is set on GitHub; otherwise, your commits will appear under different authors.

At the end of this course, you will learn something about repository managers like GitHub. Recently, they changed their naming policy for the initial branch from *master* to *main*. So we want to tell Git to set our default branch name to *main* as well. 

> **Note:** Refer to the official Git documentation (https://git-scm.com/docs/git-init#Documentation/git-init.txt--bltbranch-namegt).

2. Set *main* as the default branch name:
```bash
git config --global init.defaultBranch main
```

## Clone the `git-course` Repository

Now, we are ready to clone the `git-course` repository, which 
we need for all exercises in this course.

Open your terminal and navigate to the directory where you want to work on the Git course. Use the following command to verify your current location:

```bash
pwd
```

If you would like to work on the Git course in your home directory, you can navigate there using the following command:

```bash
cd ~
```

If you are satisfied with your current directory, use the following command to clone the repository containing the course material:

```bash
git clone git@github.com:C2SM/git-course.git 
```

> **Note:** If you did not set up an SSH key linked to your GitHub account, you will have to use `https://github.com/C2SM/git-course.git` instead for cloning the repository.

You can now navigate into it with

```bash
cd git-course
```

## Initialization

Let's switch into the `beginner` folder of our repository:

```bash
cd beginner
```

---

> **To initialize the exercise properly, run this code at the very beginning. Check the [Helper Functions](#helper-functions) section above for more explanation.**

```bash
# source the helpers.sh file to be able to use its functions
source helpers.sh
# init exercise
init_exercise
```

Note that the `init_exercise` function will move you out of the `git-course`
repository! You can check this with the `pwd` command.

---

### Optional: restart exercise repo

⚠️ **In case you messed up somehow, execute the `reset` function. Check the [Helper Functions](#helper-functions) section above for more explanation.**

```bash
## only execute this in case of (serious) trouble ##
## it will delete your entire beginners_git directory ##
reset
```

## Exercise


### Create a Git repository from scratch
> Hint: check the [Basic Unix Commands](Unix_Commands.md) if you don't know how to do the following.

1. Create a new folder (e.g. *git_repo*) and navigate to it
2. Use the command `git init` to initiate your first Git repository

You should now get an output similar to:
```
Initialized empty Git repository in <parent-dir-of-git-course>/beginners_git/git_repo/.git/
```
### Make and track changes in files using `git add`, `git commit` and `git status`

In a next step you will add some files to your repository.  
To do this, we will use the `echo` command in combination with the `>` operator to direct its
output to a file.

1. Create a text file using the `echo` command
```bash
echo "<my text for file>" > first_file.txt
```
2. Use `echo` and `>` again to create a second text file
3. Check the status of your Git repository with `git status`

You should now get an output similar to:


```
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	first_file.txt
	second_file.txt

nothing added to commit but untracked files present (use "git add" to track)
```


Git has detected the two new files, but the files are not yet included in the Git repository.

4. Add the files using `git add`
```bash
git add first_file.txt
git add second_file.txt
```

5. Check your actions with `git status` again

Your output should look like this:

```
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   first_file.txt
	new file:   second_file.txt
```

6. The last thing to do is to commit these files together with a commit message:
```bash
git commit -m "<meaningful message>"
```

**Congrats!**  
Your files are included in the Git repository.


### Know state of Git repository using `git diff` and `git log`
Right now we have two files in our Git repository.
Let's see what happens when we modify them. We will use the `>>` operator to append a new line of text to our files.

1. Append a new line of text with "echo" and ">>" to one of the files
2. Check state of your repository with `git status`

Your output should look similar to:

```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   first_file.txt

no changes added to commit (use "git add" and/or "git commit -a")
```


When working in a repository, it easily happens that you forget about changes you have made, such as the extra lines you just added. 
Git provides the `git diff` command to check, what new changes are contained in a file

3. See local changes of a modified file with `git diff <your_filename>`

The output should we something like:

```
diff --git a/first_file b/first_file
index 3829ab8..a32d2f3 100644
--- a/first_file.txt
+++ b/first_file.txt
@@ -1 +1,2 @@
 myfirstline
+mysecondline
```

We see a lot of information, but all that we care about is the last line:  
The "+" indicates that we have a new line in our file.


Let's modify the second file as well.

4. Add a new line in the second file

The next lecture is starting soon, so let's add and commit our changes for safety reasons.

5. Add the two modified files with `git add`

6. Use `git status` to check if your action was successful

7. Now commit your changes with a meaningful commit message

**Congrats!**   
But how many commits do you already have in this repository?
Git does all this tracking for us!   

The command `git log` allows us to look back in time and explore what commits are contained in our repository.

8. Type `git log` to get an overview of the (very short) life of your repository

Below you see an example of what your log could look like:

```
commit 26c65dd070e995db55ac46d76cdb5052da03f5cb (HEAD -> main)
Author: juckerj <jonas.jucker@env.ethz.ch>
Date:   Tue Feb 23 17:16:03 2021 +0100

    add second lines

commit 495eb9387e4407f3accb57a8f29d7362eead85bb
Author: juckerj <jonas.jucker@env.ethz.ch>
Date:   Tue Feb 23 16:09:54 2021 +0100

    create two files
```

We see the unique hash of each commit, its author, and the date of the commit.
These are all very useful things as we will see later in this course.
