#!/bin/sh -l
set -e

#cd /tmp

## Setup
#if [ -z "$CXX" ]; then
#    CXX=$(type -p g++)
#fi
#if [ -z "$CC" ]; then
#	CC=$(type -p gcc)
#fi
#if [ -z "$CMAKE" ]; then
#	CMAKE=$(type -p cmake)
#fi

## Configure 
#cmd="$CMAKE -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_C_COMPILER=$CC $CMAKE_EXTRA $GITHUB_WORKSPACE"
#echo $cmd
#$cmd

## Run clang-format
#make clang-format
cd "$GITHUB_WORKSPACE"
clang-format -style=Google -i src/hello_world.cxx

# Go to the directory
#cd "$GITHUB_WORKSPACE"

# Configure the author
echo ">> Configuring the author"
git config --global user.email "clang-format@github-actions"
git config --global user.name "clang-format"

# Commit the changes
echo ">> Committing the changes"
git commit -a -m "Apply clang-format" || true

# Print some information
echo "$GITHUB_EVENT_PATH"
echo "$GITHUB_REF"

# Push to the branch
BRANCH=${GITHUB_REF#*refs/pull/}
echo ">> Pushing to $BRANCH"
git push -u origin $BRANCH
