git-all
=======

Run git commands on (possibly multiple) repositories

Specify directly a git repository to run commands on it without leaving your current one, or give the path to a folder to run the command on all subfolders that contain a git repository.

```shell
# Run the git-fetch -vp command on all git repositories in ~/Github
$ git-all ~/Github/ fetch -vp
```
