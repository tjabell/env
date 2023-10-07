#!/usr/bin/env bash
# Usage ./create-git-repository-on-source.sh projects/gsi-regression-tests
# Then set origin to https://source.trevorabell.me/git/projects/gsi-regression-tests.git
REPO=$1

if [ -z "$REPO" ]
then
    echo 'Repository name required'
    exit
fi

if [[ "$REPO" == *.git ]]
then
    echo ""
else
    echo 'Repository must end with .git'
    exit
fi


echo "Creating $REPO"
ssh -t source "./make-repository.sh $REPO"
