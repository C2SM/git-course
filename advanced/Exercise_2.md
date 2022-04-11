# Exercise 2 - Ignoring files

In this exercise, you will create a README file for the conference planning repository using the Markdown language. Then you will generate an HTML README file, and finally create a `.gitignore` file for the repository. This exercise is closely adapted from [this website](https://oesa.pages.ufz.de/git-exercises/exercise-5.html#ignore-files).  

* [Create a README file](#readme)

* [Generate the README file in HTML](#html)

* [Create a .gitignore file](#gitignore)

## Create a README file <a name="readme"></a>

Create a README.md file in the `conference_planning` folder.  

```plaintext
touch README.md
```

Put some content in the README file using a file editor. Good README file content could include the title of the project, a description of the project, how to use the project, and/or the contributors of the project. [Here](https://www.markdownguide.org/basic-syntax/) are some tips for using the Markdown language.

Now commit the README file to the repository.

```plaintext
git commit -am "Add README file"
```
## Generate the README file in HTML <a name="html"></a>

It may be useful to convert the README file into an HTML file in order to see how it will look to a user web browsing your repository. We will use a document converter called [Pandoc](https://pandoc.org) to do this. 

```plaintext
pandoc README.md -o README.html
```

You can examine the output html file in a browser to check how it looks.  

We could now commit the document. However, it is good practice not to commit anything to a repository that can be generated from the project's source files. Therefore, we will instead tell git to ignore this HTML file.

Before we do that, let's check the status of the repository, and ensure that the HTML file you generated is unstaged.

```plaintext
git status
```

## Create a .gitignore file <a name="gitignore"></a>

In order to tell git to ignore our HTML file, we will create a `.gitignore` file.  

```plaintext
touch .gitignore
```

Open the file using a file editor. In this file, you can list files, directories, or file patterns to be ignored, one entry per line. In order to ignore the HTML file, you can either list it specifically (`README.html`), or use wildcards to tell git to ignore all HTML files (`*.html`).

Check the status again.

```plaintext
git status
```

The HTML file has disappeared, and now the `.gitignore` file is listed as unstaged. In order to save the file in the repository, commit it.  

```plaintext
git commit -am "Added gitignore file to ignore html files"
```
