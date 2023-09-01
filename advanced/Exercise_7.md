# Exercise 7 - Custom Git Hooks

In this exercise, you'll practice implementing a pre-commit hook in the `conference_planning` repository to prevent committing files with trailing whitespace. You'll also learn how to set up multiple pre-commit hooks for different tasks.

This exercise uses the same Git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the [Initialize the Git repository](./Exercise_3.md#initialize) section of Exercise 3.

* [Navigate to the Repository](#navigate)

* [Implement Pre-Commit Hook for Trailing Whitespace](#whitespace)

* [Test the Hook](#test)

* [Add Another Custom Hook](#another)

* [Conclusion](#conclusion)

## Navigate to the Repository <a name="navigate"></a>

Open a terminal and navigate to the `conference_planning` repository on your local machine.

## Implement Pre-Commit Hook for Trailing Whitespace <a name="whitespace"></a>

Create a new file named `pre-commit` in the `.git/hooks` directory. Make it executable.

```sh
touch .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

Open the `pre-commit` file in a text editor and add the following script:

```bash
#!/bin/bash

# This is the pre-commit hook to prevent committing files with trailing whitespace.

# Redirect output to stderr.
exec 1>&2

# Check for trailing whitespace in staged files.
if git diff --check --cached | grep -q '[[:blank:]]$'; then
    echo "Error: Found files with trailing whitespace."
    echo "Please remove trailing whitespace before committing."
    exit 1
fi
```

Save and close the file.

## Test the Hook <a name="test"></a>

Now you have a pre-commit hook for preventing trailing whitespace set up.

Create a new branch or make changes on an existing branch and stage your changes using `git add`.

Try to make a commit with a file that has trailing whitespace and observe how the `pre-commit-whitespace` hook prevents the commit.

## Add Another Custom Hook <a name="another"></a>

The following repository contains a collection of useful Git Hooks: https://github.com/CompSciLauren/awesome-git-hooks

We now want to implement another `pre-commit` in addition to the trailing whitespace test.

To do this, we will first rename our existing `pre-commit` script:

```sh
mv .git/hooks/pre-commit .git/hooks/pre-commit-whitespace
```

Now, `pre-commit` becomes our master script that calls our actual hook scripts.

```sh
touch .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

Integrate another `pre-commit` hook from the above repository into your workflow. Try the `verify-name-and-email` one if you're not sure where to start. In that case, your `.git/hooks/pre-commit` script should look as follows:

```bash
#!/bin/bash

# This is the main pre-commit hook script.

# Run the whitespace check script.
.git/hooks/pre-commit-whitespace

# Run the name and email verification script.
.git/hooks/pre-commit-verify-name-and-email
```

> **Hint:** Don't forget that all scripts need to be executable! 

Finally, verify that both `pre-commit` hooks are working correctly.

## Conclusion <a name="conclusion"></a>

In this exercise, you learned how to implement a `pre-commit` hook that prevents committing files with trailing whitespace. You also explored setting up multiple pre-commit hooks for different tasks. This helps improve code quality and maintain consistency in your development workflow.
