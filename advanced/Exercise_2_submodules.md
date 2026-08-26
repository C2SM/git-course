# Exercise 2 - Nesting repositories with `git submodule`

> [!NOTE]
> **⏱️ Estimated working time:** 15-18 minutes for the core tasks, plus 5-7 minutes more if you
> also do the ones marked **(Bonus)**.

A submodule lets one repository contain another one while both keep their own history. The
parent does not copy the files: it records **one exact commit** of the other repository. Many
C2SM models and tools are assembled this way.

In this exercise you add a submodule, watch how Git keeps the two repositories separate, and
move changes in both directions.

> [!IMPORTANT]
> **Where you work:** `advanced_git/conference_submodule`.
> This exercise needs the *conference_planning* sandbox. If you have not created it yet, follow
> the [Setup section](README.md#setup) first.

> [!NOTE]
> Everything in this exercise stays on your machine. A submodule needs a second repository to
> point at, so the helper script builds a small local one, *glossary-tool*, that plays the part
> of an external project you do not maintain yourself - the kind of thing a real submodule
> usually points at. Exercise 8 covers the real equivalent, working with a fork on GitHub.

In this exercise we cover the following:
- [Add a submodule](#add)
- [See how Git keeps the two repositories apart](#separate)
- [Push a change from the submodule](#push)
- [Pull a change into the submodule (Bonus)](#pull)
- [What a fresh clone looks like](#clone)

## Add a submodule <a name="add"></a>

We work on a copy so the sandbox stays usable for the later exercises. Go to the folder that
*contains* *conference_planning* (so you are not inside a repository). First create the local
stand-in repository the submodule will point at, then copy the sandbox:

```plaintext
cd ~/<path>/advanced_git
init_submodule_remote
cp -r conference_planning conference_submodule
cd conference_submodule
```

> [!NOTE]
> Modern Git refuses, by default, to let a submodule point at a plain filesystem path - a
> protection against malicious repositories that try to make you clone something local and
> sensitive. Real submodules point at `https://` or `git@` URLs, where this never comes up; ours
> points at a path on disk, so allow it once:
> ```plaintext
> git config --global protocol.file.allow always
> ```

**Task 1.** Add *glossary-tool* as a submodule in a directory called *c2sm-info*.

<details><summary>💡 Hint</summary>

The command is `git submodule add <url> <path>`. `init_submodule_remote` created the repository
at `~/<path>/advanced_git/glossary-tool.git` - use that path as the URL. A local filesystem path
works exactly like a GitHub URL here; Git does not care where a repository lives.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git submodule add ~/<path>/advanced_git/glossary-tool.git c2sm-info
```

</details>

**Task 2.** Look at what that did to the parent repository, then commit it.

<details><summary>💡 Hint</summary>

`git status` shows two new entries, already staged.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git status
git commit -m "Add the c2sm-info submodule"
```

Two things were added: the directory *c2sm-info*, and a new file *.gitmodules*.

</details>

**Task 3.** Read *.gitmodules* and explain what it stores.

<details><summary>✅ Solution</summary>

```plaintext
cat .gitmodules
```

It records the path the submodule lives at and the URL it came from. It is an ordinary tracked
file, which is how everyone who clones the parent learns where to fetch the submodule from.

</details>

**Task 4.** Find out **which commit** of the submodule the parent is currently recording.

<details><summary>💡 Hint</summary>

There is a `git submodule` subcommand for exactly this.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git submodule status
```

The output starts with the commit ID of *glossary-tool* that the parent points at. That single
ID is the entire link - the parent stores no file contents from the submodule.

</details>

## See how Git keeps the two repositories apart <a name="separate"></a>

**Task 5.** Make a change in the **parent**: add a lunch break to day 1 of the schedule. Open
*schedule_day1.txt* in an editor and add a line, then check `git status`.

<details><summary>💡 Hint</summary>

If you would rather not open an editor, the course helper does it portably:
`insert_after '^11:00' '12:00-13:00: Lunch break' schedule_day1.txt`

</details>

<details><summary>✅ Solution</summary>

```plaintext
git status
```

The modified *schedule_day1.txt* is listed as not staged for commit, exactly as usual.

</details>

**Task 6.** Now go **into** the submodule and check its status. Before you run it, predict what
you will see.

<details><summary>✅ Solution</summary>

```plaintext
cd c2sm-info
git status
```

Nothing. The submodule is a completely separate repository with its own staging area, its own
branches and its own history. The parent's modified file is invisible from here.

</details>

**Task 7.** Still inside the submodule, add a line to *glossary.md*. Then check the status
**both** inside the submodule and in the parent, and compare the two.

<details><summary>✅ Solution</summary>

```plaintext
git status
cd ..
git status
```

Inside: an ordinary modified file. In the parent: `modified: c2sm-info (modified content)`. The
parent can tell that *something* changed inside, but it tracks only the pointer, not the
contents.

</details>

> [!NOTE]
> Notice that `git status` in the submodule says `On branch main`. `git submodule add` leaves it
> there, because the commit it just recorded is that branch's tip. This will not stay true: every
> other way of putting a submodule at a specific commit - a fresh clone, or a plain
> `git submodule update` - checks out that exact commit and leaves you on a **detached HEAD**
> instead. You will see that for real in the last section of this exercise.

## Push a change from the submodule <a name="push"></a>

**Task 8.** Make sure the submodule is on the `main` branch, keeping the edit you made, then
commit it.

<details><summary>💡 Hint</summary>

`git switch main` is a no-op here, since `git submodule add` already left you on `main`. Get in
the habit anyway: it is not a no-op after a plain `git submodule update`, which always detaches
HEAD, as you will see later in this exercise.

</details>

<details><summary>✅ Solution</summary>

```plaintext
cd c2sm-info
git switch main
git commit -am "Add a glossary entry"
```

</details>

**Task 9.** Send that commit to `glossary-tool`, then check that it actually arrived there -
without going into the repository yourself.

<details><summary>💡 Hint</summary>

`git log` can point at any repository directly with `-C`, even one you are not currently inside.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git push origin main
git -C ~/<path>/advanced_git/glossary-tool.git log --oneline -3
```

The submodule is an ordinary repository, so the push is an ordinary push. `glossary-tool.git` is
what a GitHub fork would be in the real workflow: a repository elsewhere that now has the commit
too.

</details>

**Task 10.** The parent still points at the **old** commit. Update it and commit the new pointer.

<details><summary>💡 Hint</summary>

From the parent, stage the submodule directory itself as if it were a file.

</details>

<details><summary>✅ Solution</summary>

```plaintext
cd ..
git add c2sm-info
git commit -m "Update c2sm-info submodule"
git submodule status
```

The ID reported by `git submodule status` is now the commit you just pushed.

</details>

> [!WARNING]
> Task 9 before Task 10 is the order that matters. If you commit the new pointer in the parent
> but never push the submodule commit, everyone else gets a parent that points at a commit that
> exists only on your laptop. This is the single most common submodule mistake.

## Pull a change into the submodule (Bonus) <a name="pull"></a>

Now the other direction: someone else changes the sub-repository and you want that change.

**Task 11. (Bonus)** A colleague changes *glossary.md* directly on `main` of `glossary-tool` while
you are not looking. Run the helper to play their part:

```plaintext
commit_to_submodule_remote_by_colleague
```

> [!NOTE]
> Behind the scenes this only clones `glossary-tool.git` into a temporary directory, edits
> *glossary.md*, commits and pushes - exactly what a colleague would do from their own machine.
> The point is what you do next, in Task 12, not how the change got there.

**Task 12. (Bonus)** Back in your terminal, from the **parent** repository, bring that new commit
into the submodule.

<details><summary>💡 Hint</summary>

`git submodule update` has two options here: one says "look at the remote instead of the
recorded commit", the other says "merge it into the branch I am on".

</details>

<details><summary>✅ Solution</summary>

```plaintext
git submodule update --remote --merge
```

Without `--remote`, `git submodule update` does the opposite - it resets the submodule back to
the commit the parent has recorded. That is what you want after cloning, and not what you want
here.

</details>

**Task 13. (Bonus)** Record the new pointer in the parent.

<details><summary>✅ Solution</summary>

```plaintext
git add c2sm-info
git commit -m "Update c2sm-info to the latest commit"
```

</details>

## What a fresh clone looks like <a name="clone"></a>

This is the part that catches people out, so it is worth seeing once.

**Task 14.** Clone your *conference_submodule* repository into a new directory and look inside
the submodule folder.

<details><summary>✅ Solution</summary>

```plaintext
cd ..
git clone conference_submodule clone_test
ls clone_test/c2sm-info
```

The directory is **empty**. A plain `git clone` does not fetch submodule contents.

</details>

**Task 15.** Fix the clone you just made, then find the option that would have avoided the
problem in the first place.

<details><summary>✅ Solution</summary>

To fix an existing clone:

```plaintext
cd clone_test
git submodule update --init --recursive
ls c2sm-info
cd c2sm-info && git status && cd ..
```

The last `git status` says `HEAD detached at <commit>`. This is the detached HEAD promised
earlier: `git submodule update` checks out the exact commit the parent recorded, not a branch. If
you wanted to make commits here, you would `git switch main` first, exactly as in Task 8.

To get it right immediately:

```plaintext
git clone --recurse-submodules <url>
```

`--recursive` and `--recurse-submodules` matter when a submodule itself contains submodules,
which is common in model repositories.

</details>

Clean up the test clone when you are done:

```plaintext
cd ..
rm -rf clone_test
```

## Check yourself

- [ ] What exactly does the parent repository store about its submodule?
- [ ] Why does `git status` inside a submodule ignore changes in the parent?
- [ ] Which must you push first, the submodule commit or the parent's new pointer, and why?
- [ ] What is the difference between `git submodule update` and `git submodule update --remote`?
- [ ] What does someone who clones your repository normally have to do to get the submodule?
