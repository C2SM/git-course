# Exercise 1 - Examining your repository

In this exercise, you will explore several different techniques for examining a Git repository and its history, including `git log`, `git diff`, and `git show`. You will first clone the repository containing this Git course, and then examine it using the various tools. The `git log` and `git diff` sections are adapted from the following Atlassian tutorials:

https://www.atlassian.com/git/tutorials/git-log

https://www.atlassian.com/git/tutorials/saving-changes/git-diff

These tutorials provide a more comprehensive overview of the useful features of `git log` and `git diff` than is presented here, so keep them in mind for future reference.

* [Clone the git repository](#initialization)

* [Use git log](#log)

* [Use git diff](#diff)

* [Use git show](#show)

## Clone the git repository <a name="initialization"></a>

```plaintext
git clone git@github.com:C2SM/git-course
```

Navigate to the repository.

```plaintext
cd git-course
```

## Use git log to have a look at the repository <a name="log"></a>

The `git log` command lists the commits in the repository. You can use the various options for `git log` to format how the commits are displayed and/or filter which commits are displayed. Start with the basic command to see the default behavior. You can exit out of the log at any time by pressing the `q` key.

```plaintext
git log
```

Let's look at some options for changing the way commits are displayed.

To get a high-level overview of the repository, try the `--oneline` option:

```plaintext
git log --oneline
```

To get a brief summary of the changes made by each commit, use the `--stat` option:

```plaintext
git log --stat
```

To quickly see who has worked on which commits, use the `shortlog` command:

```plaintext
git shortlog
```

To get a picture of the history of the branch structure of the repository, use the `--graph` option. This is especially useful when used in combination with the `--oneline` option.

```plaintext
git log --graph --oneline
```

Now, let's look at some of the ways we can filter commits using the `git log` options.  

To limit the number of commits shown, try the `-` option:

```plaintext
git log -3
```

To see commits made by a specific author, use the `--author` option. This option takes a regular expression and returns all commits whose author matches that pattern.

```plaintext
git log --author="Jonas"
```

To see all the commits that have changed a specific file, such as `helpers.sh`, try the following:

```plaintext
git log helpers.sh
```

To see all commits that add or remove a specific line of text, for example `Have fun!`, try the following:

```plaintext
git log -S 'Have fun!'
```

Remember that you can combine any of these `git log` options to get the output you want. And if you decide on a format that you want to use frequently, you can create an alias for that format using `git config`. For example, to set up an alias to use `git log` with the `--oneline` and `--graph` options, use the following command:

```plaintext
git config --global alias.lg "log --oneline --graph"
```

This command writes into your *.gitconfig* file on your *$HOME* directory. If you now run `git lg`, you will see the log with the options you specified. Note that you can create aliases for any Git command using `git config` and this is a very powerful tool.


## Use git diff <a name="diff"></a>
The `git diff` command shows the differences between two different Git data sources. These data sources can be commits, files, branches, tags and more. The `git diff` command can be used from the command line, but it can be difficult to interpret the output in that format. Therefore, people often use a third-party visualization tool to examine the output of `git diff`. In this section, you will first learn how to use `git diff` from the command line and then you will explore some of the options available to improve the readability of the output.

### git diff on the command line

To get started, let's make a new branch with one change in it.

```plaintext
git switch -c difftest
```

Open the README.md file and make a change to it.

The default behavior of `git diff` is to show all uncommited changes since the last commit. Try this now.

```plaintext
git diff
```

Now, let's add and commit the change you made. Remember to write a meaningful commit message. Note that the `-a` option to the `git commit` command allows us to add any changed files to the staging area without having to use the `git add` command separately.

```plaintext
git commit -am "Type your commit message here"
```

You can use `git diff` to compare the contents of branches, for example the main branch and the difftest branch:

```plaintext
git diff main difftest
```

You can also output the difference between a given file in two different branches.

```plaintext
git diff main difftest ./README.md
```

Now let's use `git diff` to compare the difference between two commits. Use `git log` to get two commit IDs, and then pass the two commit IDs as arguments to `git diff`.

```plaintext
git log
```

```plaintext
git diff 8eb59b37 f435db79
```

Here you can see that the output of `git diff` on the command line can be difficult to read when there are many changes. Let's have a look at some ways to better visualize these differences.

### git diff visualization options

#### git difftool

One way to better visualize the output of `git diff` is to use `git difftool`. This command is a wrapper for `git diff` that allows you to specify the diff tool of your choice to view the output in. You can see all of the possible tools with the `--tool-help` option.

```plaintext
git difftool --tool-help
```

This command lists the available tools that are already installed on the system you're using, as well as the other tools that would work but that you don't have installed yet.

Choose one of the tools installed on your system, and try `git difftool`. Use the `-t` option to specify which tool you want to use. For example, to use vimdiff, try:

```plaintext
git difftool -t vimdiff 8eb59b37 f435db79
```

This command allows you to step through all the files that were changed between the two commits, one at a time, and get a clearer picture of how the files were changed.

#### Git web interface

Git web interfaces, such as GitHub and GitLab, also have built-in wrappers that help to visualize the output for `git diff`.

Let's take a look at the Git course repository on GitHub. You can find it here:
https://github.com/C2SM/git-course

You can access the `git diff` wrapper by adding `/compare` to any GitHub repository URL. So have a look at:
https://github.com/C2SM/git-course/compare

This will open up a comparison interface in your web browser. Here you can use the GUI provided to compare the code between branches and forks. You can also specify exact comparisons by changing the URL. For example, to compare the same two commits that we compared with `git diff` and `git difftool`, you can use the following URL:

https://github.com/C2SM/git-course/compare/8eb59b37..f435db79

You can find more information about using the GitHub compare tool [here](https://docs.github.com/en/pull-requests/committing-changes-to-your-project/viewing-and-comparing-commits/comparing-commits).

Note: You may have noticed that the comparison we did included some binary (.png) files. Since these are binary files, you cannot get an exact difference between them, but the fact that they showed up in the `git diff` output means that the files have changed between the two commits. This can sometimes be useful information. Keep in mind that it's best practice to try to avoid committing binaries to Git repositories if possible. If it is necessary, try to keep the size of the files as small as possible to keep working with your Git repository fast and easy.

## Use git show <a name="show"></a>

The `git show` command is another command that can be used to examine Git objects such as tags and commits. This command can be useful for examining commits because it shows not only the commit SHA and commit message like `git log`, but also the difference in the committed files like the `git diff` command.

Go back to your terminal window with the Git course repository and try out the `git show` command.

```plaintext
git show
```

By default, this command shows us the latest commit, or HEAD in Git terminology. You can see the commit SHA and message, as well as the difference between all the files that were changed in that commit. You can examine any commit in the repository by passing the commit SHA as an input to the `git show` command.

```plaintext
git show f435db79
```

Like `git log`, `git show` can be used with various options that allow you to change the way the information is displayed. There are options that change the way the commit SHA and message are displayed, such as `git show --oneline`. There are also options that change the way that the diff is displayed, but none of them really alleviate the problem that large diffs are generally hard to read in the terminal window. As with all Git commands, you can use the `-h` option to get a description of all the possible options that can be used with `git show`.

```plaintext
git show --help
```
