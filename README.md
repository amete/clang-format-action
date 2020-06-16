# clang-format GitHub Action for the HSF/prmon project

This repository holds a basic GitHub Action for running clang-format
for the [HSF/prmon](https://github.com/HSF/prmon) project.
It's created using the instructions detailed [here](https://help.github.com/en/actions/creating-actions/creating-a-docker-container-action).

In a nutshell, it creates a [Docker](https://www.docker.com/) container, based on `ubuntu:latest`,
where necessary tools (cmake, clang etc.) as well as [nlohmann/json](https://github.com/nlohmann/json) are installed.

Within the container, `prmon` is cloned, `make clang-format`
is run and changes (if any) are pushed to the relevant branch.

## Usage

```yml
# Name of the workflow
name: Clang-Format

# Controls when the action will run. Triggers the workflow on push for all branches
on: push

# Defines the main job where we checkout our code, run clang-format and commit changes
jobs:
  clang-format:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: amete/clang-format-action@v0.1
```
