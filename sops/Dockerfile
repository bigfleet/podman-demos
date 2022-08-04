FROM ruby:2-bullseye

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN wget https://github.com/mozilla/sops/releases/download/v3.7.1/sops_3.7.1_amd64.deb && \
        apt-get install -f ./sops_3.7.1_amd64.deb