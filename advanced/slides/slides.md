---
marp: true
theme: c2sm-dark
paginate: true
size: 16:9
footer: "C2SM, ETH Zurich · Git: Next Steps · 8 October 2026"
---

<!-- _class: title -->
<!-- _paginate: false -->
<!-- _footer: "" -->

# Git: Next Steps

C2SM Git Courses · 8 October 2026
Michael Jähn, Mikael Stellio, Alitzel Macías Infante

<!--
Welcome everyone and introduce the three of us.

Quick show of hands to calibrate the room: who uses Git daily, who only occasionally? Who has already worked with submodules, or opened a pull request?

Set expectations: this is a hands-on day. Roughly half the time is exercises, and we walk around to help. Nobody should sit stuck in silence.
-->

---

<style scoped>
section {font-size: 25px;}
</style>

# Outline

<div class="columns">
<div>

<div class="compact-lines">

### Part 1: Your Git Toolbox
- Examining history: `log`, `blame`, `diff`, `show`
- Nesting repositories with submodules
- Ignoring files
- `git cherry-pick` and `git rebase`
- `git stash` and `git worktree`
- Custom Git hooks
- Large files with `git lfs`
- Exercises 1 – 7

</div>

</div>
<div>

<div class="compact-lines">

### Part 2: Working Together on GitHub
- Why a shared workflow
- A real example: the C2SM User Landing Page
- Issues, forks and branches
- Pull requests, checks and review
- Keeping your fork in sync
- GitHub and GitLab side by side
- Exercise 8

</div>

</div>
</div>

<div class="note">

You only need the **Git basics** for this course: `add`, `commit`, `push`, `pull`, `branch`.

</div>

<!--
The day has two halves that feel quite different.

Part 1 is a toolbox: seven independent tools, each one a slide or two of theory followed immediately by an exercise. If somebody already knows one of them, the exercise is still worth doing as a warm-up.

Part 2 is one continuous story instead: how a group of people gets changes into a shared repository without stepping on each other.

Reassure the room about the prerequisites: if they can commit and push, they have everything they need. Nothing today builds on material they might have missed.
-->

---

<style scoped>
.schedule-list {
  font-size: 34px;
}
.schedule-list li {
  margin-block: 14px;
}
</style>

# Schedule

<div class="no-bullets schedule-list">

- **09:30 – 09:40** Welcome and overview
- **09:40 – 10:50** Part 1 · history, submodules, .gitignore → Exercises 1 – 3
- **10:50 – 11:10** Coffee break ☕
- **11:10 – 11:50** Part 1 · moving, parallel work → Exercises 4 – 5
- **11:50 – 12:30** Part 1 · hooks and large files → Exercises 6 – 7
- **12:30 – 13:30** Lunch break 🍽️
- **13:30 – 14:30** Part 2 · slides and live demonstration
- **14:30 – 15:00** Part 2 · Exercise 8 and wrap-up

</div>

<!--
Point at the two breaks so people can plan around them, and mention where the coffee and the toilets are.

Watch the clock against this slide during the day. The usual failure mode is spending too long on the first two topics and then rushing hooks and LFS. If we are running late by the coffee break, shorten the theory for stash and worktree rather than cutting an exercise.

Exercise 8 needs GitHub accounts and pairs, so flag now that they should sort out an account over lunch if they do not have one.
-->

---

<!-- _class: section -->

# Part 1:
# Your Git Toolbox

<!--
Framing for this half: everything here is a tool you reach for occasionally, not something you use every day. The goal is not to memorise the flags. The goal is to know that the tool exists and what problem it solves, so that months from now you remember "there was something for this" and can look it up.
-->

---

# Recap: the Local Workflow

![w:1000](images/local-workflow.svg)

- Everything up to `git commit` happens **on your machine**
- Only `git push` and `git fetch` talk to the server

<!--
Short recap, two minutes at most, but do not skip it: the rest of Part 1 assumes people can place a command in this picture.

Walk the diagram left to right once: working directory, staging area, local repository, remote.

The point worth repeating is that Git is not a client to a server. Commits are local and free. This is why stash, worktree and rebase can all work offline, and why a mistake before `push` costs nothing.
-->

---

# Examining History: Four Commands

<div class="no-bullets">
<div class="compact-lines">

- `git log`
  - which commits exist, by whom, and in what order

</div>

<div class="compact-lines">

- `git blame`
  - which commit last changed each **line** of a file

</div>

<div class="compact-lines">

- `git diff`
  - what changed between two points in the repository

</div>

<div class="compact-lines">

- `git show`
  - a single commit: message **and** its diff

</div>
</div>

<br>

Each takes many options. Exercise 1 explores the ones worth remembering.

<!--
Motivate this with the situation everybody recognises: you open a file, find a line that makes no sense, and want to know who wrote it and why.

The four commands answer four different questions. Say them as questions:
- log: what happened?
- blame: who last touched this line?
- diff: what is different between these two points?
- show: what exactly did this one commit do?

On blame, get ahead of the name: it is for understanding, not for finding someone to blame. The commit message it points you to is usually the real prize.
-->

---

<style scoped>
table {font-size: 20px;}
</style>

# `git log`: Shaping and Filtering

