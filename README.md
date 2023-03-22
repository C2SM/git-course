# C2SM Git Courses

## Git Course for Beginners
The folder [beginner](beginner) contains the exercises for the C2SM Git Workshop "Git for Beginners".

## Git Course for Advanced
The folder [advanced](advanced) contains the exercises for the C2SM Git Workshop "Git for Advanced".

## How to do the exercises
First, you need to install Git on your computer.
To do this, please follow the [instructions from GitHub](https://github.com/git-guides/install-git).

> **_Important note:_**  You must have at least Git 2.28 (released 27 July 2020) installed.
> You can check your Git version by typing `git --version` in your terminal.

Second, you also need a Python installation.
We provide you here with [instructions from realpython](https://realpython.com/installing-python/),
but of course many other instructions will do as well.

For the beginners course, you also need some non-standard python packages, namely:
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
