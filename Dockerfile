# Start with node
FROM circleci/node:8.12.0

USER root

# Install Python and other common deps

RUN apt-get update && apt-get install -y jq python-pip python-dev \
  && rm -rf /var/lib/apt/lists/*

# Install node-prune

RUN curl -sfL https://install.goreleaser.com/github.com/tj/node-prune.sh | bash

# Install Terraform

ENV TERRAFORM_VERSION 0.11.11

RUN wget -q -O /terraform.zip "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
  unzip /terraform.zip -d /bin 

RUN pip install --upgrade pip && \
  pip install --upgrade awscli

RUN rm -rf /terraform.zip /var/tmp/* /tmp/*

USER circleci
