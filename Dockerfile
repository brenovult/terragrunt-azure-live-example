# .devcontainer/
FROM terragrunt-azure-live-example:devcontainer

# Work directory	
WORKDIR /usr/src/app

# Bundle app source	
COPY . .
