# Exercise 3 - Ignoring files

In this exercise, you will first use a provided script to generate a simple git repository containing materials for planning a conference. You will then create a README file for the conference planning repository using the Markdown language. Then you will generate an HTML README file, and finally create a `.gitignore` file for the repository. This exercise is closely adapted from [this website](https://oesa.pages.ufz.de/git-exercises/exercise-5.html).  

* [Initialize the git repository](#initialize)

* [Create a README file](#readme)

* [Generate the README file in HTML](#html)

* [Create a .gitignore file](#gitignore)

## Initialize the git repository <a name="initialize"></a>

Use the helper scripts provided in https://www.github.com/C2SM/git-course to set up a simple git repository.

First, clone the git-course repository if you have not already done so in Exercise 1.  

```plaintext
git clone git@github.com:C2SM/git-course
```

Navigate into the repository.

```plaintext
cd git-course
```

Set the name of the default branch in any git repository you create to be `main`.

```plaintext
git config --global init.defaultBranch main
```

Source the file containing the helper scripts: `helpers.sh`

```plaintext
source helpers.sh
```
Run the `init_advanced_repo` script.  This script will create a folder at the same level as the git-course repository containing a simple git repository called `conference_planning`.  

```plaintext
init_advanced_repo
```

Take some time to familiarize yourself with the git repository by examining the files and using `git status`, `git log`, `git diff`, etc.

## Create a README file <a name="readme"></a>

Create a README.md file in the `conference_planning` folder.  

```plaintext
touch README.md
```

Put some content in the README file using a file editor. Good README file content could include the title of the project, a description of the project, how to use the project, and/or the contributors of the project. The `.md` file extension we have used indicates that the README file will be written using the Markdown language, which is a common format for README files because it displays well in web browsers. [Here](https://www.markdownguide.org/basic-syntax/) are some tips for using the Markdown language.

Now commit the README file to the repository.

```plaintext
git add README.md
git commit -m "Add README file"
```
## Generate the README file in HTML <a name="html"></a>

It may be useful to convert the README file into an html file in order to see how it will look to a user web browsing your repository. We will use a document converter called [Pandoc](https://pandoc.org) to do this. You can check if you have Pandoc installed with the following command:

```plaintext
pandoc -h
```

If you don't have Pandoc installed, there are instructions on how to do so [here](https://pandoc.org/installing.html).

Once you have Pandoc ready to go, convert the README to an html file.

```plaintext
pandoc README.md -o README.html
```

You can examine the output html file in a browser to check how it looks.  

We could now commit the `README.html` file. However, it is good practice not to commit anything to a repository that can be generated from the project's source files. Therefore, we will instead tell git to ignore this file.

Before we do that, let's check the status of the repository, and ensure that the html file you generated is unstaged.

```plaintext
git status
```

## Create a .gitignore file <a name="gitignore"></a>

In order to tell git to ignore our html file, we will create a `.gitignore` file.  

```plaintext
touch .gitignore
```

Open the file using a file editor. In this file, you can list files, directories, or file patterns to be ignored, one entry per line. In order to ignore the html file, you can either list it specifically (`README.html`), or use wildcards to tell git to ignore all html files (`*.html`).

Check the status again.

```plaintext
git status
```

The html file has disappeared, and now the `.gitignore` file is listed as unstaged. In order to save the file in the repository, commit it.  

```plaintext
git add .gitignore
git commit -m "Added gitignore file to ignore html files"
```
