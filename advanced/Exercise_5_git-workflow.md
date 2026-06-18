# Exercise 5 - Practice a Git workflow

In this exercise, you will practice a common Git workflow. First, you will make changes in a branch. Then, you will push the changes to GitHub and open a pull request. Finally, one of your fellow participants will review the pull request and merge it in the *main* branch.

## Fork or use the repository directly
In GitHub (and also GitLab) you can either work directly on the main repository or work on a fork and then merge your changes back to the main repository via a pull request (PR). Usually, you work on a fork when you don't have direct write permission to the main repository, since you can always open a PR to get your changes merged.
For this exercise, you can choose one of the following options:

- **Fork** the repository [git-workflow-practice](https://github.com/C2SM/git-workflow-practice) into your own GitHub account,  
**or**
- **Work directly** in the repository on your personal branch.

## Work on the repository locally
> Note: Please replace everything within the angle brackets (including the brackets `<>`) in the following.

Make a local copy (clone) of the repository:

```bash
git clone <repository-url>
cd <repository-directory>
```

Create a new branch for your changes and set the upstream correctly:
```bash
git switch -c <my-branch>
git push -u origin <my-branch>  # Note that this only needs to be done once per branch (generally when it's created)
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
git switch main
git pull origin main
git switch my-feature-branch
git merge main
```

> Note: If you work with a fork, you will have to update the fork with the original repository.

- If you encounter merge conflicts, you need to solve them before you can continue.
If you are not sure how to solve merge conflicts, refer to the [exercise on merge conflicts](../beginner/Exercise_6_merge_conflicts.md) in the beginners Git course.
