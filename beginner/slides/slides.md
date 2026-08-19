---
marp: true
theme: c2sm-light
paginate: true
size: 16:9
footer: "C2SM, ETH Zurich · Git for Beginners · 26 March 2026"
---

<!-- _class: title -->
<!-- _paginate: false -->
<!-- _footer: "" -->

# C2SM Git for Beginners Workshop 2026

26 March 2026

Annika Lauber, Mikael Stellio, Michael Jähn

---

# Schedule

- **9:30 - 10:30** Introduction to Git
- **10:30 - 11:00** Git Branches
- **11:00 - 11:15** Coffee Break
- **11:15 - 12:00** Merge, Restores, Delete, .gitignore
- **12:00 - 13:00** Lunch
- **13:00 - 13:30** Remote Repositories
- **13:30 - 14:00** Merge Conflicts
- **14:00 - 15:00** Repository Managers

---

<!-- _class: section -->

# Part 1:
# Introduction to Git

---

# Why Use a Version Control System?

- Tracks file changes in a documented way

    - Restore previous versions
    - Understand what happened / cahnged between different versions
    - Record reasons for changes

- Allows to work simultaneously on the same code (when using remote server)
    - Alone (on different computers)
    - Multiple people in a collaboration
- Maintain several parallel versions of the same code in a systematic way
- Many tools available (web -based services, graphical interfaces, etc.)

---

<style scoped>
.columns {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 30px;
  width: 100%;
}
.column {
  text-align: center;
}
</style>

# Different Version Control System (VCS)

<div class="columns">

<div class="column">

![w:450](images/local_vcs.png)

Local VCS

</div>

<div class="column">

![w:450](images/centralized_vcs.png)

Centralized VCS (e.g., SVN)

</div>

<div class="column">

![w:450](images/distributed_vcs.png)

Distributed VCS (e.g., Git)

</div>
</div>

_Source: book ProGit_

---

# Why Git?

<div class="columns">

<div>

- Designed for collaborative, open-source workflows
- Distributed
    - Easy and flexible code exchange
    - Back-up your code
- Widely used, fast and efficient

</div>

<div>

![w:250](images/git.png)

![w:300](images/git_distributed.png)

</div>

</div>

---

<style scoped>
.center-content {
  text-align: center;
}
</style>

# Happy Birthday, Git!

<div class="center-content">

![w:450](images/git_20years.png)

_"I'm an egotistical bastard and name all projects after
myself. First 'Linux', now 'git'", says Linus Torvalds
about himself. git is British slang for "stubborn people
who think they're always right and argue around"._

<div class="img-ref">

https://www.heise.de/en/news/Secure-fast-flexible-and-no-alternative-git-turns-20-years-old-10340526.html

</div>

</div>

---
<style scoped>
.comparison-columns {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 90px;
  width: 78%;
  margin: 0 auto;
}
.comparison-column {}
.comparison-box {
  width: 80%;
  margin: 0 auto;
  padding: 0.75em 0.35em;
  border-radius: 24px;
  font-size: 18px;
  line-height: 1.25;
}
.comparison-box ul {
  display: inline-block;
  text-align: left;
}
.comparison-box.orange {
  background: #ffbd0b;
}
.comparison-box.green {
  background: #92d050;
}
</style>

# Practical Example: File for the Planing of a Conference

<div class="comparison-columns">
<div class="comparison-column">

**Without versioning**
<div class="comparison-box orange">

conference_schedule_v0.txt
conference_schedule_v1.txt
conference_schedule_v2.txt
conference_schedule_v2_dj.txt
conference_schedule_v2_orch.txt
conference_schedule_v3.txt

</div>

- Lots of different versions of same file
- Who remembers which one is what?

</div>

<div class="comparison-column">

**With versioning**
<div class="comparison-box green">

conference_schedule.txt
.git (stores version history, date and authors of changes, etc.)

</div>

- Only one working file
- History of file documented
- Easy to combine
</div>
</div>

---

# Local Git Workflow

![w:750](images/git_workflow_locally.png)

---

<style scoped>
section {font-size: 25px;}
</style>

# Important Git Commands

- `git init`:
    - Creates empty Git repository
    - Creates _main_ branch by default
    - Creates the _.git_ folder and contents

- `git add`:
    - Saves code changes to staging area
    - Can add all or only some of the current code changes

