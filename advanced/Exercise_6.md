# Exercise 6 - Using git submodule

This exercise is designed to be paired with Exercise 7 to help you compare and contrast the two main methods for embedding a git repository into another git repository. This exercise illustrates the submodule method, while the next exercise illustrates the subtree method. In this exercise, we will learn to use git submodule to nest a git repository inside another one. We will first add the git submodule and examine how the host and nested repositories deal with changes in their respective files. We will then learn how to pull and push changes to and from the sub-repository.

This exercise uses the same git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the `Initialize the git repository` section [here](./Exercise_3.md).

* [Fork a repository on Github and add it as a submodule](#submodule)

* [Examine how git deals with changes to both repositories](#examine)

* [Create new content locally and update the sub-repository](#push)

* [Create new content in the sub-repository and update the local repository](#pull)

## Fork a repository on Github and add it as a submodule <a name="submodule"></a>

Navigate to the folder containing the `conference_planning` folder; in other words you should be in a folder that does not contain a git repository. Make a copy of the conference planning repository to use for adding the submodule.

```plaintext
cp -r conference_planning conference_submodule
```

I have already created a repository on Github that we will use as a submodule. This repository is called `posters` and will contain the poster schedule for our conference.

Navigate to the repository, found [here](https://github.com/kosterried/posters), and make a fork of it using the Github user interface.

Let's add this fork as a submodule to our conference planning repository. You will need to copy the SSH address of your fork and paste it into the `git submodule add` command below.

```plaintext
cd conference_submodule
git submodule add YOUR_FORK_ADDRESS
```

Note that Github requires an SSH key in order to push content to repositories. If you have not already set up an SSH key in your Github account, it is easy to do and you can find instructions [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

Check the status of the repository.

```plaintext
git status
```

The output shows that there are some changes to the repository, and they are already staged for commit. We should commit them to finalize the adding of the submodule.

```plaintext
git commit -m "Add the posters submodule"
```

Note that the .gitmodules file has been added, which contains the path of the submodule in the host repository and the address where the submodule is hosted which is the Github URL in our case. It could also be another git web host, a file path, or anywhere else a repository is hosted.

Check the status of the submodule.

```plaintext
git submodule status
```

The output shows us the SHA of the commit that the submodule is currently pointing to.  

## Examine how git deals with changes to both repositories <a name="examine"></a>

Let's make some changes in both the host repository and the submodule to understand how git deals with submodules.  

Start by making a change in the host repository. Let's add a lunch break to the schedule on day 1. The following gives examples using the `sed` command line tool, which were tested on Linux but may not work on other platforms. You can also simply open the file in a file editor to make the change.


```plaintext
sed -i '/^11:00/a 12:00-13:00: Lunch break' schedule_day1
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

Here we see that there are no changes. The submodule is treated as a completely separate repository with it's own staging area and commits.

Now try making a change inside the submodule. Let's add a poster title to the poster schedule.

```plaintext
echo "Poster 1: Git submodules and you" >> schedule
```

Check the status of the posters repository.

```plaintext
git status
```

Check the status of the conference planning repository.

```plaintext
cd ..
git status
```

Git is now informing us that we now have modified content in the posters submodule.  

## Create new content locally and update the sub-repository <a name="push"></a>
Now, let's commit the change to the posters submodule, and push that change to our posters repository on Github.

Go back into the posters submodule and add and commit the change we just made.

```plaintext
cd posters
git commit -am "Add poster 1 to the schedule"
```

You can treat the submodule like any git repository and simply push the new commit to your fork on Github.  

```plaintext
git push origin
```

If you navigate back to your Github fork (and refresh the page if necessary), you should see the commit that you just made.  

The conference planning repository now needs to be updated, to point to the new commit in the posters submodule.  Let's do this now.

```plaintext
cd ..
git add posters
git commit -m "Update posters submodule"
```

Now, if you check the submodule status, you will see that it is pointing to the latest commit you made.

## Create new content in the sub-repository and update the local repository <a name="pull"></a>

Finally, let's learn how to pull changes from the submodule into our host repository.  

Navigate back to your fork of the poster repository on Github, and make a change to the schedule file and commit it. You can do this directly on the web interface by simply selecting the file and using the edit button.

Once you have done this, go to back to the terminal and use `git submodule update` to get the main repository to fetch the new commit of the poster repository.

```plaintext
git submodule update --remote --merge
```

The `--remote` option tells git to refer to the remote repository for the latest commit, in this case our poster repository. The `--merge` option tells git to merge the commit into our submodule to keep it up to date.

In order to finalize the update, we need to commit it to the main repository.

```plaintext
git add posters
git commit -am "Update posters to latest commit"
```
