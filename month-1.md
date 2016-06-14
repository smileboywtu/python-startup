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

shadowsocks is a very good apps, it can help surfe the intenet without borden. my advice is just download the goole chrome and install the shadowsocks plugin inside chrome. after that you need shadowsocks account information, you can find free ones [here](http://www.dou-bi.com/sszhfx/). you may need to login to see the free account information, make sure update the account information in the chrome plugin every three days.

``` shell
# set git work with shadowsocks
git config --global http.proxy "socks5:127.0.0.1:8080"
git config --global https.proxy "socks5:127.0.0.1:8080"
```

# basic tutorial

+ [google docs](https://developers.google.com/edu/python/), a very simple guide.

+ [The Hitchhiker’s Guide to Python](http://docs.python-guide.org/en/latest/), learn code style and map of python libs.

# understand example

a simple python game teach you what the good code is.
game online: [http://playtictactoe.org/](http://playtictactoe.org/)

``` python
# Tic-Tac-Toe
# Plays the game of tic-tac-toe against a human opponent

# global constants
X = "X"
O = "O"
EMPTY = " "
TIE = "TIE"
NUM_SQUARES = 9


def display_instruct():
    """Display game instructions."""
    print(
    """
    Welcome to the greatest intellectual challenge of all time: Tic-Tac-Toe.
    This will be a showdown between your human brain and my silicon processor.

    You will make your move known by entering a number, 0 - 8.  The number
    will correspond to the board position as illustrated:

                    0 | 1 | 2
                    ---------
                    3 | 4 | 5
                    ---------
                    6 | 7 | 8

    Prepare yourself, human.  The ultimate battle is about to begin. \n
    """
    )


def ask_yes_no(question):
    """Ask a yes or no question."""
    response = None
    while response not in ("y", "n"):
        response = input(question).lower()
    return response


def ask_number(question, low, high):
    """Ask for a number within a range."""
    response = None
    while response not in range(low, high):
        response = int(input(question))
    return response


def pieces():
    """Determine if player or computer goes first."""
    go_first = ask_yes_no("Do you require the first move? (y/n): ")
    if go_first == "y":
        print("\nThen take the first move.  You will need it.")
        human = X
        computer = O
    else:
        print("\nYour bravery will be your undoing... I will go first.")
        computer = X
        human = O
    return computer, human


def new_board():
    """Create new game board."""
    board = []
    for square in range(NUM_SQUARES):
        board.append(EMPTY)
    return board


def display_board(board):
    """Display game board on screen."""
    print("\n\t", board[0], "|", board[1], "|", board[2])
    print("\t", "---------")
    print("\t", board[3], "|", board[4], "|", board[5])
    print("\t", "---------")
    print("\t", board[6], "|", board[7], "|", board[8], "\n")


def legal_moves(board):
    """Create list of legal moves."""
    moves = []
    for square in range(NUM_SQUARES):
        if board[square] == EMPTY:
            moves.append(square)
    return moves


def winner(board):
    """Determine the game winner."""
    WAYS_TO_WIN = ((0, 1, 2),
                   (3, 4, 5),
                   (6, 7, 8),
                   (0, 3, 6),
                   (1, 4, 7),
                   (2, 5, 8),
                   (0, 4, 8),
                   (2, 4, 6))

    for row in WAYS_TO_WIN:
        if board[row[0]] == board[row[1]] == board[row[2]] != EMPTY:
            winner = board[row[0]]
            return winner

    if EMPTY not in board:
        return TIE

    return None


def human_move(board, human):
    """Get human move."""
    legal = legal_moves(board)
    move = None
    while move not in legal:
        move = ask_number("Where will you move? (0 - 8):", 0, NUM_SQUARES)
        if move not in legal:
            print("\nThat square is already occupied, foolish human.  Choose another.\n")
    print("Fine...")
    return move


def computer_move(board, computer, human):
    """Make computer move."""
    # make a copy to work with since function will be changing list
    board = board[:]
    # the best positions to have, in order
    BEST_MOVES = (4, 0, 2, 6, 8, 1, 3, 5, 7)

    print("I shall take square number", end=" ")

    # if computer can win, take that move
    for move in legal_moves(board):
        board[move] = computer
        if winner(board) == computer:
            print(move)
            return move
        # done checking this move, undo it
        board[move] = EMPTY

    # if human can win, block that move
    for move in legal_moves(board):
        board[move] = human
        if winner(board) == human:
            print(move)
            return move
        # done checkin this move, undo it
        board[move] = EMPTY

    # since no one can win on next move, pick best open square
    for move in BEST_MOVES:
        if move in legal_moves(board):
            print(move)
            return move


def next_turn(turn):
    """Switch turns."""
    if turn == X:
        return O
    else:
        return X


def congrat_winner(the_winner, computer, human):
    """Congratulate the winner."""
    if the_winner != TIE:
        print(the_winner, "won!\n")
    else:
        print("It's a tie!\n")

    if the_winner == computer:
        print("As I predicted, human, I am triumphant once more.  \n" \
              "Proof that computers are superior to humans in all regards.")

    elif the_winner == human:
        print("No, no!  It cannot be!  Somehow you tricked me, human. \n" \
              "But never again!  I, the computer, so swear it!")

    elif the_winner == TIE:
        print("You were most lucky, human, and somehow managed to tie me.  \n" \
              "Celebrate today... for this is the best you will ever achieve.")


def main():
    display_instruct()
    computer, human = pieces()
    turn = X
    board = new_board()
    display_board(board)

    while not winner(board):
        if turn == human:
            move = human_move(board, human)
            board[move] = human
        else:
            move = computer_move(board, computer, human)
            board[move] = computer
        display_board(board)
        turn = next_turn(turn)

    the_winner = winner(board)
    congrat_winner(the_winner, computer, human)


# start the program
main()
input("\n\nPress the enter key to quit.")
```
