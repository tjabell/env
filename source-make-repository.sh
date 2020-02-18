#!/usr/bin/env bash
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
echo 'would have created repo'
#ssh -t source "./make-repository.sh $REPO"
