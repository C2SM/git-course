# C2SM Git Courses

Two annual Git courses, run by [C2SM](https://c2sm.ethz.ch) as part of its technical training.

## Git: First Steps

The folder [beginner](beginner) contains the exercises for **Git: First Steps**, an introduction
to Git for people who have never used it. It covers the everyday commands: making commits,
working with branches, resolving merge conflicts, and pushing to a remote.

## Git: Next Steps

The folder [advanced](advanced) contains the exercises for **Git: Next Steps**. It picks up where
the first course leaves off and needs nothing more than those basics. It has two parts: the
commands beyond the basics (reading history, submodules, cherry-pick and rebase, stash and
worktree, hooks, large files), and how a change travels through a shared project on a web
interface (issues, forks, pull requests, review).

## Slides

Both decks are published at **<https://c2sm.github.io/git-course/>**, as HTML and as PDF.

The HTML decks carry the presenter notes: press `p` while a deck is open for the presenter
view, with the current slide, the next slide, the notes and a timer. The PDFs contain the
slides only.

The sources are [beginner/slides/slides.md](beginner/slides/slides.md) and
[advanced/slides/slides.md](advanced/slides/slides.md). To build a deck locally, run its
`build.sh` - it needs only Node.js and writes both the HTML and the PDF next to the source.
Pushing to `main` republishes the site.

## Beyond both courses

[Expert_Topics.md](Expert_Topics.md) collects the topics neither course covers - Git internals,
history rewriting, recovery, large repositories, signing - as a reading list.

## Getting Started

To follow either course on your computer, you need:

1. [Git](#1-installing-git-on-your-computer)
2. [An SSH key linked to your GitHub account](#2-creating-a-github-account-and-ssh-key)
3. [Git LFS](#3-installing-git-lfs) (only for Git: Next Steps)
4. [A final check](#4-final-check)

### 1. Installing Git on your Computer

The courses are taught in a terminal, so you need a shell where Git works.

> [!IMPORTANT]
> You need at least Git 2.28 (released 27 July 2020).
> Check yours with `git --version`.

**Linux:** follow [Install Git on Linux](https://github.com/git-guides/install-git#install-git-on-linux).

**macOS:** follow [Install Git on Mac](https://github.com/git-guides/install-git#install-git-on-mac).

**Windows:** install [Git for Windows](https://gitforwindows.org/). It includes **Git Bash**, a
terminal in which every command in these courses works, and Git LFS is already bundled. Git Bash
is all you need, and it is the quickest route.

<details>
<summary>Alternative for Windows users: WSL2</summary>
<br>

If you would rather have a full Linux environment on Windows - useful well beyond this course -
install the **Windows Subsystem for Linux 2** (WSL2). It gives you a real Linux terminal, better
compatibility with Linux-based workflows, and keeps your development environment separate from
Windows.

1. Enable WSL by following the [Microsoft instructions](https://learn.microsoft.com/en-us/windows/wsl/install).
2. Install a Linux distribution from the Microsoft Store. We recommend Ubuntu 24.04 LTS.
3. Open the Start menu, search for "Ubuntu" and launch it.
4. Follow the prompts to set a username and password.

Then follow the [Install Git on Linux](https://github.com/git-guides/install-git#install-git-on-linux)
instructions inside that environment.
</details>

### 2. Creating a GitHub Account and SSH key

A GitHub account lets you collaborate on shared projects and keep your own code in the cloud. An
SSH key connects your computer to that account, so you do not have to type a password on every
push, and it is considerably more secure.

Only the section under the corresponding heading in each link is relevant:

- [Create a GitHub account](https://github.com/signup) (if you do not have one)
- [Generate a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux#generating-a-new-ssh-key) (leave the passphrase empty)
- [Add the SSH key to your account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account?platform=linux#adding-a-new-ssh-key-to-your-account)

### 3. Installing Git LFS

Only needed for Exercise 7 of **Git: Next Steps**.

- **Windows:** already included in Git for Windows, nothing to do.
- **macOS:** `brew install git-lfs`
- **Debian / Ubuntu:** `sudo apt install git-lfs`
- **Others:** see <https://git-lfs.com>

Check with `git lfs version`.

### 4. Final Check

Confirm your setup from a terminal:

- Step 1: download [check_requirements.sh](https://github.com/C2SM/git-course/blob/main/check_requirements.sh).
```
curl -O https://raw.githubusercontent.com/C2SM/git-course/main/check_requirements.sh
```
- Step 2: make it executable.
```
chmod +x ./check_requirements.sh
```
- Step 3: run it.

#### Git: First Steps

```
./check_requirements.sh --beginner
```

#### Git: Next Steps

This also checks for Git LFS.

```
./check_requirements.sh
```

If every line reports success, you are ready.

**Have fun!**
