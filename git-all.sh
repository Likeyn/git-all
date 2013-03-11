#!/usr/bin/env bash
# Bash script that uses find to trigger a git action
# on all subdirectories that contain a git repository
# except in folders that matches $IGN pattern

# Init
DIR='';
CMD='';
GIT='git';
IGN=( "*_ARCHIVES_*" "*vendor*" );

# Loop through first bash args to detect dirs
if [ $# -gt 0 ]; then
	for arg; do
		if [ -d $arg ]; then DIR="$DIR $arg"; shift;
		else break; fi;
	done;
	CMD=$@;
else
	echo "Usage: gall [dir=.] git_command";
	exit 1;
fi;

# Check if 'git-achievements' exists, and use it
# @link https://github.com/icefox/git-achievements
if command -v 'git-achievements' &> /dev/null; then GIT='git-achievements'; fi;

# Check if we have multiple folders to ignore
LEN=${#IGN[@]};
if [ $LEN -ge 2 ]; then
	find $DIR \( -path "${IGN[0]}" $(printf -- '-o -path %s ' "${IGN[@]:1}")\) -prune -o -type d -name .git -printf "\n---[\033[1;34m%h\033[0m]---\n" -execdir $GIT $CMD \;
elif [ $LEN -eq 1 ]; then
	find $DIR -path "${IGN[0]}" -prune -o -type d -name .git -printf "\n---[\033[1;34m%h\033[0m]---\n" -execdir $GIT $CMD \;
else
	find $DIR -type d -name .git -printf "\n---[\033[1;34m%h\033[0m]---\n" -execdir $GIT $CMD \;
fi;
echo -e "\n";
