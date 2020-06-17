# Container image that runs your code
FROM ubuntu:focal

# Setup the minimal requirements
RUN apt-get -y update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install git clang-format;

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
