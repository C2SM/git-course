# Exercise 3 - Ignoring files

In this exercise, you will first use a provided script to generate a simple Git repository containing materials for planning a conference. You will then create a *README* file for the so-called *conference_planning* repository using the Markdown language. Then you will generate an HTML README file, and finally create a *.gitignore* file for the repository. This exercise is closely adapted from the [OESA Git Workshop](https://oesa.pages.ufz.de/git-exercises/exercise-5.html).

* [Initialize the Git repository](#initialize)

* [Create a README file](#readme)

* [Generate the README file in HTML](#html)

* [Create a .gitignore file](#gitignore)

## Initialize the Git repository <a name="initialize"></a>

Use the [helper script](helpers.sh) provided in the [advanced](../advanced) folder to set up a simple Git repository.

First, clone the *git-course* repository if you have not already done so in Exercise 1.

```plaintext
git clone git@github.com:C2SM/git-course git-course
```

Navigate into the repository.

```plaintext
cd git-course
```

Set the name of the default branch in any Git repository you create to be `main`.

```plaintext
git config --global init.defaultBranch main
```

Source the file containing the helper functions: *helpers.sh

```plaintext
cd advanced
source helpers.sh
```
Run the *init_advanced_repo* function. This will create a folder at the same level as the *git-course* repository containing a simple Git repository called *conference_planning*.

```plaintext
init_advanced_repo
```

Take some time to familiarize yourself with the Git repository by examining the files and using `git status`, `git log`, `git diff`, etc.

## Create a README file <a name="readme"></a>

Create a *README.md* file in the *conference_planning* folder.

```plaintext
touch README.md
```

Put some content in the *README* file using a file editor. Good *README* file content could include the title of the project, a description of the project, how to use the project, and/or the contributors to the project. The *.md* file extension we have used indicates that the *README* file will be written using the Markdown language, which is a common format for *README* files because it displays well in web browsers. [Here](https://www.markdownguide.org/basic-syntax/) are some tips for using the Markdown language.

Now commit the *README* file to the repository.

```plaintext
git add README.md
git commit -m "Add README file"
```
## Generate the README file in HTML <a name="html"></a>

It may be useful to convert the *README* file to HTML in order to see how it will look to a user browsing your repository on the web. We will use a document converter called [Pandoc](https://pandoc.org) to do this. 
If you don't have Pandoc installed, there are instructions on how to do so [here](https://pandoc.org/installing.html). If you use conda, then `conda install -c conda-forge pandoc` should do the trick. 

You can check if Pandoc is installed correctly by running the following command:

```plaintext
pandoc -h
```

Once you have Pandoc up and running, convert the *README* to an HTML file.

```plaintext
pandoc README.md -o README.html
```

You can examine the output HTML file in a browser to check how it looks.

We could now commit the *README.html* file. However, it is good practice not to commit anything to a repository that can be generated from the project's source code. Instead, we will tell Git to ignore this file.

Before we do that, let's check the status of the repository, and ensure that the HTML file you generated is unstaged.

```plaintext
git status
```

## Create a .gitignore file <a name="gitignore"></a>

In order to tell Git to ignore our HTML file, we will create a *.gitignore* file.

```plaintext
touch .gitignore
```

Open the file using a file editor. In this file, you can list files, directories, or file patterns to be ignored, one entry per line. In order to ignore the HTML file, you can either list it specifically (*README.html*), or use wildcards to tell Git to ignore all HTML files (*.\*html)*.

Check the status again.

```plaintext
git status
```

The HTML file has disappeared, and now the *.gitignore* file is listed as unstaged. In order to save the file in the repository, commit it.

```plaintext
git add .gitignore
git commit -m "Added gitignore file to ignore html files"
```