| Option | What it does |
| --- | --- |
| `--oneline` | one line per commit |
| `--graph --decorate --all` | the branch structure of the whole repository |
| `--stat` | which files each commit touched |
| `-3` | only the last three commits |
| `--author="Lauber"` | only commits by a given author |
| `-- path/to/file` | only commits touching that file |
| `-S "Have fun!"` | commits that **add or remove** that text |
| `-G "regex"` | commits whose diff matches a regular expression |

<div class="note">

Found a combination you like? Save it: `git config --global alias.lg "log --oneline --graph --decorate --all"`

</div>

<!--
Do not read the table out. Pick the two rows that earn their keep and let the exercise cover the rest.

The two worth demonstrating live:
- `--graph --decorate --all`, because it is the cheapest way to see the branch structure without any GUI.
- `-S`, the "pickaxe": it finds the commit that introduced or removed a string. This is how you track down when a magic constant or a stray debug line appeared, and almost nobody knows about it.

Mention the `--` before a path: it separates paths from branch names, which matters when a file and a branch share a name.

Push the alias tip. Nobody types the long form twice.
-->

---

# `git diff`: Choosing Two Points

<div class="no-bullets">
<div class="compact-lines">

- `git diff`
  - working directory vs. staging area

</div>

<div class="compact-lines">

- `git diff --staged`
  - staging area vs. last commit (what `git commit` would record)

</div>

<div class="compact-lines">

- `git diff main my-branch`
  - one branch against another

</div>

<div class="compact-lines">

- `git diff HEAD~10 HEAD~5 -- README.md`
  - two commits, restricted to one file

</div>
</div>

<br>

Hard to read in a terminal? Use `git difftool --tool-help` to see what your system offers, or the web interface: add `/compare` to any GitHub repository URL.

<!--
The single idea here: `git diff` always compares two points, and the only thing you ever change is which two.

The first two lines are the ones people get wrong. A plain `git diff` does not show what you already staged, which is why "git diff shows nothing" is a common confusion right after `git add`. `--staged` is the answer, and it is exactly the preview of what `git commit` will record.

Refer back to the recap diagram while saying this: each variant is an arrow between two boxes.

If you have a terminal open, show `git diff --stat` on a branch as a quick way to see the shape of a change before reading it.
-->

---

# Part 1 · Exercise 1

### `git log`, `git blame`, `git diff` and `git show`

<div class="note">

**Where you work:** the `git-course` repository itself - we examine its real history.
All exercises: <https://github.com/C2SM/git-course/tree/main/advanced>

</div>

<!--
First exercise, so spend a moment on logistics: where the exercise files are, that everything is read-only here, and that they should call one of us over rather than get stuck.

This one is read-only, which makes it a safe warm-up: nothing they type can break anything.

Around 15 minutes. Walk the room. Common stumbling block: quoting in `-S` and `--author`, especially on Windows shells.
-->

---

# Nesting Repositories

- **Why?**
  - **Modularity** - break a large project into pieces that stand alone
  - **Independent history** - each piece keeps its own commits and releases
  - **Collaboration** - separate teams own separate pieces

<br>

- **Two mechanisms**
  - **Submodules** - Git's built-in approach, and the one C2SM models use
  - **Subtrees** - an alternative that copies content into the parent instead

<!--
Start with the concrete case rather than the abstraction: a climate model that pulls in a shared physics package or an I/O library maintained by a different group. You want a specific, reproducible version of that dependency, and you do not want to copy its source into your repository.

Say plainly that we teach submodules because that is what C2SM code uses. If they work with ICON or similar, they will meet submodules whether they like them or not.

Subtrees get one sentence only: they exist, they copy content in instead of pointing at it, we are not covering them today.
-->

---

# A Submodule Is a Pointer to One Commit

![w:1000](images/submodule-pointer.svg)

The parent repository records **one exact commit** of the submodule, not "the latest".

<!--
This is the slide that makes submodules click, so slow down here.

The parent repository does not contain the submodule's files. It stores a path, a URL and one commit hash. That is all.

Consequences worth stating out loud, because every submodule surprise follows from them:
- Cloning the parent gives you an empty directory until you ask for the content.
- The pointer does not move on its own. A colleague pushing to the submodule changes nothing for you until someone advances the pointer and commits that.
- Advancing the pointer is itself a commit in the parent, which shows up in the parent's diff as a one-line hash change.

Ask the room whether anyone has seen a diff that is nothing but two hashes. That is this.
-->

---

# Working With Submodules

<div class="no-bullets">
<div class="compact-lines">

- `git submodule add <url> <path>`
  - adds the submodule and creates `.gitmodules`

</div>

<div class="compact-lines">

- `git clone --recurse-submodules`
  - clones the parent **and** fills in the submodules

</div>

<div class="compact-lines">

- `git submodule update --init`
  - fills them in after an ordinary `git clone`

</div>

<div class="compact-lines">

- `git submodule update --remote --merge`
  - moves the pointer forward to the submodule's latest commit

</div>
</div>

<div class="warning">

A plain `git clone` gives you **empty** submodule directories. This surprises everybody once.

</div>

<!--
Four commands, and honestly the middle two are the ones they need.

