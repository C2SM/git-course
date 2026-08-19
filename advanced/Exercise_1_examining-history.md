# Exercise 1 - Examining a repository's history

Every repository carries a record of how it got to be the way it is. This exercise is about
reading that record: which commits exist (`git log`), who last touched a given line
(`git blame`), what changed between two points (`git diff`), and what a single commit did
(`git show`).

We use the *git-course* repository itself as the specimen, because it has a real history with
several hundred commits and many authors.

> [!IMPORTANT]
> **Where you work:** the *git-course* repository.
> If you have not cloned it yet, do so now and `cd` into it:
> ```plaintext
> git clone git@github.com:C2SM/git-course git-course
> cd git-course
> ```
> Confirm with `pwd` that you are inside *git-course*.

> [!TIP]
> Every task below has a **Hint** and a **Solution** you can unfold. Try the task first - you
> will remember far more from one command you worked out than from ten you pasted.
> If you get stuck on the exact syntax, `git help log` (or `git log -h` for the short version)
> is faster than searching the internet.

In this exercise we cover the following:
- [Shaping the log output](#shape)
- [Filtering the log](#filter)
- [Saving a favorite view as an alias](#alias)
- [Finding who changed a line with `git blame`](#blame)
- [Comparing with `git diff`](#diff)
- [Inspecting one commit with `git show`](#show)

## Shaping the log output <a name="shape"></a>

Start with the plain command to see the default. Press `q` to leave the pager at any time.

```plaintext
git log
```

That is a lot of screen for very little information. The options below change how each commit
is presented.

**Task 1.** Get a compact overview with **one line per commit**.

<details><summary>Hint</summary>

The option is named after what it produces.

</details>

<details><summary>Solution</summary>

```plaintext
git log --oneline
```

</details>

**Task 2.** Show, for each commit, **which files it touched** and how many lines changed.

<details><summary>Hint</summary>

You are asking for statistics about each commit.

</details>

<details><summary>Solution</summary>

```plaintext
git log --stat
```

</details>

**Task 3.** Draw the **branch structure** of the repository, including all branches, with the
branch and tag names shown. Combine it with the compact output from Task 1.

<details><summary>Hint</summary>

Three options together: one draws the graph, one adds the names, one includes every branch
rather than only the current one.

</details>

<details><summary>Solution</summary>

```plaintext
git log --oneline --graph --decorate --all
```

This is the single most useful `git log` invocation. We come back to it in Exercise 4 to see
the difference between merging and rebasing.

</details>

**Task 4.** Find out **who has contributed** to this repository, and how many commits each
person made.

<details><summary>Hint</summary>

This one is not an option to `git log` but a command of its own, a shortened log.

</details>

<details><summary>Solution</summary>

```plaintext
git shortlog -sn HEAD
```

`-s` summarises to a count per author, `-n` sorts by that count.

Naming `HEAD` explicitly is a good habit: without a revision, `git shortlog` reads from standard
input, so it silently produces nothing when used inside a script or a pipe.

</details>

## Filtering the log <a name="filter"></a>

Shaping decides *how* commits are shown, filtering decides *which* ones.

**Task 5.** Show only the **three most recent** commits.

<details><summary>Solution</summary>

```plaintext
git log -3
```

</details>

**Task 6.** Show only commits written by a particular author. Pick a name you saw in Task 4.

<details><summary>Hint</summary>

The option takes a pattern, not an exact name, so a surname is enough.

</details>

<details><summary>Solution</summary>

```plaintext
git log --oneline --author="Lauber"
```

</details>

**Task 7.** Show only the commits that changed the file *advanced/helpers.sh*.

<details><summary>Hint</summary>

Give `git log` a path. The `--` separator makes it unambiguous that you mean a file and not a
branch.

</details>

<details><summary>Solution</summary>

```plaintext
git log --oneline -- advanced/helpers.sh
```

</details>

**Task 8.** This is the powerful one. Find every commit that **added or removed** the text
`Have fun!` anywhere in the repository.

<details><summary>Hint</summary>

This is called the *pickaxe*. The option is a single capital letter, and it takes the string to
search for.

</details>

<details><summary>Solution</summary>

```plaintext
git log --oneline -S 'Have fun!'
```

Add `-i` to ignore case. A related option, `-G`, takes a regular expression and matches any
commit whose diff contains it, whether or not the number of occurrences changed.

</details>

> [!NOTE]
> `-S` answers a question that is otherwise very hard to answer: *when did this string enter the
> code, and who put it there?* Remember it exists - it will save you an afternoon one day.

## Saving a favorite view as an alias <a name="alias"></a>

Typing `--oneline --graph --decorate --all` gets old quickly. Git lets you name any command.

```plaintext
git config --global alias.lg "log --oneline --graph --decorate --all"
```

Now try it:

```plaintext
git lg
```

This wrote to the file *~/.gitconfig*. Open that file and look at what was added. You can create
an alias for any Git command this way.

## Finding who changed a line with `git blame` <a name="blame"></a>

`git log` works commit by commit. `git blame` works **line by line**: for each line of a file it
shows the commit that last touched it, the author and the date.

**Task 9.** Find out who last changed each line of *README.md*.

<details><summary>Solution</summary>

```plaintext
git blame README.md
```

</details>

**Task 10.** Pick an interesting line from the output, take its commit ID, and read the full
message of that commit to find out *why* the line was written.

<details><summary>Hint</summary>

You already know a command that shows a commit's message. It is covered in the last section of
this exercise.

</details>

<details><summary>Solution</summary>

```plaintext
git show <commit-id>
```

</details>

The same view exists in the web interface: open any file on GitHub and click **Blame**.

> [!NOTE]
> Despite the name, `git blame` is mostly used to find *context*, not culprits. The useful
> question is "what was this change trying to do", and the commit message answers it.

## Comparing with `git diff` <a name="diff"></a>

`git diff` compares two points in the repository. Which two depends on what you give it.

First, make a change to have something to look at. Create a branch and edit a file:

```plaintext
git switch -c difftest
```

Now open *README.md* in an editor and change a line.

**Task 11.** Show the change you just made, which is **not yet staged**.

<details><summary>Solution</summary>

```plaintext
git diff
```

</details>

**Task 12.** Stage the change with `git add README.md`, then run `git diff` again. The output is
empty. Show the staged change instead - that is, what `git commit` would record right now.

<details><summary>Hint</summary>

The option names the area you are comparing against. `--cached` is an older synonym for the same
thing.

</details>

<details><summary>Solution</summary>

```plaintext
git diff --staged
```

</details>

Now commit the change so we can compare larger things:

```plaintext
git commit -m "Describe your change here"
```

**Task 13.** Show what differs between the `main` branch and your `difftest` branch.

<details><summary>Solution</summary>

```plaintext
git diff main difftest
```

</details>

**Task 14.** Show the same comparison, but restricted to *README.md* only.

<details><summary>Solution</summary>

```plaintext
git diff main difftest -- README.md
```

</details>

**Task 15.** Compare two commits from the repository's own history: the state ten commits ago
against the state five commits ago.

<details><summary>Hint</summary>

`HEAD~10` means "ten commits before HEAD". You do not need to look up any commit IDs.

</details>

<details><summary>Solution</summary>

```plaintext
git diff HEAD~10 HEAD~5
```

Using relative references like this is often more convenient than copying commit IDs, and it
keeps instructions like these working as the repository grows.

</details>

### Making diffs readable

The raw output is hard to read once a change is more than a few lines. There are two easy ways
to improve on it.

**In the terminal**, `git difftool` opens the diff in a side-by-side viewer. See what your
machine offers:

```plaintext
git difftool --tool-help
```

Pick one from the list of tools that are *available on your machine* and try it. Vim is present
on essentially every system, including Git Bash on Windows:

```plaintext
git difftool -t vimdiff HEAD~10 HEAD~5
```

It steps through the changed files one at a time. Use `:qa` to leave each file, or `:cq` to quit
the whole session. If Vim is unfamiliar, see [Basic Unix and Vim Commands](../Unix_Commands.md).

**In the web interface**, add `/compare` to any GitHub repository URL:

<https://github.com/C2SM/git-course/compare>

You can compare branches and forks through the menus, or name the two ends directly in the URL:

<https://github.com/C2SM/git-course/compare/main~10...main~5>

More detail in the GitHub documentation on
[comparing commits](https://docs.github.com/en/pull-requests/committing-changes-to-your-project/viewing-and-comparing-commits/comparing-commits).

> [!NOTE]
> If a comparison includes image or other binary files, Git can only tell you *that* they
> changed, not how. This is one reason to keep binaries out of repositories where you can - and
> the reason `git lfs` exists for when you cannot. We come back to that in Exercise 7.

## Inspecting one commit with `git show` <a name="show"></a>

`git show` is the two commands above combined for a single commit: it prints the commit's
metadata and message like `git log`, followed by its diff.

```plaintext
git show
```

With no argument it shows `HEAD`, the commit you are currently on.

**Task 16.** Show the commit that came *three before* the current one, and read both what it
changed and why.

<details><summary>Solution</summary>

```plaintext
git show HEAD~3
```

</details>

**Task 17.** `git show` also works on things that are not commits. Show the contents of
*README.md* **as it was** five commits ago, without changing anything in your working directory.

<details><summary>Hint</summary>

The syntax is `<commit>:<path>`.

</details>

<details><summary>Solution</summary>

```plaintext
git show HEAD~5:README.md
```

This is very handy: you can read any version of any file without switching branches or touching
your working directory.

</details>

## Check yourself

You should now be able to answer these without looking anything up:

- [ ] Which single `git log` invocation shows the whole branch structure compactly?
- [ ] Which option finds the commit that introduced a particular string?
- [ ] What is the difference between `git diff` and `git diff --staged`?
- [ ] How do you refer to "seven commits ago" without knowing its commit ID?
- [ ] How do you read an old version of a file without changing your working directory?

## Clean up

You made a branch and a commit in the course repository. Get rid of them:

```plaintext
git switch main
git branch -D difftest
```
