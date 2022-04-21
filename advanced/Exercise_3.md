# Exercise 3 - Using git bisect

In this exercise, you will use git bisect to pinpoint the exact commit in a repository where the code has broken. This tool is very useful for debugging. For this exercise, we will be using a publicly available git bisect example: https://github.com/bast/git-bisect-exercise. It consists of a git repository that contains a simple python script to calculate pi to 2 decimal places, which has broken at some point in the history of the repository. Your job is to use git bisect to find the commit where the code has broken and no longer returns the correct value of pi. You will do this in two ways: first, using git bisect manually, and then doing it automatically with git bisect run. Spoiler alert: Try to avoid the README.md file in the repository, as it contains the solution of the exercise.    

* [Clone and test the example repository](#clone)

* [Use git bisect manually to find the bad commit](#manual)

* [Use git bisect run to automatically find the bad commit](#automate)

## Clone and test the example repository <a name="clone"></a>

Clone the example repository into it's own folder.   

```plaintext
git clone git@github.com:bast/git-bisect-exercise
```
Test the pi calculating script (`get_pi.py`) to see what value of pi it gives.  

```plaintext
python get_pi.py
```
The script gives 3.57 as a result, of course to be correct it should give 3.14.  

Let's test the first commit in the repository to see if the script was working then. First, we need to find the hash for the first commit using git log. You can list the commits starting with the oldest using the `--reverse` flag.  

```plaintext
git log --reverse
```

Note the SHA value of the first commit in the repository, then use `q` to exit the log.  

Switch to the first commit in the repository.

```plaintext
git checkout f0ea950
```
Test the script again.  

```plaintext
python get_pi.py
```

Now we get the correct answer: 3.14. So we know that somewhere between the first commit and the last commit, the script has stopped working. Git bisect will help us to figure out at exactly which commit this happened.

Before we move on, let's switch our repository back to the final commit.  

```plaintext
git switch -
```

## Use git bisect manually to find the bad commit <a name="manual"></a>

Initiate a git bisect session.

```plaintext
git bisect start
```

Next, you need to tell git bisect the commit you know where the code is good, and the commit you know where the code is bad. If you omit the commit SHA number, then git assumes you are referring to the current commit.  

Tell git the current commit is bad.

```plaintext
git bisect bad
```

Tell git the first commit is good.

```plaintext
git bisect good f0ea950
```

Once you have run this command, git has enough information to start the bisection. It automatically finds the commit that is halfway in between the good commit and the bad commit, and checks it out for you. All you need to do is test the current commit, and then tell git whether the code is good or bad at this point.  

```plaintext
python get_pi.py
```

In this first case, you should see that the code gives 3.57, which is the incorrect answer. Let's inform git of this.

```plaintext
git bisect bad
```

Once you run this command, git will recalculate the halfway point between the new good and bad commits and check out a new commit for you to test. Continue by testing the script using `python get_pi.py` and then telling git whether the commit gives the correct result (`git bisect good`), or the incorrect result (`git bisect bad`). Keep repeating this process until you get a message from git identifying the exact commit where the code breaks. You can check that you have the correct solution by reading the Solution section of the README.md file.   

## Use git bisect run to automatically find the bad commit <a name="automate"></a>

We can also automate this process to make it easier. We just need a testing script that will return 0 if the code is correct, and an error value between 1 and 127 (excluding 125) if the code is incorrect. We can make a simple python script to do this. Let's make a new file for this.

```plaintext
touch check_script.py
```

Open the file using a file editor. You can either copy the code below into the file, or try to write the scipt yourself if you would like. You could use whatever language you like, the script just needs to run the `get_py.py` script and return a 0 if the result if 3.14 and any number between 1 and 127 if the result is not 3.14.   

<details>
  <summary>Click here for checking script</summary>

  ```plaintext
  import subprocess;
  import numpy;
  import sys;

  output = subprocess.check_output(['python', 'get_pi.py']);
  result = float(output);

  if numpy.isclose(result, 3.14):;
      sys.exit(0);
  else:;
      sys.exit(1)
  ```
</details>

