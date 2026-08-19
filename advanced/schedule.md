# Schedule

3/4-day course, 09:30 – 15:00, lunch break 12:30 – 13:30.

> Notes:
> - 2026: restructured from Parts 0-4 + Bonus into two parts (commands, then web workflow).
> - 2026: `git bisect` dropped, `git lfs` added; rebase promoted from bonus into Exercise 4.
> - 2026: exercises rewritten as tasks with optional hints, so they take longer to work through
>   than the old copy-paste versions. Watch the timing on Exercises 1 and 4 in particular.

| Description | Presenter | Extent | Time est. | Time needed ('24, '25, '26) | Start time | End time |
| --- | --- | --- | --- | --- | --- | --- |
| Welcome, outline, schedule | Michael | 3 slides | 10 min | 8 min, 8 min, - | 09:30 | 09:40 |
| Part 1 - Slides: history, submodules | Michael | 9 slides | 20 min | -, -, - | 09:40 | 10:00 |
| Part 1 - Exercises 1-2 | 💻 | | 30 min | 42 min, 42 min, - | 10:00 | 10:30 |
| Part 1 - Slides: ignoring, cherry-pick, rebase, stash, worktree | Mikael | 9 slides | 20 min | -, -, - | 10:30 | 10:50 |
| Part 1 - Exercises 3-5 | 💻 | | 40 min | 29 min, 40 min, - | 10:50 | 11:30 |
| Coffee break | all | 1 coffee | 20 min | 23 min, 20 min, - | 11:30 | 11:50 |
| Part 1 - Slides: hooks, git lfs | Alitzel | 6 slides | 10 min | -, -, - | 11:50 | 12:00 |
| Part 1 - Exercises 6-7 | 💻 | | 30 min | 21 min, 21 min, - | 12:00 | 12:30 |
| Lunch break | all | | 60 min | | 12:30 | 13:30 |
| Part 2 - Slides + live demonstration | Michael | 12 slides | 60 min | 8 min, 8 min, - | 13:30 | 14:30 |
| Part 2 - Exercise 8 + wrap-up | 💻 | | 30 min | -, -, - | 14:30 | 15:00 |

## Notes for the next run

- Exercise 8 needs **pairs**: participants review each other's pull requests. Ask people to pair
  up before the coffee break so no one is left without a reviewer.
- Exercises 2 and 8 both need a fork of
  [c2sm-git-example](https://github.com/C2SM/c2sm-git-example). Point this out at the start of
  Part 1 so people fork once, early, rather than twice.
- Exercise 7 needs `git lfs` installed. `check_requirements.sh` checks for it, but remind people
  in the joining instructions.
- Exercise 8 is deliberately last in the schedule. It continues past the end of the course for
  anyone who wants to finish it, and the pull requests can be reviewed afterwards.
- `test_helpers.yml` covers Linux, macOS and Git Bash for Windows on every pull request, so a
  manual pre-course check of the helper scripts is no longer needed.
