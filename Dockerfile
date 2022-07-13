FROM ubuntu:20.04

WORKDIR /azp
USER root

# To make it easier for build and release pipelines to run apt,
# configure apt-get to not require confirmation (assume the -y argument by default)
ENV DEBIAN_FRONTEND=noninteractive

# Install libssl
COPY libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb ./
RUN dpkg -i libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb && rm libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb

# Install APT packages
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes && \
    echo "deb http://security.ubuntu.com/ubuntu xenial-security main" > /etc/apt/sources.list.d/libicu55.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    apt-get install -y apt-utils curl bash wget && \
    apt-get install -y --no-install-recommends apt-utils \
    ca-certificates \
    curl \
    jq \
    git \
    iputils-ping \
    libcurl4 \
    libicu55 \
    libunwind8 \
    netcat \
    gnupg2 \
    wget \
    apt-transport-https \
    unzip

# Copy startup file
COPY ./start.sh .
RUN chmod +x start.sh

# Agent command
CMD ["./start.sh"]
