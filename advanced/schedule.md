# Schedule

3/4-day course, 09:30 – 15:00, lunch break 12:30 – 13:30.

> Notes:
> - 2026: restructured from Parts 0-4 + Bonus into two parts (commands, then web workflow).
> - 2026: `git bisect` dropped, `git lfs` added; rebase promoted from bonus into Exercise 4.
> - 2026: exercises rewritten as tasks with optional hints, so they take longer to work through
>   than the old copy-paste versions. Watch the timing on Exercises 1 and 4 in particular.
> - 2026: start moved 15 min earlier to 09:15 (end time 15:00 stays fixed), welcome trimmed from
>   10 to 5 min, and the three exercise blocks were extended to absorb the longer task-based
>   format. This still falls short of the exercises' own printed time estimates, so Exercises 1,
>   2, 4 and 5 have some of their tasks marked as Bonus (optional, skip if short on time).

| Description | Presenter | Extent | Time est. | Time needed ('24, '25, '26) | Start time | End time |
| --- | --- | --- | --- | --- | --- | --- |
| Welcome, outline, schedule | Michael | 3 slides | 5 min | 8 min, 8 min, - | 09:15 | 09:20 |
| Part 1 - Slides: history, submodules | Michael | 9 slides | 20 min | -, -, - | 09:20 | 09:40 |
| Part 1 - Exercises 1-2 | 💻 | | 40 min | 42 min, 42 min, - | 09:40 | 10:20 |
| Part 1 - Slides: ignoring, cherry-pick, rebase, stash, worktree | Mikael | 9 slides | 20 min | -, -, - | 10:20 | 10:40 |
| Part 1 - Exercises 3-5 | 💻 | | 45 min | 29 min, 40 min, - | 10:40 | 11:25 |
| Coffee break | all | 1 coffee | 20 min | 23 min, 20 min, - | 11:25 | 11:45 |
| Part 1 - Slides: hooks, git lfs | Alitzel | 6 slides | 10 min | -, -, - | 11:45 | 11:55 |
| Part 1 - Exercises 6-7 | 💻 | | 35 min | 21 min, 21 min, - | 11:55 | 12:30 |
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
