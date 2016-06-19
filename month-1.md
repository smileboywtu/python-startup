# content

* [daily](#daily)
* [tools](#tools)
* [python guide](#basic-tutorial)
* [enhance reading](#advance-tutorial)
* [python web starter](#web-from-scratch)
* [examples](#examples)

# daily

1. [深入浅出Git权限校验(2016/6/17)](http://mp.weixin.qq.com/s?__biz=MzAxMTczMjgzMQ==&mid=2650587852&idx=1&sn=0c2144c7bc30a6176e309290eb50fc75&scene=1&srcid=06170Qz47CZilcjbK4kCR31J&from=groupmessage&isappinstalled=0)

# platform

We assume that you:

- are familiar with terminal, like gnome-terminal or Mac OS X iTerm2.
- can use Google, Stack Overflow, Bing or other search engine.

Caution:

- Be careful with the commands prefixed with `sudo`, things might break.
- If you're using Homebrew Python on Mac OS X, or if you're on Windows, don't
  use `sudo`.

# tools

**about terminal**:

- zsh / oh-my-zsh
- git

> install git

``` shell
# Use your package manager to install git, here we're on Fedora 23 and using dnf.
# Use apt-get on Ubuntu and Debian, or yum on CentOS.
# If you're on Windows, please refer to https://git-scm.com for installation instructions.
sudo dnf install git

# Before you start, you should set the username and email address for git,
# so that people can identify your commits later.
# You can also configure them per repository if you omit the `--global` option.
git config --global user.name "Your name"
git config --global user.email "your_email@example.com"

# Clone a repository from github using ssh
# https://help.github.com/articles/generating-an-ssh-key/
# By using ssh you don't need to type your password every time you push the code.
git clone git@github.com:smileboywtu/python-enhance.git

# Pull the latest code from remote repository
git pull

# You can make some modification to the source code files
# And tell git to save your modification by adding them
git add modified_file

# And when you're satisfied with your modifications, it's time to `commit` them,
# so they can be tracked later.
git commit -m "A meaningful commit message describing what you've modified."

# Push the local code to remote repository
git push

# If you need help, just add `-h` / `--help` as an option after `git` or a git subcommand.
# On Linux you can also use `man git` to read detailed manual.
# If you're not satisfied with these documentation, just Google for what you want.
git -h

# For detailed git tutorials, please refer to https://git-scm.com/book/zh/v2 .
```

**about python**:

- python 2.7

> config python

``` shell
# install python itself
sudo dnf install python2.7

# install python package manager tool pip
sudo dnf install pip2

# use pip install setuptools
sudo pip install setuptools
```
- virtualenv / virtualenvwrapper
``` shell
# Install virtualenv
sudo pip install virtualenv

# install virtualenvwrapper, a simple tool to manage virtual env
sudo pip install virtualenvwrapper

# config virtualenvwrapper with zsh
# add this lines to your .zshrc or .bashrc
export WORK_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
source /usr/bin/virtualenvwrapper.sh

# Why use virtualenv?
# Standalone environment for each of your projects that:
# - isolates requirements
# - prevents your system Python environment from breaking down
# system global environment:

    - python 2.7
    - pip2
    - other basic packages

virtualenv `name1`:

    - inherited and copy the system python environment
    - can contains specific packages not in system wide

virtualenv `name2`:

    - inherited and copy the system python environment
    - can have specific packages not in system and virtualenv `name1`

# Simple totorial
# reference: https://virtualenvwrapper.readthedocs.io/en/latest/

# Create new virtual environment
# This command will also automatically activate the newly created environment.
mkvirtualenv `name`

# Exit current virtualenv
deactivate

# Delete a virtualenv
rmvirtualenv `name`

# List the python packages in current virtualenv
# You can also use `pip list` if you have `pip` installed inside that virtualenv.
lssitepackages

# Toggle system packages visibility
toggleglobalsitepackages
```
- pycharm / vim / atom / sublime
- shadowsocks / vpn

> use free proxy for http

Shadowsocks is a very good application, it can help you surfe the internet without borden. my advice is just download the goole chrome and install the shadowsocks plugin inside chrome. after that you need shadowsocks account information, you can find free ones [here](http://www.dou-bi.com/sszhfx/). you may need to login to see the free account information, make sure update the account information in the chrome plugin every three days.

``` shell
# set git work with shadowsocks
git config --global http.proxy "socks5:127.0.0.1:8080"
git config --global https.proxy "socks5:127.0.0.1:8080"
```

# basic tutorial

+ [Google Docs](https://developers.google.com/edu/python/), a very simple guide.

+ [The Hitchhiker’s Guide to Python](http://docs.python-guide.org/en/latest/), learn code style and map of python libs.

# advance tutorial

+ [Python Memory Management](http://nodefe.com/implement-of-pymalloc-from-source/)

# web from scratch

Raw web materials:

+ [Web Network Basic Tutorial](./static/articles/web-network-basic-tutorial.md)

+ [HTTP TCP UDP](http://mp.weixin.qq.com/s?__biz=MzAxODI5ODMwOA==&mid=2666539211&idx=1&sn=629d1115b3992572d94b5d3e2295eb0f&scene=0)

+ [Simple Python Framework From Scratch](http://mattscodecave.com/posts/simple-python-framework-from-scratch.html)

Beginner's guide for web development.

+ [Let’s Build A Web Server. Part 1.](https://ruslanspivak.com/lsbaws-part1/)
+ [Let’s Build A Web Server. Part 2.](https://ruslanspivak.com/lsbaws-part2/)
+ [Let’s Build A Web Server. Part 3.](https://ruslanspivak.com/lsbaws-part3/)

# examples

1. A simple python game teach you what the good code is.
game online: [http://playtictactoe.org/](http://playtictactoe.org/), python demo [here](./static/demo/tic-tac-toe.py).


