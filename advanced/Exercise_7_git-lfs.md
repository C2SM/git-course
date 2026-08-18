# Exercise 7 - Large files with `git lfs`

Git keeps a complete copy of every version of every file forever. For text that is cheap, because
Git stores the differences efficiently. For a 500 MB NetCDF file it is a disaster: change it ten
times and your repository is 5 GB, and every colleague downloads all of it on `git clone`.

Git Large File Storage (LFS) replaces such files in the repository with a small **pointer** and
keeps the real bytes in a separate store. This exercise is entirely local, so you need no server
and no storage quota.

> [!IMPORTANT]
> **Where you work:** `advanced_git/conference_planning`.
> If you have not created the sandbox yet, follow the [Setup section](README.md#setup) first.

> [!NOTE]
> **`git lfs` is a separate program**, not part of Git. Check that you have it:
> ```plaintext
> git lfs version
> ```
> If not: it ships with **Git for Windows** already; on macOS `brew install git-lfs`; on Debian
> or Ubuntu `sudo apt install git-lfs`. See <https://git-lfs.com> for other systems.

In this exercise we cover the following:
- [Turn LFS on](#install)
- [Track a file pattern](#track)
- [See what actually gets committed](#pointer)
- [Inspect what LFS manages](#inspect)
- [Decide whether you need LFS at all](#decide)

## Turn LFS on <a name="install"></a>

**Task 1.** Register the LFS filters with Git. This is a one-off per machine, not per repository.

<details><summary>Solution</summary>

```plaintext
git lfs install
```

It reports `Git LFS initialized.` What it did was add a few `filter.lfs.*` entries to your global
Git configuration. Have a look:

```plaintext
git config --global --get-regexp filter.lfs
```

</details>

## Track a file pattern <a name="track"></a>

**Task 2.** Tell LFS to handle every file ending in `.nc` (the NetCDF extension used across
climate modelling).

<details><summary>Hint</summary>

`git lfs track "<pattern>"`. Keep the quotes, or your shell will expand the `*` before Git sees
it.

</details>

<details><summary>Solution</summary>

```plaintext
git lfs track "*.nc"
```

</details>

**Task 3.** That command changed a file. Find out which one, read it, and explain what it says.

<details><summary>Hint</summary>

`git status` will show you.

</details>

<details><summary>Solution</summary>

```plaintext
git status
cat .gitattributes
```

It created *.gitattributes* containing something like:

```
*.nc filter=lfs diff=lfs merge=lfs -text
```

This tells Git to pass any `.nc` file through the LFS filter on the way in and out.

</details>

**Task 4.** Commit *.gitattributes*. Why does this file have to be committed?

<details><summary>Solution</summary>

```plaintext
git add .gitattributes
git commit -m "Track NetCDF files with Git LFS"
```

Because it is what tells **everyone else's** Git to use LFS for those files. If it is not
committed, a colleague will commit a 500 MB file straight into the repository, which is exactly
what you were trying to avoid.

</details>

> [!WARNING]
> Track the pattern **before** you commit any matching file. Files committed before the rule
> existed stay in ordinary Git history, and moving them into LFS afterwards means rewriting
> history for everyone.

## See what actually gets committed <a name="pointer"></a>

**Task 5.** Create a file that pretends to be model output. Make it big enough to be obviously
not text.

<details><summary>Hint</summary>

`head -c` on `/dev/urandom` produces arbitrary bytes. 2 MB is plenty for a demonstration.

</details>

<details><summary>Solution</summary>

```plaintext
head -c 2000000 /dev/urandom > model_output.nc
ls -lh model_output.nc
```

</details>

**Task 6.** Add and commit it.

<details><summary>Solution</summary>

```plaintext
git add model_output.nc
git commit -m "Add model output"
```

</details>

**Task 7.** Here is the interesting part. Look at what Git actually stored for that file in the
commit — not what is in your working directory.

<details><summary>Hint</summary>

You met the `<commit>:<path>` syntax in Exercise 1.

</details>

<details><summary>Solution</summary>

```plaintext
git cat-file -p HEAD:model_output.nc
```

Instead of two megabytes of noise you get three short lines:

```
version https://git-lfs.github.com/spec/v1
oid sha256:<a long hash>
size 2000000
```

**That** is what lives in the repository: about 130 bytes. The real file sits in
*.git/lfs/objects*, and on a real project it would be uploaded to the server's LFS store on
`git push`.

</details>

**Task 8.** Confirm that your working directory still has the real file, not the pointer.

<details><summary>Solution</summary>

```plaintext
ls -lh model_output.nc
```

Still 2 MB. The *smudge* filter swaps the pointer for the real contents whenever Git writes the
file out, and the *clean* filter does the reverse on the way in. You never deal with pointers by
hand.

</details>

## Inspect what LFS manages <a name="inspect"></a>

**Task 9.** List the files LFS is handling in this repository.

<details><summary>Solution</summary>

```plaintext
git lfs ls-files
```

It prints the object ID, a marker and the path.

</details>

**Task 10.** Get a summary of the current LFS state, including anything staged.

<details><summary>Solution</summary>

```plaintext
git lfs status
```

</details>

**Task 11.** Check how much space the LFS objects take locally.

<details><summary>Solution</summary>

```plaintext
du -sh .git/lfs
```

</details>

## Decide whether you need LFS at all <a name="decide"></a>

LFS is not free, and reaching for it reflexively is a mistake.

- **Quotas cost money.** GitHub gives 1 GB of LFS storage and 1 GB of bandwidth per month for
  free; beyond that somebody pays. Bandwidth is consumed by every clone and every CI run.
- **It is sticky.** Once a repository uses LFS, everyone who clones it needs `git lfs` installed.
  Someone without it gets pointer files instead of data, and is very confused.
- **Removing it is painful.** Taking a file out of LFS, or out of history entirely, means
  rewriting history.
- **`git lfs` does not make diffs work.** You still cannot meaningfully merge two versions of a
  binary file.

**Task 12.** For each of these, decide whether LFS is the right answer:

1. A 300 MB NetCDF file of model output that a paper depends on.
2. A 5 MB logo in PNG format used by the project documentation.
3. A 2 GB input dataset that four different projects all need.
4. A 50 MB compiled binary produced by your build.

<details><summary>Suggested answers</summary>

1. **Probably not LFS.** Model output belongs in a data archive with a DOI. Put the *code* that
   produces it in Git and reference the dataset.
2. **LFS is unnecessary.** 5 MB committed once is fine. LFS adds a dependency for no real gain.
3. **Not LFS.** Shared input data belongs on a data server or a shared filesystem, referenced by
   path or URL. Four copies in four repositories helps nobody.
4. **Neither.** Build products should not be committed at all — that is what Exercise 3 was
   about. Add it to *.gitignore*.

The honest summary: LFS is for binary files that genuinely belong *with* the source and change
occasionally — reference images, test fixtures, small sample datasets. For real scientific data,
a data repository is almost always the better answer.

</details>

## Check yourself

- [ ] What is actually stored in the Git repository when a file is handled by LFS?
- [ ] Why must *.gitattributes* be committed?
- [ ] Why does the pattern have to be tracked *before* the file is committed?
- [ ] What do the clean and smudge filters do?
- [ ] What happens when someone without `git lfs` clones an LFS repository?
- [ ] Name one case where a data archive beats LFS.

## Clean up

```plaintext
rm -f model_output.nc
```
