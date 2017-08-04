#!/bin/bash -e
# deploy script for a jekyll blog
# heavily based on: https://gist.github.com/domenic/ec8b0fc8ab45f39403dd
# this script pushes a post-build directory to a different branch, this is useful for deploying
# to a gh-pages branch

# set your build information here, the script will take care of anything else
SOURCE_BRANCH="source"
TARGET_BRANCH="master"
DIRECTORY="_site"
GH_REF="github.com/codeweeksi/codeweek.si"
GH_USERNAME="Travic CI"
GH_USERMAIL="deploy@travis-ci.org"

# set your build commands here
function doCompile {
  jekyll build
  # this is a CNAME record for the subdomain, you might not need this. So comment it out
  echo "codeweek.si" > _site/CNAME
}

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    doCompile
    exit 0
fi

# Save some useful information
REPO=`git config https://$GH_TOKEN@github.com/codeweeksi/codeweek.si.git`
SHA=`git rev-parse --verify HEAD`

# Clone the existing gh-pages for this repo into _site/
# Create a new empty branch if gh-pages doesn't exist yet (should only happen on first deploy)
git clone $REPO $DIRECTORY
cd $DIRECTORY
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH
cd ..

# Clean out existing contents
rm -rf $DIRECTORY/**/* || exit 0

# Run our compile script
doCompile

# Now let's go have some fun with the cloned repo
cd $DIRECTORY
git config user.name $GH_USERNAME
git config user.email $GH_USERMAIL

# Add new files
git add .

# If there are no changes to the compiled _site (e.g. this is a README update) then just bail.
if [[ -z `git diff --cached --exit-code` ]]; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

# Commit the "changes", i.e. the new version.
git commit -a -m "Deployed to GitHub Pages using Travis-CI: ${SHA}"

# Now that we're all set up, we can push with the token
git push -f "https://${GH_TOKEN}@${GH_REF}" ${TARGET_BRANCH} > /dev/null 2>&1