- `git commit`:
    - Saves changes from staging area to the repository
    - Creates a unique commit ID
    - Saves a log message for the user

---

# Commit Messages

![w:1000](images/commit_messages.png)

---

# Important Git Commands

- `git log`

    - Displays the log of all commits

- `git status`
    - Shows the status of the working copy
    - States which files have been placed in the staging area
    - Shows which files have been modified but not placed in staging area

- `git diff`
    - Shows changes between two versions of the code

---

<style scoped>
.center-content {
  font-size: 36px;
  text-align: center;
}
</style>

# Important Remarks

<div class="center-content">

It is **difficult to mess something up** with Git – don’t be afraid of it!

**Read what Git tells you**, it is trying to help you!

</div>

---

<style scoped>
.center-content {
  font-size: 34px;
  text-align: center;
}
</style>

# Accessing Exercises

<div class="center-content">

This git course is available at:
https://github.com/C2SM/git-course

→ Select the «beginner» folder to access exercises,
 e.g. «Exercise_1_basic_commands.md»

</div>

---

# JupyterLab

![w:1000](images/jupyterlab.png)

---

<style scoped>
h1 { font-size: 26px; }
</style>

# https://github.com/C2SM/git-course/blob/main/beginner/Unix_Commands.md

![w:1000](images/unix_commands.png)

---

# Exercise 1

- Create Git repository from scratch
- Track changes in files using `git add`, `git status` and `git commit`
- Know state of Git repo using `git diff` and `git log`

---

<!-- _class: section -->

# Part 2: 

# Git Branches

---

<style scoped>
.center-content {
  text-align: center;
}
</style>

# Remark

- Git ≥v2.23: `git switch` and `git restore`.

- Older versions: `git checkout` for both.

<div class="center-content">

We will use `git switch` and `git restore` for simplicity
(`git checkout` commands in brackets)

</div>

---

# Git Branches

<div class="columns">

<div>

![w:550](images/git_branches.png)

<div class="img-ref">

Adapted from <https://blog.nobledesktop.com/learn/git/git-branches>

</div>
</div>

<div>

- Multiple versions of your code
- Branch = copy of your code
- Git: create, merge and delete branches
- Advantages:
    - Easy collaboration with others
    - Experiment with new features
    - Revert changes if necessary

</div>
</div>

---

# Git Branches

- Make changes, without affecting the main version
- Multiple brances co-exist in parallel (different versions of same file)

![w:1050](images/branches_switch.png)

---

# Exercise 2

- Work with branches
- Switch between branches using `git switch`

---

<!-- _class: section -->

# Part 3:

# Merge, Restore and Delete

---

# Merge Branches

![w:900](images/merge_branches.png)

---

# Fast-Forward Merge

- Linear history between _main_ and _featureA_

![w:900](images/fast_forward_merge.png)

---

# 3-Way Merge

- Commits between _main_ and _featureA_

![w:1000](images/merge1.png)

---

# 3-Way Merge

- Commits between _main_ and _featureA_

![w:1000](images/merge2.png)

---

# 3-Way Merge

- Delete branch after merge

![w:750](images/merge3.png)

---

# Git Restore

![w:1000](images/git_restore.png)

---

<style scoped>
section {font-size: 21px;}
</style>

# Important Git Commands

- `git restore`
    - Deletes unstaged changes in working directory
    - `-s <commit ID>`: Changes file to the state at specific commit ID across branches or back in history
    - Can be used for single files (`<file_x>`) or the entire repository (`.`)

- `git merge <source branch>`
    - Combines source branch with target branch (= current branch)
    - Does not create new commit unless specified or needed (depends on your config settings)
    - Called from target branch

- `git branch`
    - list branches in local repository
    - `-a`: list all branches (remotes included)
    - `-d`: delete branch (if already merged into HEAD)
    - `-D`: delete branch (force)

---

<!-- _class: section -->

# Part 4:

# Practice workflow and .gitignore

---

# Understanding .gitignore

- Specifies intentionally untracked files by Git
- Helps maintaining a clean repository
- Examples: binary files, temporary files, log files, etc.
- Example .gitignore:

![w:750](images/gitignore.png)

---

# Important Git Commands