`--recurse-submodules` on clone is the habit worth forming. `update --init` is the rescue command for when they forgot, and `--init --recursive` handles submodules inside submodules, which does happen in model code.

Be explicit about the warning box: the build fails with a confusing "file not found" error, not with anything mentioning submodules. Once they have seen this once they will remember it forever.

Also mention `git status` inside a submodule showing a detached HEAD. That is expected, not broken: the parent checked out a commit, not a branch. If they want to make changes there, they have to check out a branch first.
-->

---

<style scoped>
section {font-size: 24px;}
</style>

# Submodules Divide Opinion

<div class="columns">
<div>

**In their favor**

- Built into Git, nothing to install
- The parent records an exact, reproducible commit
- The submodule stays a normal repository

</div>
<div>

**Against**

- Every clone needs an extra step
- Easy to commit a pointer you never pushed
- Detached `HEAD` inside the submodule confuses people
- Branch operations do not recurse by default

</div>
</div>

<div class="note">

C2SM models and tools use submodules a lot, so the cost is worth paying here. Learn the two or three commands that matter and the pain mostly disappears.

</div>

<!--
Be honest here rather than selling submodules. People who have been burned will respect it, and the ones who have not will be appropriately careful.

The failure worth calling out is the second bullet: you commit a submodule pointer to a commit that only exists on your machine, push the parent, and now nobody else can check it out. The rule that avoids it: push the submodule first, then the parent.

For reproducibility, the first column is genuinely strong. An exact commit hash for every dependency is what makes an old model run reproducible years later.

Keep this short if time is tight.
-->

---

# Part 1 · Exercise 2

### `git submodule`

<div class="note">

**Where you work:** `advanced_git/conference_submodule`
Everything stays local - the helper script builds a small stand-in repository to point the submodule at.

</div>

<!--
Emphasise that this is fully local: no GitHub account, no network. The helper script creates a small repository on disk to act as the submodule.

About 15 minutes.

What to watch for while walking around:
- People confused by the detached HEAD inside the submodule. Expected.
- People expecting `git status` in the parent to show changes made inside the submodule as file changes. It shows a modified pointer instead.
-->

---

# The `.gitignore` file

- Tell Git to leave alone what should never be committed
- Build products, binaries, editor droppings, secrets, large data
- Patterns live in a `.gitignore` file - commit it, so the everyone shares the same rules

```
*~
*.exe
netcdf-*
build/
!build/keep_this.sh
```

- Patterns are matched per directory; `!` re-includes something
- `git check-ignore -v <file>` tells you **which line** ignored a file

<!--
Frame it as a courtesy to collaborators: a repository full of build artefacts and editor backup files makes every diff and every `git status` harder to read.

Walk the example: the trailing slash on `build/` means directory only, and the `!` line re-includes one file from inside an ignored directory.

`check-ignore -v` is the slide's practical gift. When a file mysteriously will not be added, it prints the exact file and line number of the rule responsible. Much better than guessing.

Two things worth mentioning beyond the slide: github.com/github/gitignore has ready-made templates per language, and a personal global ignore file (`core.excludesFile`) is the right home for editor droppings, so you are not pushing your `.idea/` preferences into a shared file.

Secrets deserve a sentence: `.gitignore` prevents adding them, it does not remove one already committed. That needs history rewriting, and the credential must be rotated regardless.
-->

---

# Ignoring Files: the States

![w:1000](images/file-states.svg)

<div class="warning">

`.gitignore` only affects **untracked** files. A file already committed keeps being tracked until you run `git rm --cached <file>`.

</div>

<!--
This is the single most common .gitignore misunderstanding, so make it land.

Someone commits a large output file, realises the mistake, adds it to .gitignore, and is baffled that Git keeps reporting changes to it. The ignore rules are only consulted for files Git does not already track.

`git rm --cached <file>` untracks it while leaving the file on disk. Then the ignore rule takes effect, and the removal itself is a commit.

Add the caveat that this does not erase it from history. The file is still in every earlier commit, so for a large file the repository stays large, and for a secret it stays exposed.
-->

---

# `.gitkeep`

- Git tracks **files**, never directories
- An empty directory simply will not be committed
- Convention: put an empty `.gitkeep` file inside it and commit that

<div style="flex-grow: 1;"></div>

<div class="note">

**Note:** `.gitkeep` is a community convention, not a Git feature. The name has no special meaning - any file would do.

</div>

<!--
Quick slide, a minute or two.

The situation: a program expects `output/` or `logs/` to exist and crashes if it does not, but Git will not record an empty directory.

Stress that `.gitkeep` is pure convention. Git has no idea what the name means. `.gitignore` is a real feature; `.gitkeep` is just a file people agreed to name that way. Some projects use an empty `README` instead.

Neat combination worth showing: ignore the directory's contents but keep the directory itself, with `output/*` plus `!output/.gitkeep`.
-->

---

# Part 1 · Exercise 3

### `.gitignore` and `.gitkeep`

<div class="note">

**Where you work:** `advanced_git/conference_planning`
Stuck? `reset_advanced_repo` gives you a clean start at any time.

</div>

<!--
Point out `reset_advanced_repo` clearly, and say it works for every remaining exercise, not just this one. It removes the fear of experimenting.

