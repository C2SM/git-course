# Exercise 3 - Ignoring files

> [!NOTE]
> **⏱️ Estimated working time:** 10-15 minutes

Not everything in a working directory belongs in a repository. Build products, compiled
binaries, editor backup files, local configuration and anything containing a password should all
stay out. `.gitignore` is how you tell Git which ones.

This exercise also covers the two things about `.gitignore` that surprise people: it has no
effect on files Git is already tracking, and when a file mysteriously refuses to be added, there
is a command that tells you exactly why.

> [!IMPORTANT]
> **Where you work:** `advanced_git/conference_planning`.
> If you have not created the sandbox yet, follow the [Setup section](README.md#setup) first.
> Confirm with `pwd` that you are inside *conference_planning*.

In this exercise we cover the following:
- [Write a README](#readme)
- [Generate a file that should not be committed](#generate)
- [Ignore it](#ignore)
- [Find out why a file is ignored](#why)
- [The already-tracked trap](#trap)
- [Keeping an empty directory with `.gitkeep`](#gitkeep)
- [Ignoring things globally](#global)

## Write a README <a name="readme"></a>

**Task 1.** Create a *README.md* describing the conference planning project, and commit it.

A good README says what the project is, how to use it, and who is involved.
[Markdown basics](https://www.markdownguide.org/basic-syntax/) if you need them.

<details><summary>✅ Solution</summary>

```plaintext
touch README.md
```

Edit it in your editor, then:

```plaintext
git add README.md
git commit -m "Add README file"
```

</details>

## Generate a file that should not be committed <a name="generate"></a>

Real projects produce files from other files: compiled programs, rendered documents, archives.
These should not be committed, because they can always be regenerated and they bloat the
repository.

**Task 2.** Produce such a file. Bundle the two schedule files into a compressed archive called
*schedules.tar.gz*.

<details><summary>💡 Hint</summary>

`tar` is available on Linux, macOS and Git Bash alike. The flags you want are "create",
"gzip" and "file".

</details>

<details><summary>✅ Solution</summary>

```plaintext
tar czf schedules.tar.gz schedule_day1.txt schedule_day2.txt
```

</details>

**Task 3.** Check the repository status and confirm the archive shows up as untracked.

<details><summary>✅ Solution</summary>

```plaintext
git status
```

*schedules.tar.gz* is listed under untracked files.

</details>

## Ignore it <a name="ignore"></a>

**Task 4.** Make Git ignore the archive, and every other `.tar.gz` file, then confirm it worked.

<details><summary>💡 Hint</summary>

Create a file whose name begins with a dot, and put a pattern in it. `*` matches any sequence of
characters.

</details>

<details><summary>✅ Solution</summary>

```plaintext
touch .gitignore
```

Put this line in it:

```
*.tar.gz
```

Then:

```plaintext
git status
```

The archive is gone from the output, and *.gitignore* itself now appears as untracked.

</details>

**Task 5.** *.gitignore* is itself a normal file. Commit it so that everyone working on the
project ignores the same things.

<details><summary>✅ Solution</summary>

```plaintext
git add .gitignore
git commit -m "Ignore generated archives"
```

</details>

### Useful patterns

Add a few of these to your *.gitignore* and watch what `git status` does:

```
*~              # editor backup files
*.exe           # compiled binaries
build/          # a whole directory
netcdf-*        # anything starting with netcdf-
!build/keep.sh  # ...except this one, re-included
```

The `!` prefix is the escape hatch: it re-includes something an earlier pattern excluded. Order
matters, and a file inside an ignored **directory** cannot be re-included - you have to
un-ignore the directory first.

> [!TIP]
> GitHub maintains ready-made `.gitignore` files for most languages and tools at
> <https://github.com/github/gitignore>. Starting from one of those is usually better than
> writing your own from scratch.

## Find out why a file is ignored <a name="why"></a>

Once a `.gitignore` has a dozen patterns, and especially once there are `.gitignore` files in
several directories, "why on earth is this file not showing up" becomes a real question.

**Task 6.** Ask Git which pattern is responsible for ignoring *schedules.tar.gz*.

<details><summary>💡 Hint</summary>

The command name says exactly what it does, and the `-v` flag makes it verbose enough to be
useful.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git check-ignore -v schedules.tar.gz
```

It prints the file that contains the rule, the line number, the pattern itself, and the path.
When a file is being ignored and you cannot work out why, this answers it in one step.

</details>

## The already-tracked trap <a name="trap"></a>

This is the behavior that confuses nearly everyone at least once.

**Task 7.** Create a file *notes.txt*, commit it, and *then* add `notes.txt` to *.gitignore*.
Now modify *notes.txt* and run `git status`. What happens, and why?

<details><summary>✅ Solution</summary>

```plaintext
echo "Some private notes" > notes.txt
git add notes.txt
git commit -m "Add notes"
echo "notes.txt" >> .gitignore
echo "More notes" >> notes.txt
git status
```

The change is still reported. **`.gitignore` only applies to untracked files.** Once Git is
tracking a file, it keeps tracking it, and the ignore rule is simply not consulted.

</details>

**Task 8.** Make Git actually stop tracking *notes.txt*, while keeping the file on your disk.

<details><summary>💡 Hint</summary>

`git rm` normally deletes the file too. One option makes it remove the file only from the index.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git rm --cached notes.txt
git status
ls
```

The file is still in your directory, but Git now reports it as deleted from the repository, and
from the next commit onwards the ignore rule takes effect. Commit that, together with the
*.gitignore* change you made in Task 7:

```plaintext
git add .gitignore
git commit -m "Stop tracking notes.txt"
git status
```

`git status` is clean, and *notes.txt* is quietly ignored.

</details>

> [!WARNING]
> `git rm --cached` stops *future* tracking. The file and all its previous contents remain in the
> repository history. If you committed a password by mistake, this is **not** enough - you have to
> rewrite history (and change the password). See [Expert_Topics.md](../Expert_Topics.md).

## Keeping an empty directory with `.gitkeep` <a name="gitkeep"></a>

Git tracks files, never directories. An empty directory simply cannot be committed.

**Task 9.** Create a directory *output/*, and get Git to record its existence.

<details><summary>💡 Hint</summary>

If Git only tracks files, put a file in it. By convention it is empty and named `.gitkeep`.

</details>

<details><summary>✅ Solution</summary>

```plaintext
mkdir output
git status
```

Nothing - Git does not see empty directories at all. So:

```plaintext
touch output/.gitkeep
git add output/.gitkeep
git commit -m "Keep the output directory"
```

</details>

> [!NOTE]
> `.gitkeep` is a convention, not a Git feature. The name has no special meaning to Git and any
> filename would work. It is widely used precisely because it reads as "this file exists only to
> keep the directory".
>
> A common combination is to keep a directory but ignore what lands in it:
> ```
> output/*
> !output/.gitkeep
> ```

## Ignoring things globally <a name="global"></a>

Some things should never be committed to *any* repository: `.DS_Store` on macOS, editor
swap files, IDE folders. Those are about **your** setup, not the project, so they do not belong
in the project's *.gitignore*.

**Task 10.** Set up a personal ignore file that applies to every repository on your machine.

<details><summary>💡 Hint</summary>

It is a `git config` setting pointing at a file of your choice.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git config --global core.excludesFile ~/.gitignore_global
```

Then put your personal patterns in *~/.gitignore_global*, for example:

```
.DS_Store
*.swp
.idea/
.vscode/
```

</details>

## Check yourself

- [ ] Why must *.gitignore* itself be committed?
- [ ] Which command tells you which pattern is ignoring a given file?
- [ ] Why does adding a file to *.gitignore* not always stop Git reporting it?
- [ ] How do you get Git to track an empty directory?
- [ ] Where do you put patterns that concern your editor rather than the project?
