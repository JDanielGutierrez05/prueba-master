######## BASE IMAGE ########
FROM node:20-bullseye-slim AS img-base

# Arguments
ARG USER=test2master
ARG USER_HOME=/home/$USER
ARG VOLUME=/app
ARG SHELL=/bin/bash

RUN apt-get update
RUN npm install -g npm

# Inital OS configuration
RUN apt-get install -y locales \
    && sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
    && locale-gen
RUN apt-get install -y sudo lsb-release git git-lfs curl zip unzip jq
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip

# Install VSCode extensions dependencies
RUN apt-get install -y pylint3
RUN pip3 install cfn-lint cfn-lint-serverless

# Install Database utilities
RUN pip3 install yoyo-migrations pymysql

# Install CLI utilities
# Using this line to install on computers with x86_64 processors
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && apt-get install -y less

# Install Serverless framework + plugins
RUN npm install -g serverless@3.38.0 --unsafe
RUN npm install -g serverless-deployment-bucket
RUN npm install -g @serverless/safeguards-plugin

# Set up non root user
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN useradd -ms $SHELL $USER
RUN mkdir -p $VOLUME \
    && chown -R $USER:$USER $VOLUME
RUN sudo chown -R $USER /usr/local/lib/

# Preserve bash history
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && echo $SNIPPET >> "/root/.bashrc" \
    && mkdir /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R $USER /commandhistory \
    && echo $SNIPPET >> "$USER_HOME/.bashrc"


######## INFRASTRUCTURE IMAGE ########
FROM img-base AS img-infrastructure
USER $USER
