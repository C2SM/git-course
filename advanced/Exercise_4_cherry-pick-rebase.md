# Exercise 4 - Moving commits with `git cherry-pick` and `git rebase`

Both commands take commits that exist in one place and replay them somewhere else.
`git cherry-pick` moves **one** commit; `git rebase` moves **a whole branch**. Both create new
commits with new IDs, which is what makes them powerful and what makes them dangerous.

In this exercise you use cherry-pick to rescue a single commit from a branch, then compare
merging and rebasing on the same starting point so you can see the difference in the history.

> [!IMPORTANT]
> **Where you work:** `advanced_git/conference_planning`.
> If you have not created the sandbox yet, follow the [Setup section](README.md#setup) first.
>
> This exercise makes a mess on purpose. If you lose the thread at any point, run
> `reset_advanced_repo` and start the section again.

> [!TIP]
> Keep a second terminal open running the graph view from Exercise 1. After every step, look at
> what changed:
> ```plaintext
> git log --oneline --graph --decorate --all
> ```

In this exercise we cover the following:
- [Build a feature branch](#feature)
- [Rescue one commit with `git cherry-pick`](#cherry)
- [Incorporate a branch by merging](#merge)
- [Incorporate a branch by rebasing](#rebase)
- [Compare the two histories](#compare)

## Build a feature branch <a name="feature"></a>

**Task 1.** Create a branch called `cherry_feature` and switch to it.

<details><summary>Solution</summary>

```plaintext
git switch -c cherry_feature
```

</details>

**Task 2.** Make three separate commits on this branch, each with a meaningful message:

1. Add a keynote speech from 08:00-09:00 to day 1.
2. Add an excursion from 13:30-15:00 to day 2.
3. Extend the coffee break on day 1 to half an hour.

Edit the files in your editor, or use the course helper `insert_after` if you prefer.

<details><summary>Hint</summary>

`insert_after '<pattern>' '<new line>' <file>` inserts a line after the first line matching the
pattern. It comes from *helpers.sh* and is not part of Git.

</details>

<details><summary>Solution</summary>

```plaintext
insert_after 'program' '08:00-09:00: Keynote speech' schedule_day1.txt
git commit -am "Add keynote speech to day 1"

insert_after 'program' '13:30-15:00: Excursion' schedule_day2.txt
git commit -am "Add excursion to day 2"
```

Then edit the coffee break line in *schedule_day1.txt* to read `11:00-11:30: Coffee break` and:

```plaintext
git commit -am "Extend the coffee break on day 1"
```

</details>

**Task 3.** Look at the history and note the commit ID of the **last** commit, the coffee break
one. You will need it in a moment.

<details><summary>Solution</summary>

```plaintext
git log --oneline --graph --decorate --all
```

</details>

## Rescue one commit with `git cherry-pick` <a name="cherry"></a>

Suppose the keynote and the excursion turned out to be bad ideas, but extending the coffee break
was right. You want that one change on `main`, and you want to abandon the rest.

**Task 4.** Switch to `main` and bring over **only** the coffee break commit.

<details><summary>Hint</summary>

`git cherry-pick <commit-id>`.

</details>

<details><summary>Solution</summary>

```plaintext
git switch main
git cherry-pick <commit-id-of-the-coffee-break-commit>
```

</details>

**Task 5.** Compare the commit on `main` with the original on `cherry_feature`. What is the same
and what is different?

<details><summary>Solution</summary>

```plaintext
git log --oneline --graph --decorate --all
```

The message and the change are identical, but the **commit ID is different**. It is a new commit
with the same content, not the same commit in two places.

</details>

**Task 6.** Check the schedule files. Did the keynote and the excursion come along?

<details><summary>Solution</summary>

```plaintext
cat schedule_day1.txt
cat schedule_day2.txt
```

No. Cherry-pick applies exactly the one commit you named, not the ones before it. This is the
whole difference from `git merge`, which would bring the entire branch.

</details>

> [!WARNING]
> Because the cherry-picked commit has a **new ID**, you should not later merge `cherry_feature`
> into `main`: the same change would arrive a second time, and depending on the content you may
> get a conflict for a change that is already there.
>
> Cherry-pick is for salvaging work from a branch you are **abandoning**. If the branch is still
> alive, merge it instead.

Delete the abandoned branch:

```plaintext
git branch -D cherry_feature
```

`-D` rather than `-d` because its commits were never merged, so Git would otherwise refuse.

## Incorporate a branch by merging <a name="merge"></a>

Now the same situation twice, once with merge and once with rebase, so you can compare.

**Task 7.** Make sure your working directory is clean, then create a branch `merge_feature` and
add a presentation session after the coffee break on day 2. Commit it.

<details><summary>Solution</summary>

```plaintext
git restore .
git switch -c merge_feature
insert_after 'Coffee' '11:15-12:30: Presentation session' schedule_day2.txt
git commit -am "Add presentation session to day 2"
```

</details>

**Task 8.** Meanwhile `main` moves on. Switch to `main` and add a dinner to day 2, then commit.
This is the crucial setup: both branches now have commits the other does not.

<details><summary>Solution</summary>

```plaintext
git switch main
insert_after 'Evening' 'Dinner' schedule_day2.txt
git commit -am "Add dinner to day 2"
```

</details>

**Task 9.** Bring the feature branch into `main` with a merge, then look at the history.

<details><summary>Solution</summary>

```plaintext
git merge merge_feature
git log --oneline --graph --decorate --all
```

Git created an extra **merge commit** with two parents, and the graph visibly forks and rejoins.
Both original commits are still there, unchanged, with their original IDs.

</details>

Tidy up:

```plaintext
git branch -d merge_feature
```

## Incorporate a branch by rebasing <a name="rebase"></a>

**Task 10.** Set up exactly the same situation again: a branch `rebase_feature` with a lunch
break added to day 2, and a new commit on `main` adding an apero.

<details><summary>Solution</summary>

```plaintext
git switch -c rebase_feature
insert_after 'Presentation' '12:30-13:30: Lunch break' schedule_day2.txt
git commit -am "Add lunch break to day 2"

git switch main
insert_after 'Dinner' 'Apero' schedule_day2.txt
git commit -am "Add apero to day 2"
```

</details>

**Task 11.** This time, instead of merging, **replay** the feature branch's commits on top of the
current `main`.

<details><summary>Hint</summary>

`git rebase <branch-to-replay-onto> <branch-to-move>`.

</details>

<details><summary>Solution</summary>

```plaintext
git rebase main rebase_feature
git log --oneline --graph --decorate --all
```

Git switched you to `rebase_feature` and rewrote its commit so that it now sits on top of the
apero commit. Note the commit ID: it has **changed**. The old commit is gone from the branch.

</details>

**Task 12.** Bring the rebased branch into `main` and look at the history again.

<details><summary>Solution</summary>

```plaintext
git switch main
git merge rebase_feature
git log --oneline --graph --decorate --all
```

Even though you ran `git merge`, no merge commit was created. Because `rebase_feature` was
already sitting directly on top of `main`, Git could simply move the branch pointer forward.
This is a **fast-forward** merge, and the history is a straight line.

</details>

```plaintext
git branch -d rebase_feature
```

## Compare the two histories <a name="compare"></a>

**Task 13.** Look at the full graph one last time and find both patterns in it.

```plaintext
git log --oneline --graph --decorate --all
```

The merge section forks and rejoins; the rebase section is a straight line. That is the entire
trade-off:

| | Merge | Rebase |
| --- | --- | --- |
| History | Shows exactly what happened, including the fork | Linear and easy to read |
| Commit IDs | Unchanged | Rewritten |
| Extra commits | One merge commit | None |
| Safe on a shared branch | **Yes** | **No** |

> [!WARNING]
> Rebasing **rewrites history**. Anyone who already pulled the old commits now has a version that
> disagrees with yours, and fixing that is painful for them, not for you.
>
> The rule: rebase your own branch before sharing it. Never rebase `main`, or any branch someone
> else is working on. If you rebase a branch you already pushed, you will need
> `git push --force-with-lease` - which checks nobody else pushed in the meantime, unlike the
> blunt `--force`.

## Check yourself

- [ ] Why does a cherry-picked commit get a new ID?
- [ ] When is cherry-pick the right tool, and when should you merge instead?
- [ ] What is a merge commit, and why did the rebase route not produce one?
- [ ] Which of the two rewrites history, and what does that mean for your colleagues?
- [ ] Why is `--force-with-lease` preferable to `--force`?
