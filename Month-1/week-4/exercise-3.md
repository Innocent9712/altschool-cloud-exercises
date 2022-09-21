### Output of `git config -l`

```shell
innocent@innocent-HP-EliteBook-x360-1030-G2:~/Documents/coding files/altschool-cloud-exercises$ git config -l
user.name=Innocent Chukwuemeka
user.email=chukwuemeka140@gmail.com
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=git@gitlab.com:IamInnocent/altschool-cloud-exercises.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master
```


### Output of `git remote -v`

```shell
innocent@innocent-HP-EliteBook-x360-1030-G2:~/Documents/coding files/altschool-cloud-exercises$ git remote -v
origin	git@gitlab.com:IamInnocent/altschool-cloud-exercises.git (fetch)
origin	git@gitlab.com:IamInnocent/altschool-cloud-exercises.git (push)
```

### Output of `git log`

```shell
loud-exercises$ git log
commit 30cece56569920b7fc7b97e604e3c3a9cc51ca39 (HEAD -> master, origin/master)
Author: Innocent Chukwuemeka <chukwuemeka140@gmail.com>
Date:   Thu Sep 1 04:25:49 2022 +0100

    Add exercise 2 for week 2

commit af60200d5d048f876f5385319295511bf88f15c8
Author: Innocent Chukwuemeka <chukwuemeka140@gmail.com>
Date:   Thu Aug 25 14:27:48 2022 +0100

    Add tasks for week 2

commit 96a736c3f9e52edafcdd94208b3699ee485610ee
Author: Innocent Chukwuemeka <chukwuemeka140@gmail.com>
Date:   Thu Aug 25 12:58:38 2022 +0100

    Add Week 1 exercises

commit 948a223ef548c95f96450751fdb95d80792d3279
Author: Innocent Chukwuemeka <46821948+Innocent9712@users.noreply.github.com>
Date:   Thu Aug 25 10:53:19 2022 +0100

    Initial commit
```