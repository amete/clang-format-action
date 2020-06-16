#!/bin/sh -l
set -e

# Setup
if [ -z "$CXX" ]; then
    CXX=$(type -p g++)
fi
if [ -z "$CC" ]; then
	CC=$(type -p gcc)
fi
if [ -z "$CMAKE" ]; then
	CMAKE=$(type -p cmake)
fi

# Configure cmake from /tmp
echo ">> Running the cmake configuration"
cd /tmp
cmd="$CMAKE -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_C_COMPILER=$CC $CMAKE_EXTRA $GITHUB_WORKSPACE"
echo $cmd
$cmd

# Run clang-format target
make clang-format

# Go to the directory
cd $GITHUB_WORKSPACE

# Configure the author
echo ">> Configuring the author"
git config --global user.email "clang-format@github-actions"
git config --global user.name "clang-format"

# Commit the changes
echo ">> Committing the changes"
git commit -a -m "Apply clang-format" || true

# Push to the branch
BRANCH=${GITHUB_REF#*refs/head/}
echo ">> Pushing to $BRANCH"
git push -u origin $BRANCH
