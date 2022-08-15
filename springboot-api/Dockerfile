FROM debian:bullseye

ENV PARAM_VERBOSE=true
ENV PARAM_DEBUG=false
ENV WORKSPACE_SSH_DIRECTORY_PATH=/etc/ssh
ENV PARAM_USER_HOME=/home/eagle
ENV WORKSPACE_DIRECTORY_PATH=/home/eagle/src
ARG PARAM_APP_NAME
ARG PARAM_PRIMARY_DOMAIN
ARG PARAM_SPRINGBOOT_VERSION

USER root

# Install jq and create an SSH mock directory
RUN   useradd -m -s /bin/bash eagle && \
      mkdir -p /home/eagle/src && chown -R eagle:eagle /home/eagle && \
      apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update && apt-get install jq git curl unzip -y && \
      yes 'y' | /usr/bin/ssh-keygen -q -N '' -t rsa -f /etc/ssh/id_rsa && \
      chown eagle /etc/ssh/id_rsa

ADD src/* /tmp/.

RUN chmod 755 /tmp/boot.sh && chmod 644 /tmp/*.json

USER eagle
WORKDIR /home/eagle/src
RUN /tmp/boot.sh /tmp/x1.json
