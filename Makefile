build:
	docker-compose -f docker-compose.yml build

devcontainer:
	docker build -t terragrunt-azure-live-example:devcontainer -f .devcontainer/Dockerfile .devcontainer

run:
	docker-compose -f docker-compose.yml run terragrunt-azure-live-example

run-k8s:
	docker-compose -f docker-compose.yml -f docker-compose.override.yml run terragrunt-azure-live-example

down:
	docker-compose -f docker-compose.yml down

fmt:
	terraform fmt -recursive && terragrunt hclfmt -recursive