About 15 minutes.

This is the last exercise before the coffee break, so if the room finishes early that is fine, and if some are still working they can carry on into the break.
-->

---

# `git cherry-pick`: One Commit, Copied

![w:750](images/cherry-pick.svg)

- Takes a single commit and replays it on your current branch
- The copy gets a **new commit ID** - same content, different identity

<div class="warning">

Because the ID differs, do not later merge the branch you picked from: you would get the same change twice.

</div>

<!--
Give the situation first: a bug fix sits on a long-running development branch and you need exactly that one fix on the release branch, without the other twenty commits that came with it.

Walk the diagram: one commit, copied onto the current branch.

The key insight is that a Git commit's identity is its hash, which covers the content *and* the parent and metadata. Same change, different parent, different hash. So Git sees the two as unrelated commits, not as one change in two places.

That is exactly why the warning matters: merge later and the change arrives a second time, usually as a conflict rather than a clean duplicate.

Mention that a cherry-pick can conflict, and that `git cherry-pick --abort` backs out cleanly.

If you take one thing away: cherry-pick is for exceptions. A workflow that needs it routinely usually wants a different branching model.
-->

---

# `git rebase`: an Alternative to `git merge`

<div class="columns">
<div>

**Merge** - keeps both histories, adds a merge commit

![w:420](images/merge.svg)

</div>
<div>

**Rebase** - replays your commits on top, no merge commit

![w:420](images/rebase.svg)

</div>
</div>

<div class="warning">

Rebasing **rewrites history**. Never rebase a branch other people have already pulled.

</div>

<!--
Compare the two diagrams side by side rather than explaining them in sequence.

Merge preserves what actually happened, at the cost of a merge commit and a history that forks and rejoins. Rebase produces a straight line that reads as if you had started from the current tip, at the cost of every commit being a new commit with a new hash.

Say clearly that neither is correct in general. It is a project convention, and teams argue about it. Ours matters less than being consistent.

The golden rule deserves emphasis: rebase only what is still private. Once someone else has pulled your branch, rebasing forces them into a painful recovery. The symptom is the branch "diverging" and a push being rejected, and then somebody reaches for `--force`.

Worth a mention: interactive rebase (`git rebase -i`) is how you tidy up local commits before opening a pull request. Squash the "fix typo" commits. This connects nicely to Part 2.
-->

---

# Part 1 · Exercise 4

### `git cherry-pick` and `git rebase`

<div class="note">

**Where you work:** `advanced_git/conference_planning`
Stuck? `reset_advanced_repo` gives you a clean start at any time.

</div>

<!--
Around 20 minutes. This is the most conceptually demanding exercise of the morning, so budget accordingly and expect more questions.

Encourage running `git log --oneline --graph --all` before and after each step. Seeing the hashes change is what makes rebase concrete.

Reassure them that a conflict during the exercise is not a mistake, it is part of the exercise. `--abort` and `reset_advanced_repo` are both safety nets.
-->

---

# `git stash`: Park Your Work

![w:900](images/stash.svg)

- For when you must switch branch or pull, but are not ready to commit
- `git stash push -m "message"`, then `git stash list`, then `git stash pop`
- `-u` also stashes untracked files
- Stashes are **local only** - they never reach a remote

<!--
The situation everybody has been in: half-finished work in the tree, and an urgent request to look at something on another branch.

Stash puts the changes aside and gives you a clean working directory. `pop` brings them back and drops the entry; `apply` brings them back and keeps it.

Practical warnings worth giving:
- Always use `-m` with a message. A list of "WIP on main" entries three weeks later is useless.
- `-u` for untracked files, because a brand new file is not stashed by default and people lose track of that.
- Stashes are local and invisible to everyone else. They are also easy to forget: a stash from six months ago probably no longer applies cleanly.

Honest advice: for anything you care about, a commit on a scratch branch is safer than a stash. Stash is for minutes, not for days.
-->

---

# `git worktree`: Several Branches at Once

![w:400](images/worktree.svg)

- Multiple working directories sharing **one** `.git`
- Cheaper than a second clone, and the configuration stays in one place
- Especially useful when switching branches means recompiling

`git worktree add ../conference_planning-feature feature`

<!--
This one lands well with a modelling audience, so make the case concretely: switching branches in a compiled model means a full rebuild. With a worktree you have two directories, each on its own branch, each with its own build, sharing one object database and one set of remotes.

It is much cheaper than a second clone: the history is stored once.

Rules worth stating:
- Two worktrees cannot have the same branch checked out.
- Remove them with `git worktree remove <path>`, not with `rm -rf`, otherwise you leave stale bookkeeping behind (recoverable with `git worktree prune`).
- `git worktree list` shows what you have.

This also pairs with the previous slide: a worktree is often the better answer to "I need to look at another branch right now" than a stash.
-->

---

# Part 1 · Exercise 5

### `git stash` and `git worktree`

<div class="note">

**Where you work:** `advanced_git/conference_planning`, plus the worktree it creates next to it.

</div>

<!--
About 15 minutes.

Remind them the worktree is created next to the repository, not inside it, so they should watch which directory their shell is in. That is the main source of confusion in this exercise.

