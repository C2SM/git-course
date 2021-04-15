# Git Course for Beginners
This repository contains the exercises for the beginners git course of C2SM.
Feel free to download the material to practice and enhance your git skills.

## How to run the exercises
First of all you need a git installation on your computer.
To do so please follow the [instructions from GitHub](https://github.com/git-guides/install-git).

Second, you need a Python installation as well.
We provide you here with [instructions from realpython](https://realpython.com/installing-python/),
but of course many other instruction will do it as well.

Third you need some non-standard python packages, namely:
   - jupyterlab
   - bash_kernel

To install these two packages execute the following command in your terminal:
```
python -m venv git-course_env
source git-course_env/bin/activate
pip install -r requirements.txt
```
On some machines an additional step is necessary:
```
python -m bash_kernel.install
```

Finally you can start with the exercises by running:
```
jupyter notebook
```
This command opens the Jupyter Notebook interface in your browser.

**Have fun!**
