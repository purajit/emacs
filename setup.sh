#! /bin/sh
REPO_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $REPO_HOME
git submodule update --init --recursive
rm -rf $REPO_HOME/prelude/personal && ln -s $REPO_HOME/personal $REPO_HOME/prelude/personal
