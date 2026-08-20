# Exercise 8 - A full workflow in the web interface

> [!NOTE]
> **⏱️ Estimated working time:** 30-40 minutes

This is the exercise that pulls Part 2 together: an issue, a fork, a branch, a pull request,
automated checks, a review by one of your fellow participants, a merge, and finally keeping your
fork up to date.

You will work on <https://github.com/C2SM/c2sm-git-example>, a small repository of Markdown pages
about C2SM that exists purely so that people can practice on it. It is set up like the
[C2SM User Landing Page](https://github.com/C2SM/c2sm.github.io): issue templates, a pull request
template, and Actions that check every pull request.

> [!IMPORTANT]
> **Where you work:** in your browser, and in a clone of **your fork** placed anywhere *outside*
> `advanced_git` - for example next to the *git-course* directory. Do **not** put it inside
> another repository.

> [!NOTE]
> **Find a partner before you start.** Steps 5 and 6 require someone to review your pull request
> while you review theirs.

In this exercise we cover the following:
- [1. Open an issue](#issue)
- [2. Fork and clone](#fork)
- [3. Make your change on a branch](#branch)
- [4. Open a pull request](#pr)
- [5. Review your partner's pull request](#review)
- [6. Respond to your own review and merge](#merge)
- [7. Keep your fork in sync](#sync)
- [8. Handle a conflict](#conflict)
- [GitHub and GitLab](#gitlab)

## 1. Open an issue <a name="issue"></a>

Work starts with a description of what needs doing, not with code.

**Task 1.** On <https://github.com/C2SM/c2sm-git-example>, open the **Issues** tab and create a
new issue from the *Content request* template, saying that you would like to add yourself to the
participants list. Note the issue **number** - you need it later.

<details><summary>What makes a good issue?</summary>

- A title that reads as a statement of the problem, not "help" or "bug".
- Enough context that someone else could act on it without asking you.
- For a bug: what you did, what you expected, what actually happened.

Templates exist to prompt exactly this. That is why the repository has them.

</details>

## 2. Fork and clone <a name="fork"></a>

You have no write access to the C2SM repository, so you work on your own copy.

**Task 2.** Fork the repository, then clone **your fork** and go into it.

<details><summary>✅ Solution</summary>

Press **Fork** on the repository page, then:

```plaintext
git clone git@github.com:<your-github-username>/c2sm-git-example.git
cd c2sm-git-example
```

</details>

**Task 3.** Check which remotes your clone has. Which repository does `origin` point at, the
C2SM one or yours?

<details><summary>✅ Solution</summary>

```plaintext
git remote -v
```

`origin` is **your fork**. A clone only ever knows about the repository it came from; the
original is not configured yet. You add it in step 7.

</details>

## 3. Make your change on a branch <a name="branch"></a>

**Task 4.** Create a branch with a descriptive name, add a file `participants/<your-github-username>.md`
with a couple of lines about yourself, and commit it.

<details><summary>💡 Hint</summary>

`git switch -c <branch-name>`. Look at an existing file in *participants/* to see the expected
format.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git switch -c add-<your-github-username>
```

Create *participants/<your-github-username>.md* in your editor, then:

```plaintext
git add participants/<your-github-username>.md
git commit -m "Add <your name> to participants"
```

</details>

**Task 5.** Push the branch to your fork and set its upstream so later pushes need no arguments.

<details><summary>💡 Hint</summary>

The `-u` flag is needed only the first time a branch is pushed.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git push -u origin add-<your-github-username>
```

</details>

## 4. Open a pull request <a name="pr"></a>

**Task 6.** Open a pull request from your branch to `main` of **C2SM/c2sm-git-example**. In the
description, make GitHub close your issue automatically when the pull request merges.

<details><summary>💡 Hint</summary>

GitHub offers a banner with a **Compare & pull request** button after a push. The magic words in
the description are a closing keyword followed by the issue number.

</details>

<details><summary>✅ Solution</summary>

Write `Fixes #12` in the description, using your own issue number. The keywords `Fixes`, `Closes`
and `Resolves` all work. Check the issue afterwards: it now shows the pull request as linked.

</details>

**Task 7.** Watch the **checks** run at the bottom of the pull request. What are they checking,
and what happens to the merge button while they are running?

<details><summary>✅ Solution</summary>

The workflow in *.github/workflows/checks.yml* verifies that Markdown links resolve and that no
file has trailing whitespace. While they run the merge button is disabled; if a check fails the
pull request cannot be merged until you push a fix.

This is the real value: the check runs before a human spends time on the review.

</details>

**Task 8.** Request a review from your partner.

## 5. Review your partner's pull request <a name="review"></a>

**Task 9.** Open your partner's pull request and go to the **Files changed** tab. Leave at least
one comment on a specific line, and make at least one of your comments a **suggestion** that they
can apply with a single click.

<details><summary>💡 Hint</summary>

Use the `+` button on a line to comment. For a suggestion, use the ± button in the comment
toolbar, which inserts a fenced block labeled `suggestion`.

</details>

<details><summary>✅ Solution</summary>

A suggestion looks like this in the comment box:

````
```suggestion
This is the corrected line.
```
````

The author gets a **Commit suggestion** button that turns it into a commit without touching
their terminal.

</details>

**Task 10.** Finish the review by choosing one of **Comment**, **Approve** or **Request changes**.
What is the difference?

<details><summary>✅ Solution</summary>

- **Comment** - feedback with no verdict.
- **Approve** - you are happy for this to be merged.
- **Request changes** - this should not merge until something is addressed. On repositories with
  branch protection this actively blocks the merge.

</details>

> [!TIP]
> Review the change, never the person. "This line could be clearer" rather than "you wrote this
> badly", and ask questions when you do not understand rather than assuming a mistake.

## 6. Respond to your own review and merge <a name="merge"></a>

**Task 11.** Go back to your own pull request. Apply your partner's suggestion, and reply to their
comments. If they requested changes, push a fix and re-request review.

<details><summary>💡 Hint</summary>

If you commit a suggestion in the web interface, your local branch is now behind. Bring it up to
date with `git pull`.

</details>

**Task 12.** Once approved, merge it. Look at the three merge options offered and say what each
does.

<details><summary>✅ Solution</summary>

- **Create a merge commit** - keeps every commit on the branch plus a merge commit.
- **Squash and merge** - collapses the whole branch into one commit on `main`. Common default,
  because a branch's intermediate commits are rarely interesting later.
- **Rebase and merge** - replays the commits onto `main` with no merge commit.

After merging, delete the branch - the pull request preserves the history.

</details>

**Task 13.** Check your issue. What happened to it, and why?

<details><summary>✅ Solution</summary>

It closed itself, because of the `Fixes #N` keyword in the pull request description.

</details>

## 7. Keep your fork in sync <a name="sync"></a>

Other participants have been merging their changes. Your fork knows nothing about them.

**Task 14.** Add the original C2SM repository as a second remote, conventionally called
`upstream`.

<details><summary>✅ Solution</summary>

```plaintext
git remote add upstream git@github.com:C2SM/c2sm-git-example.git
git remote -v
```

You now have two remotes: `origin` (your fork, you can push) and `upstream` (the original, you
cannot).

</details>

**Task 15.** Fetch what has happened upstream and see how far behind you are, without changing
anything yet.

<details><summary>✅ Solution</summary>

```plaintext
git fetch upstream
git log --oneline HEAD..upstream/main
```

Every commit listed is one you do not have.

</details>

**Task 16.** Bring your local `main` up to date, then update your fork on GitHub too.

<details><summary>✅ Solution</summary>

```plaintext
git switch main
git merge upstream/main
git push origin main
```

</details>

> [!NOTE]
> GitHub also has a **Sync fork** button on your fork's page that does the same thing. It is
> convenient, but knowing the commands means you can do it on any host, including
> `gitlab.ethz.ch`, which has no such button.

> [!WARNING]
> You may see `git rebase upstream/main` recommended instead of `git merge`. It gives a cleaner
> history, but rewrites your commits, so a branch you already pushed then needs
> `git push --force-with-lease`. Use `--force-with-lease`, never a plain `--force`: it refuses to
> overwrite work somebody else pushed while you were not looking.

## 8. Handle a conflict <a name="conflict"></a>

The participants files never conflict, because everyone edits their own. A shared file is
different.

**Task 17.** On a new branch, add a term and its definition to *glossary.md*, in alphabetical
order. Push it and open a pull request.

<details><summary>✅ Solution</summary>

```plaintext
git switch -c glossary-<your-github-username>
```

Edit *glossary.md*, then:

```plaintext
git commit -am "Add a glossary entry"
git push -u origin glossary-<your-github-username>
```

</details>

**Task 18.** Wait until somebody else's glossary pull request is merged first. Your pull request
will now report a conflict. Resolve it locally.

<details><summary>💡 Hint</summary>

Get the new upstream `main`, merge it into your branch, fix the file, and push.

</details>

<details><summary>✅ Solution</summary>

```plaintext
git fetch upstream
git merge upstream/main
```

Git reports a conflict in *glossary.md*. Open it: both entries are there, wrapped in
`<<<<<<<`, `=======` and `>>>>>>>` markers. Keep **both** entries in the right alphabetical
order, delete the markers, then:

```plaintext
git add glossary.md
git commit
git push
```

The pull request updates itself and the conflict warning disappears.

</details>

If conflict markers are unfamiliar, the beginner course covers them in detail:
[Exercise 6 - Merge conflicts](../beginner/Exercise_6_merge_conflicts.md).

## GitHub and GitLab <a name="gitlab"></a>

C2SM works on both `github.com` and `gitlab.ethz.ch`. Everything you just did transfers; only the
names and the CI file change. **The local Git commands are identical.**

| Concept | GitHub | GitLab |
| --- | --- | --- |
| Proposed change | Pull request (PR) | **Merge request (MR)** |
| Close an issue automatically | `Fixes #12` / `Closes #12` | `Closes #12` |
| CI configuration | `.github/workflows/*.yml` | **`.gitlab-ci.yml`** |
| Sign-off on a change | Approve / request changes | **Approvals**, a required count |
| Static site hosting | GitHub Pages | GitLab Pages |
| Preview of a change | PR preview via an Action | Review Apps |
| Ownership rules | `CODEOWNERS` | `CODEOWNERS` |
| Update a fork | "Sync fork" button or `upstream` remote | `upstream` remote |
| Namespaces | User / organization | User / **group**, nestable |

## Check yourself

- [ ] Why start with an issue rather than going straight to a branch?
- [ ] What does `origin` point at after cloning a fork, and what is `upstream` for?
- [ ] Which keyword in a pull request description closes an issue on merge?
- [ ] What is the difference between approving and requesting changes?
- [ ] When would you choose "Squash and merge" over "Create a merge commit"?
- [ ] Why is `--force-with-lease` safer than `--force`?
