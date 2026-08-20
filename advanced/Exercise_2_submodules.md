# Exercise 2 - Nesting repositories with `git submodule`

> [!NOTE]
> **⏱️ Estimated working time:** 20-25 minutes

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
> You need a **fork of <https://github.com/C2SM/c2sm-git-example>** for this exercise. You will
> use the same fork again in Exercise 8, so make it now if you have not already: open the
> repository in your browser and press **Fork**.
>
> Pushing to your fork requires an SSH key on your GitHub account. If you do not have one, follow
> [Adding a new SSH key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

In this exercise we cover the following:
- [Add a submodule](#add)
- [See how Git keeps the two repositories apart](#separate)
- [Push a change from the submodule](#push)
- [Pull a change into the submodule](#pull)
- [What a fresh clone looks like](#clone)

## Add a submodule <a name="add"></a>

We work on a copy so the sandbox stays usable for the later exercises. Go to the folder that
*contains* *conference_planning* (so you are not inside a repository) and copy it:

```plaintext
cd ~/<path>/advanced_git
cp -r conference_planning conference_submodule
cd conference_submodule
```

**Task 1.** Add your fork of *c2sm-git-example* as a submodule in a directory called
*c2sm-info*. Use the **SSH** address of *your fork*, not the C2SM original - you need to be able
to push to it later.

<details><summary>💡 Hint</summary>

The command is `git submodule add <url> <path>`. Get the URL from the green **Code** button on
your fork.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git submodule add git@github.com:<your-github-username>/c2sm-git-example.git c2sm-info
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

The output starts with the commit ID of *c2sm-git-example* that the parent points at. That single
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
> Notice also that `git status` in the submodule probably says you are on a **detached HEAD**.
> That is normal: the parent records a commit, not a branch, so Git checks out that exact commit.
> To make commits you first have to get onto a branch, which is the next task.

## Push a change from the submodule <a name="push"></a>

**Task 8.** Get onto the `main` branch inside the submodule, keeping the edit you made, then
commit it.

<details><summary>💡 Hint</summary>

`git switch main` moves you onto the branch. Your uncommitted change comes along.

</details>

<details><summary>✅ Solution</summary>

```plaintext
cd c2sm-info
git switch main
git commit -am "Add a glossary entry"
```

</details>

**Task 9.** Send that commit to your fork on GitHub, then check in the browser that it arrived.

<details><summary>✅ Solution</summary>

```plaintext
git push origin main
```

The submodule is an ordinary repository, so this is an ordinary push.

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

## Pull a change into the submodule <a name="pull"></a>

Now the other direction: someone else changes the sub-repository and you want that change.

**Task 11.** Go to your fork of *c2sm-git-example* on GitHub, edit *glossary.md* in the web
editor, and commit directly to `main`. This plays the part of a colleague's change.

**Task 12.** Back in your terminal, from the **parent** repository, bring that new commit into
the submodule.

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

**Task 13.** Record the new pointer in the parent.

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
```

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
