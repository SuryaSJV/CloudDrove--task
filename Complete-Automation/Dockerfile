FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    unzip \
    software-properties-common \
    apt-transport-https \
    lsb-release \
    ca-certificates

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Create workspace directory
RUN mkdir /workspace
WORKDIR /workspace

# Default command
#CMD [ "bash" ]
CMD ["/bin/bash", "-c", "if ls /workspace/*.tf > /dev/null 2>&1; then terraform init && terraform apply -auto-approve; else bash; fi"]
