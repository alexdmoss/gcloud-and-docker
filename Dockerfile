FROM python:3.12-slim

RUN apt-get update && \
  apt-get --quiet --no-install-recommends --yes install \
  apt-transport-https \
  ca-certificates \
  build-essential \
  software-properties-common \
  curl \
  gettext-base \
  gnupg2 \
  less \
  openssh-client \
  shellcheck \
  unzip \
  make \
  wget && \
  rm -rf /var/lib/apt/lists/*

# docker
RUN install -m 0755 -d /etc/apt/keyrings && \
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
chmod a+r /etc/apt/keyrings/docker.asc

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update
RUN apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# gcloud
ENV PATH=$PATH:/usr/local/google-cloud-sdk/bin
ARG GCLOUD_VERSION=512.0.0
RUN wget --no-verbose -O /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
    tar -C /usr/local --keep-old-files -xz -f /tmp/google-cloud-sdk.tar.gz && \
    gcloud config set --installation component_manager/disable_update_check true && \
    gcloud config set --installation core/disable_usage_reporting true && \
    gcloud components install beta --quiet && \
    gcloud components install kubectl --quiet && \
    gcloud components install kustomize --quiet && \
    rm -f /tmp/google-cloud-sdk.tar.gz && \
    rm -rf /usr/local/google-cloud-sdk/.install/.backup && \
    find /usr/local/google-cloud-sdk -type d -name __pycache__ -exec rm -r {} \+
