# content

* [tools](#tools)
* [python guide](#basic-tutorial)
* [enhance reading](#advance-tutorial)
* [python web starter](#web-from-scratch)
* [examples](#examples)

# platform

suppose you:

- familiar with terminal, like gnome-terminal or mac osx iterm2.
- can use google and stackoverflow or know bing search engine.

# tools

**about terminal**:

- zsh / oh-my-zsh
- git

> install git

``` shell
#!/usr/local/bin/zsh
# fedora 23 using apt-get if ubuntu user
sudo dnf install git

# clone repo from github using ssh
# https://help.github.com/articles/generating-an-ssh-key/
# use ssh can help you out of entering password every time you push the code
git clone git@github.com:smileboywtu/python-enhance.git

# git pull
# get the newest code from remote repo
git pull

# git push
# push the local code to remote
git push

# for other help find more docs on google or just use git -h for help description
git -h
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
# install virtualenv
sudo pip install virtualenv

# install virtualenvwrapper, a simple tool to manage virtual env
sudo pip install virtualenvwrapper

# config virtualenvwrapper with zsh
# add this lines to your .zshrc or .bashrc
export WORK_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
source /usr/bin/virtualenvwrapper.sh

# understand why use virtualenv
# specific environment for a project that do not broke the system basic environment.
system global environment:

    - python 2.7
    - pip2
    - other basic packages

virtualenv `name1`:

    - inherited and copy the system python environment
    - can contains specific packages not in system wide

virtualenv `name2`:

    - inherited and copy the system python environment
    - can have specific packages not in system and virtualenv `name1`

# simple totorial
# reference: https://virtualenvwrapper.readthedocs.io/en/latest/

# create new virtual environment
# this command will automatically shift to the new env
mkvirtualenv `name`

# exit current virtualenv
deactivate

# delete a virtualenv
rmvirtualenv `name`

# list the python packages in current virtualenv
lssitepackages

# toggle system packages
toggleglobalsitepackages
```
- pycharm / vim / atom / sublime
- shadowsocks / vpn

> use free proxy for http

shadowsocks is a very good apps, it can help you surfe the internet without borden. my advice is just download the goole chrome and install the shadowsocks plugin inside chrome. after that you need shadowsocks account information, you can find free ones [here](http://www.dou-bi.com/sszhfx/). you may need to login to see the free account information, make sure update the account information in the chrome plugin every three days.

``` shell
# set git work with shadowsocks
git config --global http.proxy "socks5:127.0.0.1:8080"
git config --global https.proxy "socks5:127.0.0.1:8080"
```

# basic tutorial

+ [google docs](https://developers.google.com/edu/python/), a very simple guide.

+ [The Hitchhiker’s Guide to Python](http://docs.python-guide.org/en/latest/), learn code style and map of python libs.

# advance tutorial

+ [python memory management](http://nodefe.com/implement-of-pymalloc-from-source/)

# web from scratch

+ [Let’s Build A Web Server. Part 1.](https://ruslanspivak.com/lsbaws-part1/)
+ [Let’s Build A Web Server. Part 2.](https://ruslanspivak.com/lsbaws-part2/)
+ [Let’s Build A Web Server. Part 3.](https://ruslanspivak.com/lsbaws-part3/)

# examples

1. a simple python game teach you what the good code is.
game online: [http://playtictactoe.org/](http://playtictactoe.org/), python demo [here](./static/demo/tic-tac-toe.py).


