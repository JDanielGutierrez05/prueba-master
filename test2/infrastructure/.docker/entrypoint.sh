#!/bin/bash

COLOR_RED=$(tput setaf 1)
COLOR_GREEN=$(tput setaf 2)
COLOR_BLUE=$(tput setaf 4)
COLOR_YELLOW=$(tput setaf 3)
COLOR_DEFAULT=$(tput sgr0)

EXEC_PATH=$(dirname $(readlink -f "$0"))
HOME_PATH=$EXEC_PATH/..

GIT_SCRIPT_PATH=$HOME_PATH/../.docker/git.sh
chmod +x $GIT_SCRIPT_PATH
. $GIT_SCRIPT_PATH

chmod +x $HOME_PATH/../.docker/aws.sh
echo "INFO: Execute permissions given to $HOME_PATH/../.docker/aws.sh file."
$HOME_PATH/../.docker/aws.sh

echo "$COLOR_DEFAULT"