If the room is ahead of schedule, this is a good moment to take questions before the break rather than starting hooks early.
-->

---

<!-- _class: section -->

# Coffee Break
# ☕

<!--
State the exact time we resume and stick to it.

Good moment to check the clock against the schedule slide and decide whether the afternoon needs trimming.

Also a good moment to catch anyone who has fallen behind and get them reset with `reset_advanced_repo` before the next block.
-->

---

# Custom Git Hooks

- Scripts Git runs automatically when a certain event happens
- Live in `.git/hooks`, named after their event, must be **executable**
- A non-zero exit status from a `pre-` hook **cancels** the operation
- `.git/hooks` is **not** part of the repository, so hooks are not shared by cloning
- Git ships `.sample` files for every hook - rename one to activate it

<div class="note">

Want hooks that everybody gets? Commit them to a folder and point Git at it with `git config core.hooksPath <folder>`, or use the [pre-commit](https://pre-commit.com/) framework.

</div>

<!--
Hooks are just scripts. Any language with a shebang works, not only shell.

Three things trip people up, and all three appear in the exercise:
- The file must be executable. A hook that is not executable is silently ignored, with no warning at all.
- The name must match the event exactly, with no extension. `pre-commit`, not `pre-commit.sh`.
- Exit status is the whole interface: zero lets the operation proceed, non-zero cancels it.

The sharing problem is the important structural point. `.git/` is not versioned, so a hook you write is yours alone. `core.hooksPath` pointing at a committed directory is the simple fix, and pre-commit is the tool most projects end up using.

Worth knowing: `git commit --no-verify` skips the hooks. Useful, and also the reason hooks are a convenience rather than a guarantee. Real enforcement belongs in CI, which is Part 2.
-->

---

# When Each Hook Fires

![w:1100](images/hooks-timeline.svg)

Typical uses: reject trailing whitespace, run a formatter, enforce a commit-message
format, block commits of secrets, run fast tests before a push.

<!--
Walk the timeline once, then narrow to the two that matter in practice: `pre-commit` and `pre-push`.

The design rule is speed. A `pre-commit` hook runs on every single commit, so it must finish in well under a second or people will start using `--no-verify` reflexively. Slow checks belong in `pre-push` or in CI.

If you want a live example, this course repository has a `pre-commit` hook in `.githooks/`. Showing a real one beats describing it.

Good realistic uses: block a commit that contains an API key, keep notebooks free of output cells, enforce a commit message convention.
-->

---

# Part 1 · Exercise 6

### Custom Git hooks

<div class="note">

**Where you work:** `advanced_git/conference_planning`
Everything happens in its `.git/hooks` directory.

</div>

<!--
About 20 minutes.

Predict the two failures out loud before they start, because both will happen: forgetting `chmod +x`, and saving the file as `pre-commit.sh`. Naming both now saves a lot of hands going up.

Remind them `.git/hooks` is hidden, so their editor may need to be told to show hidden files, or they can edit it from the terminal.
-->

---

# Large Files: `git lfs`

- Git stores a **full copy of every version** of every file
- That is perfect for text and terrible for a 500 MB NetCDF file
- Git Large File Storage keeps a tiny **pointer** in the repository and the real bytes elsewhere

![w:850](images/lfs-pointer.svg)

<!--
Explain why the problem exists rather than jumping to the tool. Git stores a complete snapshot of every version. For text that compresses beautifully, because successive versions share almost everything. For a binary NetCDF file, every version is a whole new incompressible copy, and the repository grows without bound.

And it never shrinks: `git clone` fetches the full history, so one 500 MB file committed once and deleted afterwards still costs everyone 500 MB forever.

LFS replaces the file in the repository with a small text pointer, roughly three lines, and stores the real bytes on a separate server. Checkout swaps the pointer for the content automatically through a filter.

This is a good moment to ask whether anyone has a repository that has become painfully slow to clone. The answer is usually a binary file somebody committed.
-->

---

# Using `git lfs`

<div class="no-bullets">
<div class="compact-lines">

- `git lfs install`
  - once per machine: registers the filters

</div>

<div class="compact-lines">

- `git lfs track "*.nc"`
  - records the pattern in `.gitattributes` - **commit that file**

</div>

<div class="compact-lines">

- `git lfs ls-files`
  - which files are handled by LFS

</div>
</div>

<div class="warning">

LFS is not free: hosts put quotas on storage and bandwidth, and rewriting LFS history is painful. Before reaching for it, ask whether the data belongs in a data archive instead.

</div>

<!--
Three commands. The one people forget is committing `.gitattributes`: without it, LFS is configured on your machine only and your colleagues commit the real bytes straight into the repository.

Also stress the ordering. Tracking is not retroactive. Files already committed normally stay in history as normal files, and fixing that means rewriting history for everyone.

Take the warning box seriously with this audience. GitHub's free LFS quota is small, bandwidth counts too, and for scientific data an archive with a DOI is usually the better answer than a Git repository. LFS suits things like reference figures, test fixtures and small binary assets that genuinely belong next to the code.
-->

---

# Part 1 · Exercise 7

### `git lfs`

<div class="note">

**Where you work:** `advanced_git/conference_planning`
Entirely local - no remote and no LFS quota needed.

</div>

<!--
About 15 minutes, and it can be shortened if we are behind schedule.

Fully local, so no quota is consumed and no account is needed.

The satisfying moment is `cat` on a tracked file inside a bare clone and seeing the three-line pointer instead of the content. Point people towards that if they finish early.

This closes Part 1. Before moving on, ask whether anything from the morning needs revisiting.
-->

---

<!-- _class: section -->

# Part 2:
# Working Together on GitHub

<!--
Change of gear: Part 1 was individual tools, Part 2 is one continuous story about a group of people sharing a repository.

Set up the arc: an issue, a fork, a branch, a pull request, automated checks, a review, a merge, and keeping the fork in sync afterwards. We will follow that path on a real C2SM repository, then they will do it themselves in Exercise 8.

Worth saying up front: no new Git commands here. Everything is a convention built on what they already know.
-->

---

# Why a Shared Workflow?

Three problems appear the moment a second person joins:

<div class="compact-lines">

- **Access** - nobody can push to a protected `main`, so "just push it" is not an option
- **Traceability** - a change needs a visible record of *why*, not only *what*
- **Review** - somebody should look at a change **before** it reaches everyone else

</div>

<br>

A web interface solves all three with the same object: the **pull request**.

<div class="note">

The Git commands you already know do not change. What follows is a convention layered on top of them.

</div>

<!--
Motivate this from failure rather than from process. A solo repository needs none of this. Add a second person and you get overwritten work, changes nobody can explain six months later, and a broken `main` that blocks everybody.

Traceability is the one this audience underrates. In research code the question "why is this coefficient 0.7?" arrives years later, often from a reviewer. A pull request thread answers it; a commit message rarely does.

The nice part is that one object solves all three at once.

Repeat the note: nothing they learned this morning becomes obsolete.
-->

---

# A Real Example: the C2SM User Landing Page

<https://github.com/C2SM/c2sm.github.io> → <https://c2sm.github.io>

<div class="compact-lines">

- Documentation for models, tools, datasets and HPC systems used across C2SM
- Written as plain Markdown, built into a website automatically
- Maintained by the core team, but **anyone in the group can contribute**
- Every pull request gets a **preview website** before anything is merged

</div>

<br>

We will walk through a real change to this repository, then you will practice the same
workflow on <https://github.com/C2SM/c2sm-git-example>.

<!--
Using a real repository matters: this is not a toy example, it is a site they may well have used already.

If the room does not know it, open the site briefly. Many of them are the target audience for this documentation.

Make the invitation explicit: if they spot something outdated or missing, the workflow we are about to describe is exactly how they fix it. Several useful contributions have come from course participants.

The preview website is the feature that makes contribution comfortable, so foreshadow it here and return to it on the automated-checks slide.
-->

---

# It Starts With an Issue

- An issue describes **what is wrong or missing, and why** - before any code is written
- It is the place to agree on an approach before someone spends a day on it
- Labels, assignees and milestones make a backlog searchable months later

<br>

- Write `Fixes #12` in a pull request description and GitHub **closes issue 12 automatically** when it merges

<div class="note">

A good issue is reproducible: what you did, what you expected, what happened instead.

</div>

<!--
The argument for issues is cost. Ten minutes of discussion before the work is much cheaper than a day of work followed by "actually, we want this differently".

An issue is also fine as a question or a proposal. It does not have to be a bug.

The `Fixes #12` keyword is the practical detail: GitHub links the pull request to the issue immediately and closes the issue on merge, so the backlog stays honest without anyone tidying it.

The reproducibility note is the difference between an issue someone can act on and one that sits untouched for a year. What you did, what you expected, what happened instead, and enough context to reproduce it.
-->

---

# Fork and Branch

![w:1000](images/fork-triangle.svg)

**Fork** when you cannot push to the original. **Branch** when you can. Either way the change arrives as a pull request.

<!--
Keep this simple, because the fork/branch distinction confuses people more than it should.

A fork is your own copy of the repository on the server. A branch is a line of development, and it exists in both cases. The only question a fork answers is where your branch lives, and that is decided purely by whether you have write access.

Walk the triangle: upstream, your fork, your local clone. Then name the two remotes, because this is where confusion starts: `origin` is your fork, `upstream` is the original. `git remote -v` shows which is which.

Note for this audience: as C2SM members they often *do* have write access, so branching directly is the common case. The exercise uses a fork deliberately, so they see the harder path.
-->

---

# The Pull Request

<div class="compact-lines">

- A request to merge one branch into another, plus the conversation around it
- The **description** is the lasting record - say why, not just what
- Open it **early** as a draft to show work in progress
- Keep it small: a reviewer reads 200 lines carefully and 2000 lines not at all

</div>

![w:1050](images/pr-lifecycle.svg)

<!--
The name is slightly misleading: a pull request is a branch plus a conversation, not a Git operation. Nothing is copied when you open one, and you can keep pushing to the branch afterwards.

Two pieces of advice are worth more than the mechanics:

The description is the part that survives. The diff shows what changed; only the description explains why. Six months later that is the only record, and it is what someone reads when deciding whether a change can be reverted.

Size genuinely determines review quality. Be blunt about the 200 versus 2000 line comparison, because everyone recognises the experience of skimming a huge diff and approving it out of politeness.

Drafts are underused: open one on day one, and reviewers can steer the approach before the work is finished.
-->

---

# Automated Checks

- GitHub Actions run on every pull request, before a human looks at it
- On the landing page repository they check that Markdown links resolve and that the site still builds
- A failing check blocks the merge, so broken changes never reach `main`

<br>

- The same workflow deploys a **preview of the website for that pull request**:
  `https://c2sm.github.io/pr-preview/pr-<number>/`

<div class="note">

Reviewers can look at the rendered page, not just the diff. This is the single biggest reason the landing-page workflow works well.

</div>

<!--
Framing: automated checks handle everything a machine can judge, so the human reviewer can spend attention on what only a human can judge.

This also removes a whole category of awkward review comments. Nobody has to tell a colleague their indentation is wrong when a formatter says it first.

The preview deployment is the part worth showing live if the network cooperates. Reviewing a documentation change as rendered pages rather than as a Markdown diff is a completely different experience, and it is why non-programmers contribute to that repository comfortably.

Connect back to hooks from this morning: same idea of automated checks, but running on the server where they cannot be skipped with `--no-verify`. Hooks are a fast local convenience, CI is the actual guarantee.

Tie-in worth mentioning: these very slides are built by a GitHub Actions workflow in this repository.
-->

---

# Code Review

<div class="columns">
<div>

**As the author**

- Small, focused changes
- Explain the reasoning
- Reply to every comment
- Push fixes as new commits

</div>
<div>

**As the reviewer**

- Comment, approve, or request changes
- Use **suggestions** - the author can apply them with one click
- Ask questions instead of issuing orders
- Approve when it is good enough, not perfect

</div>
</div>

<div class="note">

Review is about the change, never the person. "This function could be clearer" beats "you wrote this badly".

</div>

<!--
This is the slide with the most cultural content, and it matters most for people who have never been reviewed before. Being reviewed feels exposing the first time, and saying so openly helps.

For authors: push fixes as new commits rather than amending and force-pushing, so the reviewer can see what changed since they last looked. Tidy up later if the project squashes on merge.

For reviewers: the suggestion feature is worth demonstrating, since it turns a comment into a one-click commit. And "good enough, not perfect" prevents the common failure of a pull request sitting for three weeks over stylistic preferences.

Asking questions rather than issuing orders is not just politeness. "What happens if this is empty?" often reveals that the author had a reason you had not considered.

If there is a story from a real C2SM review that illustrates the point, this is the place for it.
-->

---

# Merging, and Staying in Sync

- **Merge commit** - keeps every commit and records the merge
- **Squash** - collapses the branch into one tidy commit (a common default)
- **Rebase** - replays commits with no merge commit
- Delete the branch afterwards; the pull request keeps the history

![w:620](images/fork-sync.svg)

<!--
Point out that these three buttons are exactly merge, squash and rebase from this morning, now with a graphical interface. Nothing new to learn.

Squash is the common default because a branch's twelve commits, half of them "fix typo", are rarely worth keeping in the main history.

Deleting the branch afterwards is safe and people hesitate over it. The commits are in `main`, and the pull request page preserves everything, including the branch, which GitHub can restore.

The sync half of the slide is the part people actually get stuck on. After the merge, their fork's `main` is behind. Either use the "Sync fork" button on the web page, or locally: fetch from `upstream`, merge or rebase into their `main`, push to `origin`.

Recommend starting every new piece of work from a freshly synced `main`. It avoids most conflicts before they exist.
-->

---

<style scoped>
table {font-size: 19px;}
section {font-size: 22px;}
</style>

# GitHub and GitLab Side by Side

C2SM works on both `github.com` and `gitlab.ethz.ch`. The **local Git commands are identical** - only the website and the CI file differ.

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

<!--
This slide exists because ETH hosts GitLab and many of them will use both. Do not read the table; make the one point that matters and move on.

That point: the concepts map one to one, and the local Git commands are identical. Learning one platform means you know both. The vocabulary differs and the CI file has a different name and syntax.

The single most confusing difference is the name: merge request and pull request are the same thing.

Worth mentioning if anyone asks: GitLab groups nest, which is why ETH GitLab paths often have several levels, and GitLab approvals can be configured as a required count, which GitHub expresses through branch protection rules.
-->

---

<!-- _class: section -->

# Live Demonstration
<https://github.com/C2SM/c2sm.github.io>

<!--
Do the whole cycle live: open an issue, fork or branch, make a small edit, commit, open a pull request referencing the issue, let the checks run, look at the preview deployment, review it, merge, delete the branch, sync the fork.

Have the repository and a browser already open and logged in. Narrate what you are clicking, and keep the browser zoom high enough to read from the back.

The checks take a couple of minutes. Fill that time with questions rather than watching a spinner.

If the network fails, fall back to describing the pull request lifecycle diagram from the earlier slide and go straight to the exercise.
-->

---

# Part 2 · Exercise 8

### An issue, a fork, a pull request and a review

<div class="note">

**Where you work:** <https://github.com/C2SM/c2sm-git-example> in the browser, plus a clone of
your fork anywhere outside `advanced_git`.

</div>

You will review each other's pull requests, so **work in pairs**.

<!--
Organise the pairs before explaining anything else, and make sure nobody is left without a partner. Anyone still lacking a GitHub account needs one now.

About 30 minutes, and it is the exercise most likely to overrun.

Two logistics points to state clearly:
- Clone the fork somewhere outside `advanced_git`, so it does not collide with the morning's practice repositories.
- They will need to authenticate when pushing. If anyone has neither an SSH key nor a token set up, that is the first thing to sort out.

The review half is the part people skip when time runs short, so protect it: leaving a real comment on a colleague's pull request is the whole point of pairing.
-->

---

# Useful Tools

<div class="columns">
<div>
<div class="compact-lines">

**In your editor**
- [VS Code](https://code.visualstudio.com/) - built-in Git, GitLens
- [magit](https://magit.vc/) (Emacs)
- [vim-fugitive](https://github.com/tpope/vim-fugitive) (Vim)
- [JetBrains IDEs](https://www.jetbrains.com/)

</div>
<br>
<div class="compact-lines">

**Better diffs**
- [delta](https://github.com/dandavison/delta)
- [difftastic](https://difftastic.wilfred.me.uk/)

</div>

</div>
<div>

<div class="compact-lines">

**In the terminal**
- [gh](https://cli.github.com/) - pull requests and issues from the shell
- [lazygit](https://github.com/jesseduffield/lazygit) - terminal interface
- [tig](https://jonas.github.io/tig/) - history browser

</div>
<br>
<div class="compact-lines">

**Graphical**
- [GitHub Desktop](https://desktop.github.com/)
- [Git GUIs](https://git-scm.com/downloads/guis) - a long list

</div>

</div>
</div>

<!--
Do not go through the list. Say that we taught the command line because it is what exists everywhere and what error messages and documentation assume, and that using a graphical tool day to day is entirely fine once the concepts are clear.

Pick two or three favourites and say why in one sentence each. Honest personal recommendations are more useful than a complete catalogue.

Two worth singling out for this audience: GitLens in VS Code puts blame information inline as you read code, which is the morning's `git blame` without the terminal. And `delta` makes terminal diffs genuinely readable, which is a small change with a large daily payoff.

The slide is a reference for later, not something to work through now.
-->

---

# Where to Look Things Up

<div class="compact-lines">

- The Git book, free and genuinely good: <https://git-scm.com/book>
- Git reference: <https://git-scm.com/docs>
- GitHub documentation: <https://docs.github.com>
- GitHub cheat sheet: <https://education.github.com/git-cheat-sheet-education.pdf>
- When something has gone wrong: <https://dangitgit.com>
- Topics beyond this course: [Expert_Topics.md](https://github.com/C2SM/git-course/blob/main/Expert_Topics.md)

</div>

<div class="warning">

Language models are often useful for Git because the documentation is so good. They also invent flags that do not exist. Check `git help <command>` before running anything you do not recognize - especially anything with `--force`.

</div>

<!--
Pro Git is free, online, and better than most paid books. The first three chapters cover everything from the beginner course; chapter 7 covers most of this morning.

dangitgit.com deserves a real mention: it is organised by the situation you are in rather than by command, which is exactly how you search when something has gone wrong at five in the afternoon.

Take the warning box seriously and do not soften it. Language models are genuinely good at Git because the documentation they trained on is excellent, but they confidently invent flags. The habit to instil is checking `git help` before running anything unfamiliar, and being especially careful with `--force`, `reset --hard` and `clean -fd`, which are the commands that actually destroy work.

Add the reassuring counterpoint: almost anything committed can be recovered, often through `git reflog`. What is not committed cannot.
-->

---

# References

<div class="compact-lines">

- Chacon, S. & Straub, B. *Pro Git*, 2nd ed. Apress, 2014. <https://git-scm.com/book>
- Git Project. *Git Reference Documentation* - `git-log`, `git-diff`, `git-submodule`, `git-cherry-pick`, `git-rebase`, `git-stash`, `git-worktree`, `githooks`. <https://git-scm.com/docs>
- Git LFS Project. *Git Large File Storage Documentation*. <https://git-lfs.com>
- pre-commit. *A Framework for Managing Multi-Language Pre-Commit Hooks*. <https://pre-commit.com>
- GitHub, Inc. *GitHub Docs*. <https://docs.github.com>
- GitLab B.V. *GitLab Docs*. <https://docs.gitlab.com>
- C2SM. *c2sm.github.io* - the User Landing Page used as the worked example. <https://github.com/C2SM/c2sm.github.io>

</div>

<!--
Do not present this slide. It is there so the deck stands on its own as a document and so sources are properly credited.

Skip past it in the room, or use it as a two-second bridge to the closing slide.
-->

---

<!-- _class: section -->

# Questions? Comments?

<!--
Leave this up for the remaining time.

Before opening the floor, close the loop: mention the feedback form, where the slides and exercises stay available, and that they can open an issue on the course repository if they find a mistake, which is a nice application of what they just learned.

If the room is quiet, seed it with a question of our own: which tool from today they expect to use first, or whether their group already has a review convention. That usually gets the discussion started.

Thank them, and mention the next course in the series if the date is known.
-->
