build:
	docker-compose build terragrunt-azure-live-example

devcontainer:
	docker build -t terragrunt-azure-live-example:devcontainer -f .devcontainer/Dockerfile .devcontainer

run:
	docker-compose -f docker-compose.yml run terragrunt-azure-live-example

down:
	docker-compose -f docker-compose.yml down
