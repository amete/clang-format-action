# Container image that runs your code
FROM ubuntu:latest

# Setup the minimal requirements
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y update && \
    apt-get -y install git \
    cmake extra-cmake-modules \
    clang clang-format clang-tidy;

# Dowload and install nlohmann/json
RUN mkdir -p /home/root && cd /home/root && \
    git clone --single-branch --branch v3.8.0 https://github.com/nlohmann/json.git && \
    mkdir -p json/build && cd json/build && \
    cmake .. && cmake --build . && make install;

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
