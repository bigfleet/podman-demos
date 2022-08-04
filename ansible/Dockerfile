FROM python:bullseye

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
ADD scripts/* /usr/src/

RUN /usr/src/pysetup.sh && \ 
    /usr/src/get_helm.sh && \
    /usr/src/flux2_install.sh && \
    /usr/src/install_kubectl.sh