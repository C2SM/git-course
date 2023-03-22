# Git Course for Beginners
This folder contains the exercises for the C2SM Git Workshop "Git for Beginners".
Feel free to download the material to practice and enhance your Git skills.

The corresponding [slides of this course](https://wiki.c2sm.ethz.ch/CM/WorkshopBestPractices2013) can be found on the C2SM wiki.

A Markdown version of the .ipynb files for each exercise is located in the [Markdowns folder](Markdowns).

We recommend that you use the convenient way of doing the exercises with Jupyter Notebook itself.
See below for installation instructions.

## How to do the exercises
First, you need to install Git on your computer.
To do this, please follow the [instructions from GitHub](https://github.com/git-guides/install-git).

> **_Important note:_**  You must have at least Git 2.28 (released 27 July 2020) installed.
> You can check your Git version by typing `git --version` in your terminal.

Second, you also need a Python installation.
We provide you here with [instructions from realpython](https://realpython.com/installing-python/),
but of course many other instructions will do as well.

Third, you need some non-standard python packages, namely:
   - jupyterlab
   - bash_kernel

To install these two packages, run the following command in your terminal:
```
python -m venv git-course_env
source git-course_env/bin/activate
pip install -r requirements.txt
```
On some machines an extra step is required:
```
python -m bash_kernel.install
```

Finally, you can start with the exercises by running:
```
jupyter notebook
```
This command will open the Jupyter Notebook interface in your browser.
If it does not open automatically, you will need to copy and paste the URL manually.
In this case, please follow the instructions on your terminal.

**Have fun!**
