# Exercise 7

# Goals
* Work collaboratively with a partner using Git and Github
* Create a pull request (PR)
* Do code review and merge a pull request

### Initialization


```bash
# check current directory with "pwd"
pwd
# go to folder of this exercise using "cd"

```


```bash
# execute this code at the very beginning to get access to the helper functions
source ../helpers.sh
init_exercise
```

***
### Optional: clear notebook and restart
**In case you mess up your notebook completely,  
execute** ***reset*** **in the following cell. This will restore a clean environment!**


```bash
## only execute in case of (serious) trouble ##
## it will delete your entire work-directory ##
reset
```

***
## Exercise

First, say hi to your partner and exchange Github usernames.  

For this exercise, we are going to work in our forked repositories from Exercise 6.  To do this, we want to create an issue to track a feature request.  However, Github doesn't activate issues by default on forks.  So first, we will activate issue tracking on our forked repository.

### Activate issues on your forked repository

Use another tab in the web browser to go to your fork on Github: github.com/your_github_username/git-example

Navigate to the Settings page.

![image.png](attachment:80180ec9-d94c-4e9d-9527-314925db78fa.png)

Check the Issues box in the Features section.

![image.png](attachment:338f1844-4c5d-4a7b-96eb-c40c118d9494.png)


### Make an issue in your repository

Let's request a new feature in our repository from our partner.  To do so, we can create a new issue in our repository by clicking on the issues button, and then the New issue button.  

![image.png](attachment:43dec399-ae5a-40b5-8809-bdf72752f5cf.png)

Fill in a title and description for the issue.  You can ask them to add a new flyer, adapt one of your flyers, or any other new feature you can think of.  Then, use the Assignees button on the right to assign the issue to your partner using their Github username.  

### Develop the feature your partner requested  

To find the feature your partner requested, you can click on the "issues" button at the very top of your Github page.  This is a list of all of the issues you have either created, worked on, or been assigned.  
![image.png](attachment:4d167943-0fad-4791-bac8-676ee5c50da8.png)

Once you have found your partner's feature request, you can download your fork locally to do the feature development.


```bash
# use "git clone <path_to_repository>" to download your forked repository

```


```bash
# use "cd" to enter the repository

```

### Make a feature branch
Make a new branch in your local repository to develop the new feature in.   


```bash
# use "git switch -c <branch_name>" to create and move to a new branch

```

### Develop the new feature
Make the change your partner requested.
Remember to do all modifications of the flyers directly via Jupyter Notebooks.
   * Go to folder *work* and enter *party_planning*
   * Open *flyer_A*
   * Add more information to your flyer, i.e. music, dresscode, etc.
   
**Don't forget to save your modifications before coming back!**


```bash
# add and commit your changes

```

### Send local information to GitHub

Now, let's send our feature branch to our GitHub fork. 

**Unfortunately we cannot perform *git push* via jupyter notebooks due to the
interactive way of entering username and password.**

Please open a terminal and go to the directory you get executing the cell below.

Then run *git push origin <"branch_name">* there.


```bash
# go to this folder in the terminal and perform "git push origin <"branch_name"> there
pwd

```

### Make a pull request

Go back to your fork on GitHub.  You should find a notification about the new branch you just pushed there.  Choose the option to make a pull request.  

Fill out the pull request title and description.  Choose your partner's fork as the base.
Include the following text in your pull request description: "Fixes #issue_number", using the issue number of your partner's feature request.  This will close your partner's feature request issue when they merge the pull request.  

If you are having trouble figuring how to make the pull request, the Github documentation is very helpful:
https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request

Once you have made your pull request, you should request a review from your partner:
https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/requesting-a-pull-request-review

### Review your partner's code
Once you and your partner have both finished your development and pull requests, you can review each other's pull request.  
https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-request-reviews

Navigate in your fork to the pull request, and have a look at the changes your partner made.  You can add general comments, or put comments directly on a line of code.  You can also request that your partner change or fix something before the code is merged.  

### Merge the pull request
Once you are satisfied with your partner's developments, you can merge the pull request using the web interface.  After merging a feature into a main development branch (such as main), it is standard procedure to delete the feature branch, as it is no longer needed.  Usually GitHub will prompt you to delete the feature branch right after you merge a pull request.  

After you have merged the pull request, go back and check that the issue you created to request this feature has now been closed.  
