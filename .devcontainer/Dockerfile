FROM terragrunt-azure-live-example:azure-pipelines
RUN apk add --update --no-cache

# Terraform - https://releases.hashicorp.com/terraform/
ENV TERRAFORM_VERSION=0.12.29
ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /
RUN unzip -d /usr/local/bin/ /terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm /terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    chmod +x /usr/local/bin/terraform

# Terragrunt - https://github.com/gruntwork-io/terragrunt/releases
ENV TERRAGRUNT_VERSION=0.23.31
ADD https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 /usr/local/bin/terragrunt
RUN chmod +x /usr/local/bin/terragrunt

# Azure CLI - https://github.com/Azure/azure-cli/releases
ENV AZURE_CLI_VERSION=2.15.0
RUN apk add py-pip && \
    apk add --virtual=build gcc libffi-dev musl-dev openssl-dev make python3-dev linux-headers && \
    pip --no-cache-dir install azure-cli==${AZURE_CLI_VERSION}
