# clang-format GitHub Action

[![License][license-img]][license-url]

[license-img]: https://img.shields.io/github/license/amete/clang-format-action.svg
[license-url]: https://github.com/amete/clang-format-action/blob/master/LICENSE

This repository holds a basic GitHub Action for running `clang-format`.

It primarily targets the [HSF/prmon](https://github.com/HSF/prmon) project.
However, it's generic enough to be used in any project and
created using the instructions detailed [here](https://help.github.com/en/actions/creating-actions/creating-a-docker-container-action).

In a nutshell, it creates a [Docker](https://www.docker.com/) container, based on `ubuntu:focal`,
with only `git` and `clang-format` installed on top of it.
Within the container, we go into the project directory,
run `clang-format` over all relevant files (with extension `c`,`cpp`,`cxx`,`h`,`hpp`),
commit and push the changes to the relevant branch (if needed).

## Inputs

### style

**Required** The name of the style to be used in formatting. Default is `Google`.

## Outputs

### message

The message containing information about the result of the action.

## Usage

```yml
# Name of the workflow
name: Clang-Format

# Controls when the action will run. Triggers the workflow on push for all branches
on: push

# Defines the main job where we checkout our code, run clang-format
# and commit changes
jobs:
  clang-format:
    runs-on: ubuntu-latest
    steps:
    # Checks-out our repository under $GITHUB_WORKSPACE, so our job can access it
    - uses: actions/checkout@v2

    # Applies clang-format to all C/C++ files w/ the specified style
    - name: Apply clang-format
      id: formatting
      uses: amete/clang-format-action@v0.2
      with:
        style: 'Google'

    # Gets and prints the output message
    - name: Get the output message
      run: echo "${{ steps.formatting.outputs.message }}"
```
