# Exercise 1 - Examining your repository

In this exercise, you will explore a few different techniques for examining a git repository and it's history, including git log, git diff, and git grep. You will first clone the repository containing this git course, and then examine it using the different tools. The sections covering git log and git diff are adapted from the following excellent Atlassian tutorials:

https://www.atlassian.com/git/tutorials/git-log

https://www.atlassian.com/git/tutorials/saving-changes/git-diff

These tutorials offer a more comprehensive overview of the useful functionality of git log and git diff than presented here, so keep them in mind as a future reference.

* [Clone the git repository](#initialization)

* [Use git log](#log)

* [Use git diff](#diff)

* [Use git difftool](#tool)

* [Use git grep](#grep)

## Clone the git repository <a name="initialization"></a>

```plaintext
git clone git@github.com:C2SM/git-course
```

Navigate into the repository.

```plaintext
cd git-course
```

## Use git log to have a look at the repository <a name="log"></a>

The `git log` command lists the commits in the repository. You can use the various options for git log to format how the commits are displayed and/or filter which commits are displayed. Start with the basic command to see the default behavior. You can exit out of the log at any time by hitting the `q` key.

```plaintext
git log
```

Let's look at some of the ways that we can change how the commits are displayed.

To get a high-level overview of the repository, try the `--oneline` option:

```plaintext
git log --oneline
```

To get a brief summary of the changes introduced by each commit, use the `--stat` option: 

```plaintext
git log --stat
```

To quickly see who has been working on what commits, use the `shortlog` command:

```plaintext
git shortlog
```

To get a picture of the history of the branch structure of the repository, use the `--graph` option. This option is particulary helpful when used in combination with the `--oneline` option.

```plaintext
git log --graph --oneline
```

Now, let's look at some of the ways we can filter commits using the `git log` options.  

To limit the number of commits displayed, try the `-` option:

```plaintext
git log -3
```

To see commits made by a certain author, use the `--author` option. This option accepts a regular expression and returns all commits whose author matches that pattern.  

```plaintext
git log --author="Jonas"
```

To see all the commits that changed one specific file, for example the `helpers.sh` file, try the following:

```plaintext
git log helpers.sh
```

To see all commits that introduce or remove a specific line of text, for example `Have fun!`, try the following:

```plaintext
git log -S 'Have fun!'
```

Remember that you can combine any of these git log options together to achieve your desired output. And if you decide on a format that you would like to use frequently, you can create an alias for this format using `git config`. For example, to set up an alias to use git log with the `--oneline` and `--graph` options, use the following command: 

```plaintext
git config --global alias.lg "log --oneline --graph"
```

Now, if you use `git lg`, you will see the log with the options you specified. Note that you can create aliases for any git command using `git config` and this is a very powerful tool.

 
## Use git diff <a name="diff"></a>



## Use git difftool <a name="tool"></a>


