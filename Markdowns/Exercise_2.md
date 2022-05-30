## Exercise 2

## Goals
   * Learn how to work with branches and switch between them using `git switch`.
   * Note: `git checkout` can be used as an alternative for `git switch`. However, it has some other functionalities, which led to confusion among users in the past. Therefore, we will not use it here but show the alternative commands in brackets.

## Structure
In this exercise we will work on planning a two-day conference with two files containing the schedule for day 1 and 2 (schedule_day1 and schedule_day2). For adding events to the schedules (e.g., planned talks, poster sessions, etc.), we work on separate branches to not mix things up.
Again, the exercise consists of short descriptions about a specific Git command, followed by a practical part where you can execute appropriate Git commands.

In order to allow a smooth exercise, there are some functions written by C2SM in the file *helpers.sh* that are **NOT** part of Git. For this exercise we use the following functions from that file:
   * **init_exercise:** It will create the *work* directory and navigate into it 
   * **reset:** It will delete the *work* folder and enable you a clean restart of the exercise in case you completely mess it up
   * **init_simple_repo:** setup a Git repository containing a first version of schedule_day1 and schedule_day2 on branch *main*.
   
_**Reminder:** all text enclosed with `<>` denotes a placeholder to be replaced by a specific string appropriate to your context._

_**Note:** Always run `git commit` and `git merge` with a git message `-m <meaningful_message>`. Otherwise git may try to open the git editor, which does not work on jupyter notebook and will break your current session._

### Initialization


```bash
# check current directory with "pwd"
pwd
# go to folder of this exercise using "cd"

```


```bash
# execute this code at the very beginning to initialize the exercise properly
source ../helpers.sh
init_exercise
```

***
### Optional: clear notebook and restart
**In case you mess up your notebook completely,  
execute** ***reset*** **in the following cell. This will restore a clean environment!**



```bash
## only execute in case of (serious) trouble ##
## it will delete your entire work directory ##
reset
```

***
## Exercise

### Learn how to work with branches and switch between them using git checkout
In the output above we see two files:
   * schedule_day1
   * schedule_day2
   
Let's first have a look at them using the *cat* command:


```bash
# this line will setup a simple Git repository for you
init_simple_repo
```


```bash
# display content with cat: "cat <schedule_dayX>"

```

As you see, there is still a lot of free time available to add talks, poster sessions, breaks etc.

To keep everything in order we do this in two different Git branches:
one each for schedule_day1 and schedule_day2. 

**So let's start!**


```bash
# create a new branch for planning day 1
# use 'git switch -c <meaningful_branch_name A>' to create a new branch
# (Alternative: git checkout -b <meaningful_branch_name A>)

```

From now on, we do all modifications of the schedules directly via Jupyter Notebooks.
   * On the start page go to folder *~/Exercise_2/work/conference_planning*
   * Open *schedule_day1*
   * Add more information to the schedule, i.e. a planned talk or lunch
   
**Do not forget to save your modifications before coming back!**

After saving, we run `git status` to see if Git tracked our changes.


```bash
# Make changes to schedule_day1

```


```bash
# see if git tracked our changes

```

The output should look like:
```
On branch plan_day1
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   schedule_day1

no changes added to commit (use "git add" and/or "git commit -a")
```

Do a commit with these changes...


```bash
# add schedule_day1 and commit it

```

For the planning of the other day we want to use another Git branch.
To not lose track of all the different branches, Git provides the `git branch` to see all branches of a repository.
The * indicates our current branch.


```bash
# see all branches of our Git repository

```

We can switch easily between these branches using the `git checkout` function.
Don't worry -> Git will keep all your work done in this branch.


```bash
# go back to branch main using "git switch main"
# (Alternative: git checkout main)

```

Create a new branch for planning day2 and extend the schedule_day2 in that branch similar as already done for schedule_day1


```bash
# create a new branch and edit schedule_day2

```


```bash
# add and commit your changes

```


```bash
# see again all branches of our Git repository

```

The output should look similar to:

```
  main
  plan_day1
* plan_day2
```

Our git repository now contains:
  * Branch `<meaningful_branch_name A>` with modifications of schedule_day1
  * Branch `<meaningful_branch_name B>` with modifications of schedule_day2
  * Branch `main` with the initial version of schedule_day1 and schedule_day2
  
With `git checkout` it is easy to jump between these branches and modify our schedules further.
To show its capabilities we quickly switch between the branches and see how our schedules change.

To output the content of a text file to the terminal you can use `cat <your_schedule>`.


```bash
# display the content of schedule_day1 and schedule_day2 using "cat"

```


```bash
# switch to branch main and do the same again

```


```bash
# switch to the branch not visited yet and display the content of the schedules again

```
