#!/bin/sh
git filter-branch -f --commit-filter '
                GIT_AUTHOR_NAME="jiaxuyang";
                GIT_AUTHOR_EMAIL="xuyang.jia@gmail.com";
                GIT_COMMITTER_NAME="jiaxuyang";
                GIT_COMMITTER_EMAIL="xuyang.jia@gmail.com";
                git commit-tree "$@";' HEAD
