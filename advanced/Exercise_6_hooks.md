# Exercise 6 - Custom Git hooks

> [!NOTE]
> **⏱️ Estimated working time:** 15-20 minutes

A hook is a script Git runs automatically when something happens. Hooks let you enforce a rule
once instead of remembering it every time: reject trailing whitespace, run a formatter, check a
commit message, block a commit containing a password.

In this exercise you write a `pre-commit` hook, watch it stop a bad commit, then extend the
setup so several checks can run together.

> [!IMPORTANT]
> **Where you work:** `advanced_git/conference_planning`, specifically its *.git/hooks* directory.
> If you have not created the sandbox yet, follow the [Setup section](README.md#setup) first.

> [!NOTE]
> **Windows users:** if you use Git Bash, set
> `git config --global core.autocrlf input` before starting. Otherwise Git converts line endings
> to CRLF on checkout and the whitespace check below reports every line of every file as broken.

In this exercise we cover the following:
- [Look at what Git already gives you](#samples)
- [Write a pre-commit hook](#write)
- [Watch it reject a commit](#test)
- [Run several checks from one hook](#several)
- [Sharing hooks with your team](#sharing)

## Look at what Git already gives you <a name="samples"></a>

**Task 1.** List the contents of the hooks directory of your repository.

<details><summary>✅ Solution</summary>

```plaintext
ls .git/hooks
```

Git created a sample for every hook it supports: *pre-commit.sample*, *commit-msg.sample*,
*pre-push.sample* and a dozen more. They are inactive because of the `.sample` suffix - Git only
runs a file named exactly after the event.

</details>

**Task 2.** Read one of them to see what a real hook looks like.

<details><summary>✅ Solution</summary>

```plaintext
cat .git/hooks/pre-commit.sample
```

</details>

Two rules govern all hooks:

- The file must be named exactly after the event (`pre-commit`, no extension) and be **executable**.
- If a `pre-` hook exits with a **non-zero** status, Git **cancels** the operation.

## Write a pre-commit hook <a name="write"></a>

We will reject commits that introduce trailing whitespace: spaces or tabs at the end of a line.
They cause noisy diffs, and nobody ever adds them on purpose.

**Task 3.** Create the hook file and make it executable.

<details><summary>✅ Solution</summary>

```plaintext
touch .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

</details>

**Task 4.** Put the following script in it. This one is given to you in full, because getting
the check itself right is not the point of the exercise - understanding the structure is.

```bash
#!/bin/bash
#
# Reject commits that introduce trailing whitespace.

# Send our output to stderr so it is not mistaken for command output.
exec 1>&2

if ! git diff-index --check --cached HEAD --; then
    echo
    echo "Commit rejected: the staged changes introduce trailing whitespace."
    echo "Fix the lines listed above, stage them again, and retry."
    exit 1
fi
```

Read it before moving on and make sure you can answer:

- What does `--cached` mean here?
- What makes Git abort the commit?

<details><summary>Answers</summary>

`--cached` makes Git inspect the **staged** content, which is what is about to be committed,
rather than your working directory. `git diff-index --check` is a built-in whitespace checker
that returns non-zero when it finds a problem; `exit 1` then tells Git to abort.

</details>

## Watch it reject a commit <a name="test"></a>

**Task 5.** Add a line with trailing whitespace to *schedule_day1.txt*, stage it, and try to
commit. Predict what will happen first.

<details><summary>💡 Hint</summary>

`printf` lets you put trailing spaces in reliably, where an editor might strip them.

</details>

<details><summary>✅ Solution</summary>

```plaintext
printf '19:00-21:00: Conference dinner   \n' >> schedule_day1.txt
git add schedule_day1.txt
git commit -m "Add conference dinner"
```

The commit is refused and your message is printed. Nothing was committed.

</details>

**Task 6.** Fix the line, stage it again, and commit successfully.

<details><summary>✅ Solution</summary>

Remove the trailing spaces in your editor, or redo the line:

```plaintext
git restore --staged schedule_day1.txt
git restore schedule_day1.txt
printf '19:00-21:00: Conference dinner\n' >> schedule_day1.txt
git add schedule_day1.txt
git commit -m "Add conference dinner"
```

</details>

**Task 7.** Sometimes you genuinely need to commit anyway. Find the option that skips hooks.

<details><summary>💡 Hint</summary>

The flag means "no verify".

</details>

<details><summary>✅ Solution</summary>

```plaintext
git commit --no-verify -m "message"
```

Use it sparingly. A hook everyone routinely bypasses is worse than no hook, because it creates
the illusion of a check.

</details>

## Run several checks from one hook <a name="several"></a>

Git runs exactly **one** file per event. To have several checks, that one file has to call the
others.

**Task 8.** Rename your existing hook so it becomes one check among several.

<details><summary>✅ Solution</summary>

```plaintext
mv .git/hooks/pre-commit .git/hooks/pre-commit-whitespace
```

</details>

**Task 9.** Write a new *pre-commit* that acts as a dispatcher: it runs each check in turn and
fails if any of them fails. Make it executable.

<details><summary>💡 Hint</summary>

`set -e` makes a shell script stop at the first command that fails, which is exactly the
behavior you want.

</details>

<details><summary>✅ Solution</summary>

```plaintext
touch .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

with the content:

```bash
#!/bin/bash
#
# Dispatcher: runs each pre-commit check in turn.
# Any check that exits non-zero aborts the commit, because of set -e.

set -e

.git/hooks/pre-commit-whitespace
# Add further checks here, one per line.
```

</details>

**Task 10.** Add a second check of your own as *.git/hooks/pre-commit-nonempty*: reject a commit
whose message would be empty, or write something else useful. Wire it into the dispatcher and
verify both checks run.

<details><summary>💡 Hint</summary>

Keep it simple - for example, reject staged files larger than 1 MB, or reject the word `TODO` in
staged content. Do not forget `chmod +x`.

</details>

<details><summary>✅ Solution</summary>

An example that blocks accidentally committing a large file:

```bash
#!/bin/bash
#
# Reject staged files larger than 1 MB.

exec 1>&2
limit=1048576

for file in $(git diff --cached --name-only --diff-filter=ACM); do
    [ -f "$file" ] || continue
    size=$(wc -c < "$file")
    if [ "$size" -gt "$limit" ]; then
        echo "Commit rejected: $file is $size bytes, over the ${limit}-byte limit."
        echo "Consider git lfs, or keep the file out of the repository."
        exit 1
    fi
done
```

Then add `.git/hooks/pre-commit-nonempty` to the dispatcher and `chmod +x` it.

</details>

> [!TIP]
> A collection of ready-made hooks worth browsing:
> <https://github.com/CompSciLauren/awesome-git-hooks>

## Sharing hooks with your team <a name="sharing"></a>

Here is the catch that makes all of the above much less useful than it looks.

**Task 11.** Run `git status` in the repository. Do your hooks show up? Would a colleague who
clones this repository get them?

<details><summary>✅ Solution</summary>

No, and no. **`.git/hooks` is not part of the repository.** It is never committed, never pushed
and never cloned. Every person has to install hooks themselves.

</details>

There are two standard ways around this.

**Option A: a tracked hooks directory.** Put the hooks in a normal, committed folder and point
Git at it:

```plaintext
mkdir -p githooks
cp .git/hooks/pre-commit .git/hooks/pre-commit-whitespace githooks/
git add githooks
git commit -m "Add shared Git hooks"
git config core.hooksPath githooks
```

Now the hooks are versioned like any other file. Each person still has to run the
`git config core.hooksPath githooks` line once, but they no longer have to write anything.

**Option B: the `pre-commit` framework.** [pre-commit](https://pre-commit.com/) is a tool built
for this. You describe the checks in a committed *.pre-commit-config.yaml*, and it installs the
hook for you.

**Task 12.** Install the tool and set it up in this repository.

<details><summary>💡 Hint</summary>

It is a Python application. Install it as a *tool*, not into a project environment.

</details>

<details><summary>✅ Solution</summary>

```plaintext
uv tool install pre-commit
```

or, if you do not have `uv`:

```plaintext
pipx install pre-commit
```

Falling back to `pip install pre-commit` also works, but installing command-line tools with
`pip` mixes them into whichever environment happens to be active.

Verify:

```plaintext
pre-commit --version
```

</details>

**Task 13.** Create a *.pre-commit-config.yaml* using ready-made checks, install it, and run it.

<details><summary>✅ Solution</summary>

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v5.0.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-added-large-files
```

Then:

```plaintext
pre-commit install
pre-commit run --all-files
```

`pre-commit install` writes *.git/hooks/pre-commit* for you - note that this **overwrites** the
hook you wrote earlier.

</details>

> [!NOTE]
> `pre-commit run` on its own checks only the **staged** files, which is what happens at commit
> time. `pre-commit run --all-files` checks **every** file in the repository, which is what you
> want when adding the tool to an existing project or running it in CI.

## Check yourself

- [ ] What two things must be true of a file in *.git/hooks* for Git to run it?
- [ ] What does a `pre-` hook have to do to cancel the operation?
- [ ] How do you run several checks when Git only runs one file per event?
- [ ] Why do hooks not arrive with a `git clone`, and what are the two ways round it?
- [ ] What is the difference between `pre-commit run` and `pre-commit run --all-files`?

## Clean up

If you installed the `pre-commit` framework and want your own hooks back:

```plaintext
pre-commit uninstall
```
