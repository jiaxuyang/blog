#!/bin/sh
git filter-branch --env-filter '
OLD_EMAIL="jiaxuyang.i@dcarlife.com"
CORRECT_NAME="jiaxuyang"
CORRECT_EMAIL="xuyang.jia@gmail.com"
if ( "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ) then
  export GIT_COMMITTER_NAME="$CORRECT_NAME"
  export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if ( "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ) then
  export GIT_AUTHOR_NAME="$CORRECT_NAME"
  export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
'