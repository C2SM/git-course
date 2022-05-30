# Exercise 7

# Goals
* Access code from a Git web interface
* Push code changes to a Git web interface
* Examine the code repository on a Git web interface

### Initialization


```bash
# check current directory with "pwd"
pwd
# go to folder of this exercise using "cd"

```


```bash
# execute this code at the very beginning to get access to the helper functions
source ../helpers.sh
init_exercise
```

***
### Optional: clear notebook and restart
**In case you mess up your notebook completely,  
execute** ***reset*** **in the following cell. This will restore a clean environment!**


```bash
## only execute in case of (serious) trouble ##
## it will delete your entire work-directory ##
reset
```

## Exercise

In this exercise we are going to work with a repository we are hosting on the GitHub website.

First, let's make a fork of the repository so that you can have your own copy of a C2SM repository to work with.  A fork is a complete copy of a repository into your own account, where you have full permission to make whatever changes you like to your forked repository. To make your fork, open another tab in your browser and navigate here: https://github.com/c2sm/git-example

**Use the web interface to make a fork:**

![Fork.png](attachment:Fork.png)

### Clone the fork

GitHub indicates on the upper left that this repository is a forked one (left arrow).


Next, copy your forked repository to your local workspace using the link (right arrow):

![Forked_Repo_view.png](attachment:Forked_Repo_view.png)


```bash
# use "git clone <path_to_repository>" to download your forked repository

```


```bash
# use "cd" to enter the repository

```

### Examine the repository
Let's examine the repository.  Does it have any remotes?  What branches are in it?  


```bash
# use "git remote -v", "git branch -a", and "git status" to examine the repository

```

You should have seen that your local repository has a remote called "origin", which points to your fork on GitHub.  This is the default behavior when you use git clone to copy a repository.  

### Add to local repository
Next, let's make a new branch and add a commit to it.  


```bash
# use "git switch -c <branch_name>" to make a new branch

```

Make a change in your local repository.
Remember to do all modifications of the schedules directly via Jupyter Notebooks.
   * Go to folder *work* and enter *git-example*
   * Open *schedule_day1*
   * Add more information to your schedule, i.e., workshops, talks, poster sessions, etc.
   
**Don't forget to save your modifications before coming back!**


```bash
# add and commit your changes

```

### Send local information to Github

Now, let's send our new branch to our GitHub fork.


```bash
# find out current directory
pwd
```

Please open a terminal and go to the directory you get executing the cell above.

![Open_Terminal.png](attachment:Open_Terminal.png)


### Create user token for https

GitHub only allows authorized users to push to repositories.
Therefore, we need to create a GitHub user token.

Please follow the [description](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#creating-a-token) provided by GitHub.

Once you have a token, you can enter it instead of your password when performing Git operations over HTTPS.

**Please save the token at some place, GitHub displays it only once to you.**

In our case we use the token to perform the `git push` command in the terminal you just opened:

```
git push origin <branch_name>
Username: your_username
Password: your_token
```

### Examine the Github repository

Head back to Github and have a look at your forked repository.  

Let's use the web interface to examine the repository.  Try the following tasks there:

1. Find the list of commits and examine the files for a specific commit.  

2. Modify a file and use the web interface to make a new commit on a new branch and automatically create a Pull Request.

![Edit_file_PR.png](attachment:Edit_file_PR.png)

3. Find the Pull Request and have a look at it.

### Update local repository using git fetch

Now, let's get the commit we made on Github into our local repository.   


```bash
# use "git fetch origin" to download the new commit from your fork

```


```bash
# use "git status" to examine your repository

```

Our new commit has been downloaded into a remote branch, but is not yet available in our local branch.  Let's use ```git merge``` to update our local branch.    


```bash
# use "git merge <remote_name>/<branch_name>" to sync up your local branch with the remote one 

```

### Update local repository using git pull

Let's examine the difference between git fetch and git pull.  We just used git fetch to get a commit from our remote repository, and then we used git merge to include it in our local branch.  

First, go back to the web interface and use it to make a new commit by editing a file and again creating a new branch.  

Next, let's get that commit into our repository.  


```bash
# use "git pull origin" to download the new commit from your fork

```

Have a look at your local branch.  You should see that the commit you made has already been put into your local branch, because git pull does both a git fetch AND a git merge automatically.   
