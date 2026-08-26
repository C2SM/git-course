# Exercise 5 - Parallel work with `git stash` and `git worktree`

> [!NOTE]
> **⏱️ Estimated working time:** 12-15 minutes for the core tasks, plus 4-6 minutes more if you
> also do the ones marked **(Bonus)**.

Both commands solve the same everyday problem: you are in the middle of something and need to be
somewhere else. `git stash` puts your unfinished work aside for a moment. `git worktree` gives
you a second directory so you never have to put it aside at all.

> [!IMPORTANT]
> **Where you work:** `advanced_git/conference_planning`, plus a second directory next to it that
> you create in the worktree section.
> If you have not created the sandbox yet, follow the [Setup section](README.md#setup) first.

In this exercise we cover the following:
- [Stash a change and get it back](#stash)
- [Stash untracked files too (Bonus)](#untracked)
- [Work on two branches at once with a worktree](#worktree)
- [Clean up worktrees](#cleanup)

## Stash a change and get it back <a name="stash"></a>

**Task 1.** Add a conference breakfast from 08:30-09:00 to day 1, but **do not commit it**. Then
confirm with `git status` that you have an unstaged change.

<details><summary>✅ Solution</summary>

```plaintext
insert_after 'Schedule for Day 1' '08:30-09:00: Breakfast' schedule_day1.txt
git status
```

</details>

Now imagine a colleague asks you to look at something on another branch. You are not ready to
commit this, but you do not want to throw it away either.

**Task 2.** Put the change aside, with a message describing it, and check that your working
directory is clean afterwards.

<details><summary>💡 Hint</summary>

`git stash push -m "<message>"`. You may see `git stash save` in older tutorials - it does the
same thing but has been deprecated since Git 2.16, so use `push`.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git stash push -m "Add breakfast to day 1"
git status
```

The working directory is clean and the change is nowhere in sight.

</details>

**Task 3.** Confirm the change still exists somewhere, and look at what it contains without
restoring it.

<details><summary>💡 Hint</summary>

There is a subcommand to list stashes and another to show one as a diff.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git stash list
git stash show -p stash@{0}
```

Stashes are a stack: `stash@{0}` is the most recent.

</details>

**Task 4.** Bring the change back and remove it from the stash in one step.

<details><summary>💡 Hint</summary>

Two options exist. One keeps the stash, the other discards it after applying.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git stash pop
git status
```

`git stash pop` applies and drops. `git stash apply` applies but keeps the stash, which is safer
when you want the same change on several branches.

</details>

## Stash untracked files too (Bonus) <a name="untracked"></a>

**Task 5. (Bonus)** Create a new file *venue_notes.txt* with some content. Stash your work again,
then check whether the new file was stashed.

<details><summary>✅ Solution</summary>

```plaintext
echo "Room A has no projector" > venue_notes.txt
git stash push -m "Work in progress"
ls
```

*venue_notes.txt* is **still there**. By default `git stash` only touches files Git already
tracks.

</details>

**Task 6. (Bonus)** Get the untracked file stashed as well.

<details><summary>💡 Hint</summary>

A short flag, the same letter used by `git clean` for the same concept.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git stash push -u -m "Work in progress including notes"
ls
```

Now it is gone too. Restore everything:

```plaintext
git stash pop
```

</details>

> [!NOTE]
> Two things worth remembering about stashes:
> - They are **local only**. A stash cannot be pushed, and it will not appear on any other
>   machine. Do not use one as a backup.
> - They are easy to forget. `git stash list` on a repository you have not touched for months is
>   often an unpleasant surprise.

Tidy up before the next section:

```plaintext
git stash list
```

If anything is left, drop it with `git stash drop`, then remove the notes file:

```plaintext
rm -f venue_notes.txt
git restore .
```

## Work on two branches at once with a worktree <a name="worktree"></a>

Stashing works, but it is disruptive: you can only ever be on one branch, and every switch churns
your whole working directory. If you compile anything, you also throw away the build.

A **worktree** is a second working directory backed by the *same* repository. Both share one
`.git`, so branches and commits are common to them, but each has its own checked-out files.

**Task 7.** From inside *conference_planning*, create a worktree in a sibling directory called
*conference_planning-feature*, checked out on a new branch called `feature`.

<details><summary>💡 Hint</summary>

`git worktree add <path> <branch>`. If the branch does not exist yet, add `-b` to create it.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git worktree add -b feature ../conference_planning-feature
```

</details>

**Task 8.** List the worktrees this repository has, and note which branch each one holds.

<details><summary>✅ Solution</summary>

```plaintext
git worktree list
```

Two entries: the original directory on `main`, and the new one on `feature`.

</details>

**Task 9.** Go into the new directory and confirm two things: that you are on the `feature`
branch, and that there is no `.git` **directory** there.

<details><summary>✅ Solution</summary>

```plaintext
cd ../conference_planning-feature
git branch --show-current
ls -a
```

`.git` here is a small **file**, not a directory. It contains a single line pointing back at the
real repository. That is why a worktree costs almost nothing.

</details>

**Task 10.** Make a commit here on `feature`, then go back to the original directory and check
whether the commit is visible from there.

<details><summary>✅ Solution</summary>

```plaintext
echo "Feature notes" > feature.txt
git add feature.txt
git commit -m "Add feature notes"

cd ../conference_planning
git log --oneline --graph --decorate --all
```

The commit is there. The two directories share one history - only the checked-out files differ.

</details>

**Task 11.** Try to check out the `feature` branch in the original directory. What happens?

<details><summary>✅ Solution</summary>

```plaintext
git switch feature
```

Git refuses: `fatal: 'feature' is already used by worktree at ...`. A branch can be checked out
in only one worktree at a time, which is exactly what stops the two directories from fighting
over it.

</details>

## Clean up worktrees <a name="cleanup"></a>

**Task 12.** Remove the worktree properly, then confirm it is gone from the list.

<details><summary>💡 Hint</summary>

There is a `git worktree` subcommand for removal. Deleting the directory with `rm -rf` leaves a
stale registration behind.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git worktree remove ../conference_planning-feature
git worktree list
```

</details>

**Task 13. (Bonus)** If someone *had* deleted the directory by hand, the registration would still
be there. Which command cleans up such leftovers?

<details><summary>✅ Solution</summary>

```plaintext
git worktree prune
```

</details>

> [!TIP]
> Worktrees are at their most useful when switching branches is expensive: a large compiled model,
> a slow test suite, or a big Python environment. You can build `main` in one directory while
> editing `feature` in another, and nothing has to be rebuilt when you look away.

## Check yourself

- [ ] What does `git stash push -u` do that `git stash push` does not?
- [ ] What is the difference between `git stash pop` and `git stash apply`?
- [ ] Can a colleague get at your stash? Why not?
- [ ] What is inside the `.git` entry of a worktree, and why is it not a directory?
- [ ] Why does Git refuse to check out the same branch in two worktrees?
- [ ] Which command do you use to remove a worktree, and why not `rm -rf`?
