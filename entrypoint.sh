#!/bin/sh

# docker build . -t test
# docker run --rm --env GH_TOKEN=$GH_TOKEN --env MILESTONES_NAME="v0.31.0" test

echo 'Generating changelogs for Meilisearch'...
./$RELEASE_GENERATOR_BIN > release_file

echo "Creating the PR"
changelog_file="meilisearch-release-changelogs/$MILESTONES_NAME.md"
branch="changelog-$MILESTONES_NAME"
repo="curquiza/core-team"

git config --global user.email "robot@meilisearch.com"
git config --global user.name "Meili-bot"
git clone "https://github.com/$repo.git"
cd core-team
git checkout -b $branch
cp ../release_file $changelog_file
git add $changelog_file
git status
git commit -m "Create changelog file for $MILESTONES_NAME"
git push "https://$GH_TOKEN@github.com/$repo.git"

# Authentication made with en var GH_TOKEN
gh pr create --title "The bug is fixed" --body "Everything works again" --base "main" --head $branch

