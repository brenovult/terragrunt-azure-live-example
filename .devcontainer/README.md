# devcontainer

[Parent image](https://docs.docker.com/develop/develop-images/baseimages/) and [development container](https://code.visualstudio.com/docs/remote/containers) pre-installed with the following software.
  - Alpine (3.12.0)
   - git
  - Terraform (0.12.29)
  - Terragrunt (0.23.31)
  - Azure CLI (2.15.0)

## Build
```
docker build -t terragrunt-azure-live-example:devcontainer .
```