- `git init`: creates a new repository
- `git status`: show the status of working tree (gives list of modified files)
- `git diff`: show differences between commits
- `git add`: add file to the selection of files to be committed (staging area)
- `git commit`: action to create a commit (snapshot of your project at a certain time)
- `git log`: show history of the commits
- `git switch`: switch branches
- `git restore`: restore working tree files
- `git merge`: merge changes from another branch

---

<!-- _class: section -->

# Part 5:

# Remote Repositories

---

# Remote Repositories

<div class="columns">
<div>

- Git repositories are usually hosted on a server (with or without web interface)
- Users clone repository to work on it locally
- The Git server is a "remote" for the local repository
</div>

<div>

![w:350](images/git_server.png)

<div class="img-ref">

Source: <https://medium.com/swlh/continuous-integration-with-arduino-ce3714c19b44>

</div>

</div>

</div>

---

# Remote Repositories

<div class="columns">
<div>

- Git automatically connects remote and local repositories when cloning
- The remote repository is called "origin" by Git

</div>

<div>

![w:350](images/git_server2.png)

<div class="img-ref">

Source: <https://medium.com/swlh/continuous-integration-with-arduino-ce3714c19b44>

</div>

</div>

</div>

---

# Remote Repositories

<div class="columns">
<div>

- Remotes don‘t have to be web-hosted
- Can have multiple remote repositories

</div>

<div>

![w:550](images/central_repo.svg)

<div class="img-ref">

Source: <https://east.fm/refcards/git/sync/syncing.html>

</div>

</div>

</div>

---

# Remote Branches

- Your local repository will have local branches AND remote branches
- You can set up local branches to track the remote ones

![w:850](images/remote_branches.png)

---

# Exchanging Code with Remote Repositories

![w:950](images/git_commands.png)

<div class="img-ref">

Modified after <https://salesforcecodex.com/salesforce/useful-git-commands/>

</div>

---

# Exercise 5: Remote Repositories

- Add a remote repository
- Examine remote branches
- Exchange information with a remote repository

---

<!-- _class: section -->

# Part 6:

# Merge conflicts

---

# Merge conflicts

- Modifications have been made on both branches you are merging

    AND

- If you have both modified the same line in a file or one person has
deleted a file another has modified

![w:650](images/merge_conflicts.png)

---

# Merge conflicts

- Git will stop the merge and notify you that you have conflicts
- You must resolve these conflicts before the merge can be completed.

![w:650](images/merge_conflicts2.png)

---

# Merge conflicts

- To resolve conficts, there are basically two options:

1. Choose the local or the remote version of a file:

    `git restore my_file --ours/theirs`
    (git checkout my_file --ours/theirs)

2. Open file, find conflict markers and decide how to solve the conflict:

![w:250](images/conflict.png)

---

# Merge Conflicts

<div class="columns">
<div>

- Use `git add` to indicate that the file is ready for the merge

- Once all the conflicted files are resolved and added to the staging area, you use
`git commit` to finalize the merge

</div>
<div>

![w:450](images/feature.png)

<div class="img-ref">

<https://haydar-ai.medium.com/learning-how-to-git-merging-branches-and-resolving-conflict-61652834d4b0>

</div>

</div>
</div>

---

# Exercise 6: Merge Conflicts

- Learn how to deal with merge conflicts:
    - Undo merge
    - Choose preferred version
    - Adapt file directly

---

<!-- _class: section -->

# Part 7:

# Repository Managers

---

# Repository Managers

- Interfaces for Git repositories
- Can use the web service or install locally
- Pricing varies – check for academic discounts!
- Examples:
    - C2SM hosts software on GitHub web interface
    - Empa and IAC use local Gitlab servers

![w:550](images/bitbucket.png)

---

# Repository Manager Features

- Easily examine commits and files
- Collaboration tools (more later!)
- Issue reporting
- Code review
- Pull/merge requests
- Automation of testing

---

# Single User or Small Group Workflow

![w:850](images/small_workflow.png)

<div class="img-ref">

<https://blog.devgenius.io/entering-into-devops-01-git-basics-2898fbbb4b5c>

</div>

---

# Large Group Workflow: Using Forks

<div class="columns">
<div>

![w:650](images/large_workflow.png)

</div>
<div>

![w:350](images/fork.png)

</div>
</div>

<div class="img-ref">

<http://www.programmersought.com/article/4701192164/>

</div>

---

# Exercise 7: Repository Managers

- Access code from a Git web interface
- Push code changes to a Git web interface
- Examine the code repository on a Git web interface
