# Exercise 8 - Using `git submodule`

In this exercise, we will learn to use `git submodule` to nest a Git repository inside another one. We will first add the Git submodule and examine how the host and nested repositories deal with changes in their respective files. We will then learn how to pull and push changes to and from the sub-repository.

This exercise uses the same Git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the [Initialize the Git repository](./Exercise_3_gitignore.md#initialize) section of Exercise 3.

* [Fork a repository on GitHub and add it as a submodule](#submodule)

* [Examine how Git deals with changes to both repositories](#examine)

* [Create new content locally and update the sub-repository](#push)

* [Create new content in the sub-repository and update the local repository](#pull)

## Fork a repository on GitHub and add it as a submodule <a name="submodule"></a>

Navigate to the folder that contains the *conference_planning* folder; in other words, you should be in a folder that does not contain a Git repository. Make a copy of the *conference_planning* repository, which you will use to add the submodule.

```plaintext
cp -r conference_planning conference_submodule
```

We have created a repository on GitHub that you can use as a submodule. This repository is called *posters* and will contain the poster titles for our conference.

Navigate to the [posters](https://github.com/AnnikaLau/posters) repository and create a fork of it using the GitHub user interface.

Let's add this fork to our *conference_planning* repository as a submodule. You will need to copy the SSH address of your fork and paste it into the `git submodule add` command below.

```plaintext
cd conference_submodule
git submodule add YOUR_FORK_ADDRESS posters
```

Note that GitHub requires an SSH key to push content to repositories. If you do not already have an SSH key set up in your GitHub account, follow the instructions for [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

Check the status of your repository.

```plaintext
git status
```

The output shows that there are some changes in the repository, and they are already staged for commit. We should commit them to complete the addition of the submodule.

```plaintext
git commit -m "Add the posters submodule"
```

Note that the *.gitmodules* file has been added, which contains the path to the submodule in the host repository and the address where the submodule is hosted, which in our case is the GitHub URL. It could also be another Git web host, a file path, or anywhere else a repository is hosted.

Check the status of the submodule.

```plaintext
git submodule status
```

The output shows us the SHA of the commit that the submodule is currently pointing to.  

## Examine how Git deals with changes to both repositories <a name="examine"></a>

Let's make some changes to both the host repository and the submodule to understand how Git handles submodules.

Start with a change in the host repository. Let's add a lunch break to the schedule on day 1. The following is an example using the `sed` command line tool, which was tested on Linux but may not work on other platforms. You can also simply open the file in a file editor to make the change.


```plaintext
sed -i '/^11:00/a 12:00-13:00: Lunch break' schedule_day1.txt
```

Check the status of the repository.

```plaintext
git status
```

You should see the change you just made listed as not staged for commit.

Now navigate into the submodule and check the status there.

```plaintext
cd posters
git status
```

Here we see that there are no changes. The submodule is treated as a completely separate repository, with its own staging area and commits.

Now try to make a change inside the submodule. Let's add a poster title to the poster file.

```plaintext
echo "Poster 1: Git submodules and you" >> posters.txt
```

Check the status of the *posters* repository.

```plaintext
git status
```

Check the status of the *conference_planning* repository.

```plaintext
cd ..
git status
```

Git is now informing us that we have modified content in the *posters* submodule.

## Create new content locally and update the sub-repository <a name="push"></a>
Now, let's commit the change to the *posters* submodule, and push that change to our *posters* repository on GitHub.

Go back into the *posters* submodule and add and commit the change we just made.

```plaintext
cd posters
git commit -am "Add poster 1 to the schedule"
```

You can treat the submodule like any other Git repository, and simply push the new commit to your fork on GitHub.

```plaintext
git push origin
```

If you go back to your GitHub fork (and refresh the page if necessary), you should see the commit that you just made.

The *conference_planning* repository needs to be updated, to point to the new commit in the *posters* submodule. Let's do that now.

```plaintext
cd ..
git add posters
git commit -m "Update posters submodule"
```

Now, if you check the status of the submodule, you will see that it points to the last commit you made.

## Create new content in the sub-repository and update the local repository <a name="pull"></a>

Finally, let's learn how to pull changes from the submodule into our host repository.

Navigate back to your fork of the *posters* repository on GitHub, and make a change to the schedule file, and commit it. You can do this directly in the web interface by simply selecting the file and using the edit button.

Once you have done this, navigate back to the root of the *conference_planning* folder and use `git submodule update` to get the main repository to fetch the new commit from the *posters* repository.

```plaintext
cd ..
git submodule update --remote --merge
```

The `--remote` option tells Git to refer to the remote repository for the latest commit, in this case our *posters* repository. The `--merge` option tells Git to merge the commit into our submodule to keep it up-to-date.

To complete the update, we need to commit it to the main repository.

```plaintext
git add posters
git commit -am "Update posters to latest commit"
```
