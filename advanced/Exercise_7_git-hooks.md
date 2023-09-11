# Exercise 7 - Custom Git Hooks

In this exercise, you will practice implementing a pre-commit hook in the *conference_planning* repository to prevent committing files with trailing whitespace. You will also learn how to set up multiple pre-commit hooks for different tasks.

This exercise uses the same Git repository that was created in Exercise 3. If you have not already done so, you can create it by following the instructions in the [Initialize the Git repository](./Exercise_3_gitignore.md#initialize) section of Exercise 3.

* [Implement Pre-Commit Hook for Trailing Whitespace](#whitespace)

* [Test the Hook](#test)

* [Add Another Custom Hook](#another)

* [Local Testing with the `pre-commit` Tool](#pre-commit)

* [Conclusion](#conclusion)

## Implement Pre-Commit Hook for Trailing Whitespace <a name="whitespace"></a>

As our first hook, we are going to implement a check for trailing whitespace. Trailing whitespaces are spaces or tabs at the end of a line in a text file, and they should be avoided because they can introduce inconsistencies in code formatting, create visual distractions, and cause unintended issues when working with the code.

Open a terminal and navigate to the *conference_planning* repository on your local machine. Create a new file called *pre-commit* in the *.git/hooks* directory. Our Git hook files need to be set as executable in order to work. To do this, we use the `chmod` command to change file permissions, along with the `+x` parameter to make a file executable so that it can be run as a script.

```sh
touch .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

Open the *pre-commit* file in a text editor and add the following script:

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

Try to make a commit with a file that has trailing whitespace and observe how the *pre-commit-whitespace* hook prevents the commit.

## Add Another Custom Hook <a name="another"></a>

The following repository contains a collection of useful Git Hooks: https://github.com/CompSciLauren/awesome-git-hooks

We now want to implement another *pre-commit* in addition to the trailing whitespace test.

To do this, we will first rename our existing *pre-commit* script:

```sh
mv .git/hooks/pre-commit .git/hooks/pre-commit-whitespace
```

Now, *pre-commit* becomes our master script that calls our actual hook scripts.

```sh
touch .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

Integrate another *pre-commit* hook from the above repository into your workflow. Try the *verify-name-and-email* one if you are not sure where to start. In that case, your *.git/hooks/pre-commit* script should look as follows:

```bash
#!/bin/bash

# This is the main pre-commit hook script.

# Run the whitespace check script.
.git/hooks/pre-commit-whitespace

# Run the name and email verification script.
.git/hooks/pre-commit-verify-name-and-email
```

> **Hint:** Don't forget that all scripts need to be executable! 

Finally, verify that both *pre-commit* hooks are working correctly.

## Local Testing with the `pre-commit` Tool <a name="pre-commit"></a>

In order to manually run the pre-commit hooks to preview your actions without committing, you can utilize the [pre-commit](https://pre-commit.com/) tool.

If you haven't already, install the `pre-commit` tool globally on your system:

```sh
pip install pre-commit
```

or

```sh
conda install -c conda-forge pre-commit
```

After installation, you can verify that pre-commit is available by running:

```sh
pre-commit --version
```

This should display the version of `pre-commit`, confirming a successful installation.

In your *conference_planning* repository, create a *.pre-commit-config.yaml* file to configure which hooks to run. Here is an example configuration:

```yaml
repos:
- repo: local
  hooks:
  - id: pre-commit-whitespace
    name: check for trailing whitespaces
    entry: .git/hooks/pre-commit-whitespace
    language: system
  # Add other hooks here if needed
```

This configuration specifies that the `pre-commit-whitespace` hook (the one we created earlier) should run.

To manually run the `pre-commit` checks without making a commit, keep in mind that the `pre-commit` tool only checks against
staged files, i.e. you need to do `git add` for your file that contains whitespace. Afterwards, use the following command:

```sh
pre-commit run --all-files --verbose
```

- `--all-files`: This flag tells `pre-commit` to check all files in the repository.
- `--verbose`: This flag provides detailed output, showing you exactly what each hook is doing.

Running this command will execute the specified hooks, including your `pre-commit-whitespace` hook, and display the results.

Examine the output of the `pre-commit` checks to see if any issues are reported. If the `pre-commit-whitespace` hook detects trailing whitespace, it will be shown in the output.

## Conclusion <a name="conclusion"></a>

In this exercise, you learned how to implement a *pre-commit* hook that prevents committing files with trailing whitespace. You also explored setting up multiple *pre-commit* hooks for different tasks. By integrating the `pre-commit` tool and configuring it with your custom hooks, you have learned a convenient way to check your changes before committing them, helping to maintain code quality and consistency in your development workflow.
