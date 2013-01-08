#!/bin/bash
# Bash script that uses find to trigger a git action
# on all subdirectories that contain a git repository
# except in folders that matches $IGN pattern

# Init
DIR='';
CMD='';
IGN='*_ARCHIVES_*';

if [ $# -gt 0 ]; then
  # Loop through first bash args to detect dirs
	for arg; do
		if [ -d $arg ]; then DIR="$DIR $arg"; shift;
		else break; fi;
	done;
	CMD=$@;
else
	echo "Usage: gall [dir=.] git_command";
	exit 1;
fi;

find $DIR -path "$IGN" -prune -o -type d -name .git -printf "\n---[\033[1;34m%h\033[0m]---\n" -execdir git --no-pager $CMD \;
echo -e "\n";