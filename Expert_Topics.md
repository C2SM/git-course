# Expert Git topics

A collecting place for Git topics the C2SM courses do **not** cover, and a rough syllabus for a
possible third course.

Each entry says why it matters and names the commands to look up. This is a reading list, not a
tutorial - none of it is needed for the two existing courses.

**What is already covered:**

- **[Git: The Basics](beginner)** - `init`, `add`, `commit`, `status`, `log`, branches,
  `switch`, `restore`, merging and merge conflicts, `.gitignore`, remotes, `push`, `pull`,
  `fetch`, and a first pull request.
- **[Git: Beyond the Basics](beyond)** - `log`/`blame`/`diff`/`show` in depth, submodules,
  `.gitignore` in depth, `cherry-pick`, `rebase`, `stash`, `worktree`, hooks, `git lfs`, and the
  issue → fork → pull request → review workflow.

---

## Git internals

Understanding what Git actually stores turns most of its odd behavior into common sense.

- The object database: **blobs**, **trees**, **commits**, **tags** - four object types, all
  content-addressed by hash.
  `git hash-object`, `git cat-file -t`, `git cat-file -p`, `git ls-tree`
- Why identical content is stored once, no matter how many commits or branches contain it.
- The **index** (staging area) is a real file, `.git/index`, not an abstract idea.
  `git ls-files --stage`
- **References** are files containing a hash: `.git/refs/heads/main`, `.git/HEAD`, `packed-refs`.
  `git symbolic-ref`, `git update-ref`, `git rev-parse`
- **Packfiles** and delta compression, and why a fresh clone is smaller than your working copy.
  `git gc`, `git count-objects -vH`, `git verify-pack`
- The ongoing **SHA-1 to SHA-256** transition.

## Rewriting history

- **Interactive rebase** - the workhorse for tidying a branch before review.
  `git rebase -i`, with `pick`, `reword`, `edit`, `squash`, `fixup`, `drop`, `exec`
- Preparing fixes that squash themselves into the right commit.
  `git commit --fixup <commit>`, then `git rebase -i --autosquash`
- **Removing a file from all of history** - the only real answer when a password or a huge binary
  was committed. Note that the credential must still be rotated: it has been public.
  [`git filter-repo`](https://github.com/newren/git-filter-repo) (the modern replacement for
  `filter-branch`)
- Comparing two versions of a rewritten branch, which ordinary `diff` cannot do.
  `git range-diff`
- `git replace` for grafting history without rewriting it.

## Recovery: undoing almost anything

- **`git reflog`** - the local record of everywhere `HEAD` has been. Almost nothing is truly lost
  for 90 days, including commits dropped by a bad rebase or reset.
- `git reset --soft` / `--mixed` / `--hard`, and precisely what each one moves.
- `git restore` vs `git checkout` vs `git revert` - which change history and which do not.
- `git fsck --lost-found` for objects no reference points at any more.

## Debugging with history

- **`git bisect`** - binary search through history to find the commit that broke something.
  Manual (`git bisect start` / `good` / `bad`) and automated (`git bisect run <script>`, where the
  script exits 0 for good, 1-127 for bad, and 125 to skip). This used to be in the beyond course
  and is a strong candidate for a third part.
- `git blame -C -M` - follow lines through file renames and moves between files.
- `blame.ignoreRevsFile` - hide bulk reformatting commits from every blame.
- `git log -L :function:file` - the history of one function.
- `git log --follow` - history across a rename.

## Merging, in depth

- Merge strategies: `ort` (the modern default), `ours`, `theirs`, `subtree`.
- `git merge --squash`, `--no-ff`, `--ff-only`, and when a team should mandate each.
- **`merge.conflictStyle = zdiff3`** - shows the common ancestor alongside both sides of a
  conflict, which usually makes the right resolution obvious.
- **`git rerere`** ("reuse recorded resolution") - records how you resolved a conflict and
  replays it the next time the same one appears. Invaluable during a long rebase.
  `git config --global rerere.enabled true`
- Custom merge drivers via `.gitattributes`, for files where a line-based merge is meaningless.
- `git add -p` - stage part of a file, hunk by hunk.

## Large and long-lived repositories

- **`git sparse-checkout`** - check out only part of a large tree.
- **Partial clone** - fetch objects on demand instead of all at once.
  `git clone --filter=blob:none`, `--filter=tree:0`
- **`scalar clone`** - ships with Git and turns on a sensible set of large-repository features at
  once.
- **`git maintenance start`** - background repacking, commit-graph and prefetching.
- **`core.fsmonitor`** - a filesystem watcher, so `git status` does not stat every file.
- Shallow clones (`--depth`) and why CI usually wants them but you usually do not.

## Automation and trust

- **Server-side hooks**: `pre-receive`, `update`, `post-receive` - the only hooks a user cannot
  bypass with `--no-verify`.
- **Signed commits and tags** - GPG or, more simply, SSH signing with a key you already have.
  `git config gpg.format ssh`, `git commit -S`, `git tag -s`, `git log --show-signature`
- **`git notes`** - attach information to a commit after the fact without changing its hash.
- Releases: annotated tags, semantic versioning, and generating a changelog from commit messages.
- CI beyond a single job: matrix builds, reusable workflows, caching, and self-hosted runners.

## Collaboration at scale

- Branching models: **Git Flow**, **GitHub Flow**, **trunk-based development** - and honest
  trade-offs rather than dogma.
- Protected branches, required reviews, `CODEOWNERS`, and merge queues.
- **Conventional Commits** and what it buys you (automated changelogs, automated versioning).
- Monorepo versus many repositories; `git subtree` as an alternative to submodules.
- The **email patch workflow** still used by the Linux kernel and Git itself.
  `git format-patch`, `git send-email`, `git am`

## Configuration and ergonomics

- **Conditional includes** - a work identity in one directory tree and a personal one in another.
  ```
  [includeIf "gitdir:~/work/"]
      path = ~/.gitconfig-work
  ```
- Configuration scopes and their precedence: system, global, local, worktree.
  `git config --list --show-origin`
- `.gitattributes` beyond ignoring: end-of-line normalization, custom diff drivers for binary
  formats, `export-ignore`, `linguist-*` for language statistics.
- Credential helpers, and `gh auth login` as the simplest route on GitHub.
- Aliases that shell out: `git config --global alias.<name> '!<shell command>'`

## Where to read more

- [Pro Git](https://git-scm.com/book) - free, and chapters 7 and 10 cover most of the above.
- [Git reference documentation](https://git-scm.com/docs)
- [So You Think You Know Git](https://www.youtube.com/watch?v=aolI_Rz0ZqY) - a conference talk
  covering many of these in an hour.
- [Oh Shit, Git!?!](https://ohshitgit.com/) / [Dangit, Git!?!](https://dangitgit.com/) - recipes
  for getting out of trouble.
