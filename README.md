# C2SM Git Courses

## Git Course for Beginners

The folder [beginner](beginner) contains the exercises for the C2SM Git Workshop "Git for Beginners".

## Git Course for Advanced

The folder [advanced](advanced) contains the exercises for the C2SM Git Workshop "Git for Advanced".

## Getting Started

To run this course on your computer, the following things need to be set up:
1. [Git](#1-installing-git-on-your-computer)
2. [SSH key linked to your GitHub account](#2-creating-a-github-account-and-ssh-key)
3. [Python](#3-installing-python) 
4. [Final check](#4-final-check)


### 1. Installing Git on your Computer

To follow the course, Git needs to run on a _**Linux or MacOS terminal**_. Windows users can either follow the instructions below to install Ubuntu or use a Linux server they have access to.

> **_Important note:_**  You must have at least Git 2.28 (released 27 July 2020) installed.
> You can check your Git version by typing `git --version` in your terminal.

**Mac and Linux users:** To install Git on your computer, please follow the instructions to [Install Git on Mac](https://github.com/git-guides/install-git#install-git-on-mac) or [Install Git on Linux](https://github.com/git-guides/install-git#install-git-on-linux)

**Windows users:** Please follow the instructions below to install Ubuntu under Windows. Afterwards, please follow the [Install Git on Linux](https://github.com/git-guides/install-git#install-git-on-linux) instruction.
<details>
<summary>Instructions for Windows Users</summary>
<br>

We recommend to install the **Windows Subsystem for Linux 2** (WSL2). Using Git with WSL2 provides a better terminal experience for Windows users. With WSL2, you can access a Linux terminal directly from Windows, which makes it easier to work with Git commands and other Linux-based tools. This also allows for more flexibility in managing and running scripts, as well as better compatibility with Linux-based workflows. Additionally, WSL2 provides a more secure environment for Git operations by isolating them from the Windows operating system.

#### Setting up WSL2

1. Enable the Windows Subsystem for Linux (WSL) feature on your Windows machine by following the steps [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).
2. Install a Linux distribution of your choice from the Microsoft Store. We recommend using Ubuntu 22.04.3 LTS.
3. Open the Start menu and search for "Ubuntu" to launch the distribution.
4. Follow the prompts to set up a username and password for the Ubuntu distribution.

Congratulations! You have now an Ubuntu environment and can work in the same way as on a Linux machine.
</details>

### 2. Creating a GitHub Account and SSH key

Having a GitHub account allows you to collaborate on open-source projects and store your own code in the cloud. With an SSH key, you can securely connect to GitHub without having to enter your username and password every time you push or pull code, which makes the process faster and more convenient. It also adds an extra layer of security to protect your GitHub account from unauthorized access.

#### Instructions

- [Create your own GitHub account](https://github.com/) (if not yet available)
- [Generate an SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Add your SSH key to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

### 3. Installing Python

To install Python, we recommend the [instructions from Real Python](https://realpython.com/installing-python/),
but of course many other instructions will do as well.

### 4. Final check
Check if everything is set up correctly by following the steps below from a Linux shell.

- Step 1: Download the file [check_requirements.sh](https://github.com/C2SM/git-course/blob/main/check_requirements.sh).
```
curl -O https://raw.githubusercontent.com/C2SM/git-course/main/check_requirements.sh
```
- Step 2: Make the file executable.
```
chmod +x ./check_requirements.sh
```
- Step 3: Run the script from a Linux shell.
```
./check_requirements.sh
```

**Have fun!**
