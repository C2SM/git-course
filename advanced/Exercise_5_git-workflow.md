# Exercise 5 - Practice a Git workflow

In this exercise, you will practice a common Git workflow. First, you will make changes in a branch. Then, you will push the changes to GitHub and open a pull request. Finally, one of your fellow participants will review the pull request and merge it in the *main* branch.

## Fork or use the repository directly
For some projects, you work on a fork; for others, you work directly on the main repository.  
For this exercise, you can choose one of the following options:

- **Fork** the repository [git-workflow-practice](https://github.com/C2SM/git-workflow-practice) into your own GitHub account,  
**or**
- **Work directly** in the repository directory if that is how the course is set up.

## Work on the repository locally
Please replace everything within the brackets (including the brackets) in the following.

Make a local copy (clone) of the repository:

```bash
git clone <repository-url>
cd <repository-directory>
```

Create a new branch for your changes:
```bash
git checkout -b <my-branch>
```

- Make a small change, for example, add a new file or edit an existing file.

- Stage and commit your changes.

You can repeat the steps above as often as you want.

Push your branch to the repository on GitHub:
```bash
git push origin <my-branch>
```


## Work on pull request
- Go to the repository on GitHub. You should see a message suggesting you to open a pull request for your new branch.
Open the pull request and assign one of your fellow participants as the reviewer.

- If someone has requested your review, look at their pull request. Check their changes, add comments if needed, and approve if everything looks fine.

In the whole process, please make sure your branch is up to date with the `main` branch. If the `main` branch has been updated in the meantime, merge the newest version into your branch:
```bash
git checkout main
git pull origin main
git checkout my-feature-branch
git merge main
```

> If you work with a fork, you will have to update the fork with the original repository.

- If you encounter merge conflicts, you need to solve them before you can continue.
If you are not sure how to solve merge conflicts, refer to the [exercise on merge conflicts](../beginner/Exercise_6_merge_conflicts.md) in the beginners Git course.