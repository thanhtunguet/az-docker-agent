FROM ubuntu:18.04

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
    openssh-client

# Add Node.js
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    sh -c "curl -sL https://deb.nodesource.com/setup_13.x | bash -" && \
    apt-get update && \
    apt-get install nodejs yarn -y

# Add DotNET
RUN wget https://packages.microsoft.com/config/ubuntu/19.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install dotnet-sdk-3.1 -y

# Install Docker Compose
RUN apt-get install docker-compose -y

# Copy startup file
COPY ./start.sh .
RUN chmod +x start.sh

# Agent command
CMD ["./start.sh"]
