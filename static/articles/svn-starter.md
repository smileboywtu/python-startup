# Content

- [svn vs git](#svn-vs-git)
-  [svn starter](#svn-starter)

# svn vs git

many people now just learn the git, the old days people just use svn. svn and git are both version control tool for develop project. but there are some difference between them.

+ git hold difference branches inside the same directory, but svn hold separate directory for different branch.
+ subprojects in svn will keep update automatically but not git does.
+ SVN is configured to assume that the history of a project never changes. Git allows you to modify previous commits and changes using tools like `git rebase`.
+ git allow you to control the repo offline but not svn does.
+ in git one repo is one project, svn can hold several projects inside one repo.
+ in git you can copy, delete, move file using system command, but svn use svn command to do it.

# svn starter

provide simple usage of the svn version control system.

use `svnadmin` command to manage the svn repository.

``` shell
svnadmin create /path/to/your/repo
```

after you have create your repository, you can now add your project to repo(here we create a local repo and add mytree project to it).

``` shell
svn import mytree file:///var/svn/newrepos/some/project -m "Initial import"
```

you can view the files after you `svn import` your projec.
``` shell
snv list file:///var/svn/newrepos/some/project
```

when you add your project to repo, your local project dir do not convert to a copy version from repo, you should use `svn checkout` to make it a copy in a separate dir.
``` shell
svn checkout file:///var/svn/newrepos/some/project dist
```

## basic workflow using svn

we assume you have a copy version of your project:

1. update your copy with remote
    - `svn update`
2. develop on the copy
    - `svn add` to add a new file for dir
    - `svn delete` remove file or dir
    - `svn copy` copy file or dir
    - `svn move` move file or dir
    - `svn mkdir` create and add new dir
3. check your work before commit
    - `svn status` show all file status
    -  `svn diff` show item difference between two version
4. cancel some modify
    - `svn revert`
5. handle merge conflicts
    - `svn update`
    - `svn resolve`
6. commit your work
    - `svn commit`

when you use the `svn status` to show all status, you need to understand the flag:

| flag | indicate |
|:----:|:--------:|
|M|item is modified|
|D|item is deleted in version system|
|C|conflicts happens inside item|
|A|new added item|

## resolve conflicts

several member may do different modify on the same file inside your team group.

before you commit your work, you can manually predict conflicts use `svn status -u -r`, this command will connect to the system version system to fetch updates.

**1**. update before commit

``` shell
svn update
```

**2**. resove conflicts

conflicts can be handled in interactive way or you can use `p` command to handle it later.

   - **(p)ostpone**: keep conflicts status after update
   - **(d)iff**: show difference
   - **(e)dit**: edit the conflicts
   - **(r)esolved**: notify svn server conflict resolved afrer edit
   - **(m)ine-(f)ull**: keep changes from server
   - **(t)heirs-(f)ull**: keep local changes
   - **(l)aunch**: launch a extern program to handle conflicts
   - **(h)elp**: show help message

when you use `p` command to handle conflict, the system will create another three files in your dir:
    - **filename.mine**: hold local changes(working file)
    - **filename.rolderversion**: hold base version
    - **filename.rnewversion**: hold server version

**3**. commit your change

after you have resolve conflicts, you have to tell svn the file accepted

``` shell
svn resolve --accept working|theirs-fll filename
svn commit -m 'commit message'
```

# other helpful command

use `svn cat` to show the content of a old version:

``` shell
svn cat -r version file
```

use `svn list` to list project tree

```shell
svn list http://svn.collab.net/repos/svn
```

use `svn log` to show the modify on a version

``` shell
svn log -r version[:reverion] -v
```
