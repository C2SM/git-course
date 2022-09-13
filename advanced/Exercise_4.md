# Exercise 4 - Using git rebase

In this exercise, we will learn to use git rebase to rewrite the history of a feature branch in order to keep the history of the main branch cleaner by avoiding merge commits. First we will use the merge strategy to add a feature to a main branch that is being simultaneously developed. Then we will use the rebase strategy to do the same thing and compare the differences.

This exercise uses the same git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the `Initialize the git repository` section [here](./Exercise_3.md).

* [Use the merge strategy to incorporate a change into a moving main branch](#merge)

* [Use the rebase strategy to incorporate a change into a moving main branch](#rebase)

## Use the merge strategy to incorporate a change into a moving main branch <a name="merge"></a>

Navigate to the `conference_planning` folder.

Create and switch to a new feature branch.

```plaintext
git switch -c merge_feature
```

Make a change to the schedule for day 2. Let's add a presentation session. The following gives examples using the `sed` command line tool, which were tested on Linux but may not work on other platforms. You can also simply open the file in a file editor to make the change.

```plaintext
sed -i '/Coffee/ a 11:15-12:30: Presentation session' schedule_day2
```

Add and commit this change.

```plaintext
git commit -am "Add presentation session to day 2"
```

Switch back to the main branch and make a change to the day 2 schedule there. Let's add a dinner break.

```plaintext
git switch main
sed -i '/Evening/ i Dinner break' schedule_day2
```

Add and commit this change.

```plaintext
git commit -am "Add dinner break to day 2"
```
Now you are ready to incorporate the changes you made in your feature branch into the main branch. Let's do this with a merge.

```plaintext
git merge merge_feature
```

Examine the log. You should see that a merge commit has been created in the main branch.  

Follow git best practices and delete the no longer needed feature branch.

```plaintext
git branch -d merge_feature
```

## Use the rebase strategy to incorporate a change into a moving main branch <a name="rebase"></a>

Create and switch to a new feature branch.

```plaintext
git switch -c rebase_feature
```

Make a change to the schedule for day 2. Let's add a lunch break.

```plaintext
sed -i '/Presentation/ a 12:30-13:30: Lunch break' schedule_day2
```

Add and commit this change.

```plaintext
git commit -am "Add lunch break to day 2"
```

Switch back to the main branch and make a change to the day 2 schedule there. Let's add an apero before dinner.

```plaintext
git switch main
sed -i '/Dinner/ i Apero' schedule_day2
```

Add and commit this change.

```plaintext
git commit -am "Add Apero to day 2"
```

Now you are ready to incorporate the changes you made in your feature branch into the main branch. Let's do this with rebase this time instead of a merge.

```plaintext
git rebase main rebase_feature
```

Examine the repository status and log. Git has switched us to the `rebase_feature` branch and played the commit from the main branch here, without creating a merge commit.

Now, switch to the `main` branch and sync it with the `rebase_feature` branch.

```plaintext
git switch main
git merge rebase_feature
```

Examine the repository status and log again. Even though we have done a merge command, by doing the rebase beforehand we have created a situation where the merge can be done with the fast-forward technique, and therefore no merge commit was required. This is particularly advantageous in actively developed codes because it allows the history of the main branch to remain clean and free of unnecessary merge commits.  
