# Git: Next Steps

This folder contains the exercises for the C2SM workshop **Git: Next Steps**, the second course
in the C2SM Git Series. It follows on from [Git: First Steps](../beginner), and the only
knowledge it assumes is the everyday basics: `add`, `commit`, `push`, `pull` and `branch`.

The course has two parts:

- **Part 1 · Your Git Toolbox** — the commands that go beyond the basics: reading history,
  submodules, ignoring files, cherry-pick and rebase, stash and worktree, hooks, and large files.
- **Part 2 · Working Together on GitHub** — how a change actually travels from an idea to the
  `main` branch of a shared project: issues, forks, pull requests, checks and review.

The [slides](slides/slides_advanced.pdf) are built from [slides/slides.md](slides/slides.md).
Feel free to download the material and work through it on your own.

See the [Getting Started section](https://github.com/C2SM/git-course/#getting-started) for how to
install Git and the other tools.

## Setup <a name="setup"></a>

Most exercises use a small sandbox repository about planning a conference. A helper script
creates it for you.

First, clone the course repository if you have not already:

```plaintext
git clone git@github.com:C2SM/git-course git-course
cd git-course
```

Make sure new repositories get a `main` branch rather than the historical `master`:

```plaintext
git config --global init.defaultBranch main
```

Then load the helper functions and create the sandbox:

```plaintext
cd advanced
source helpers.sh
init_advanced_repo
```

> [!NOTE]
> The functions in [helpers.sh](helpers.sh) are written by C2SM and are **not** part of Git. They
> only exist to give you a repository with some history to practise on.
>
> - `init_advanced_repo` creates the sandbox and moves you into it.
> - `reset_advanced_repo` throws it away and recreates it from scratch. Use it whenever an
>   exercise goes sideways — that is what it is for.
> - `insert_after '<pattern>' '<text>' <file>` inserts a line after the first line matching the
>   pattern, and works the same on Linux, macOS and Git Bash.

## Where each exercise happens

This is the question that causes the most confusion, so here is the map. Everything lives
**next to** the *git-course* directory, never inside it:

```
<the folder containing git-course>/
├── git-course/                        ← Exercise 1
└── advanced_git/                      ← created by init_advanced_repo
    ├── conference_planning/           ← Exercises 3, 4, 5, 6, 7
    ├── conference_planning-feature/   ← you create this in Exercise 5
    └── conference_submodule/          ← Exercise 2
```

Exercise 8 happens in the browser plus a clone of your own fork, which can live anywhere outside
`advanced_git`.

| Exercise | Topic | Working directory |
| --- | --- | --- |
| [1](Exercise_1_examining-history.md) | `git log`, `git blame`, `git diff`, `git show` | `git-course` |
| [2](Exercise_2_submodules.md) | `git submodule` | `advanced_git/conference_submodule` |
| [3](Exercise_3_ignoring-files.md) | `.gitignore`, `.gitkeep` | `advanced_git/conference_planning` |
| [4](Exercise_4_cherry-pick-rebase.md) | `git cherry-pick`, `git rebase` | `advanced_git/conference_planning` |
| [5](Exercise_5_stash-worktree.md) | `git stash`, `git worktree` | `advanced_git/conference_planning` |
| [6](Exercise_6_hooks.md) | Custom Git hooks | `advanced_git/conference_planning` |
| [7](Exercise_7_git-lfs.md) | `git lfs` | `advanced_git/conference_planning` |
| [8](Exercise_8_web-workflow.md) | Issues, forks, pull requests, review | browser + a clone of your fork |

If you are ever unsure where you are, `pwd` tells you, and `git status` tells you which
repository you are in.

## How the exercises are written

Each exercise gives you a **goal** and a set of **tasks** rather than a list of commands to paste.
Where a command is not obvious, there is a **Hint** and a **Solution** you can unfold:

<details><summary>Solution</summary>

Like this. Try the task first — you will remember much more from a command you worked out
yourself.

</details>

Commands that are genuinely unguessable, or where a typo would be destructive, are always given
in full. Each exercise ends with a short **Check yourself** list so you can confirm you got the
point.

## Beyond this course

[Expert_Topics.md](../Expert_Topics.md) collects the Git topics these two parts deliberately
leave out — internals, history rewriting, recovery, large repositories, signing and more.
