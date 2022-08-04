FROM node:lts-bullseye

ENV PARAM_VERBOSE=true
ENV PARAM_DEBUG=false
ENV WORKSPACE_SSH_DIRECTORY_PATH=/etc/ssh
ENV PARAM_USER_HOME=/home/eagle
ENV WORKSPACE_DIRECTORY_PATH=/home/eagle/src
ARG PARAM_APP_NAME

USER root
ADD src/oidc.sh /tmp/oidc.sh

# Sets up 'eagle' user area
RUN chmod 755 /tmp/oidc.sh && \
      useradd -m -s /bin/bash eagle && \
      mkdir -p /home/eagle/src && git init /home/eagle/src --initial-branch main && \
      chown -R eagle:eagle /home/eagle 

# Install jq and create an SSH mock directory
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && apt-get install jq -y && \
    yes 'y' | /usr/bin/ssh-keygen -q -N '' -t rsa -f /etc/ssh/id_rsa && \
      chown eagle /etc/ssh/id_rsa

RUN npm install --location=global @angular/cli

USER eagle
RUN /tmp/oidc.sh

WORKDIR /home/eagle/src