# Git Course for Beginners
This repository contains the exercises for the C2SM Git Workshop "Git for Beginners".
Feel free to download the material to practice and enhance your Git skills.

The corresponding [slides of this course](https://wiki.c2sm.ethz.ch/CM/WorkshopBestPractices2013) can be found
at the C2SM wiki.

A Markdown version of the .ipynb files for each exercise is located in the [Markdowns folder](Markdowns).
Please note that pictures are not displayed in the Markdown versions of the exercises.

We recommend to make use of the convienient way of doing the exercises with Jupyter Notebook itself.
For installation instructions see section below.

## How to run the exercises
First of all, you need a Git installation on your computer.
To do so, please follow the [instructions from GitHub](https://github.com/git-guides/install-git).

> **_Important note:_**  You must have at least Git 2.28 (released 27 July 2020) installed. 
> You can check your Git version by typing `git --version` in your terminal.

Second, you need a Python installation as well.
We provide you here with [instructions from realpython](https://realpython.com/installing-python/),
but of course many other instruction will do it as well.

Third, you need some non-standard python packages, namely:
   - jupyterlab
   - bash_kernel

To install these two packages, execute the following command in your terminal:
```
python -m venv git-course_env
source git-course_env/bin/activate
pip install -r requirements.txt
```
On some machines an additional step is necessary:
```
python -m bash_kernel.install
```

Finally, you can start with the exercises by running:
```
jupyter notebook
```
This command opens the Jupyter Notebook interface in your browser. 
If it does not open automatically, you have to copy and paste the URL manually.
In that case, please follow the instructions in your terminal.

**Have fun!**
