# Copy this file to .git/hooks/post-receive after updating the references
#!/bin/bash
TARGET="/srv/www-data/"
GIT_DIR="/srv/repositories/office.git"
BRANCH="main"

while read oldrev newrev ref
do
    # only checking out the master (or whatever branch you would like to deploy)
    if [[ $ref = refs/heads/$BRANCH ]];
    then
        echo "Ref $ref received. Deploying ${BRANCH} branch to production..."
        git --work-tree=$TARGET --git-dir=$GIT_DIR checkout -f
    else
        echo "Ref $ref received. Doing nothing: only the ${BRANCH} branch may be deployed on this server."
    fi
done
