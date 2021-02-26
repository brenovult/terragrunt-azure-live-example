build:
	docker-compose -f docker-compose.yml build

devcontainer:
	docker build -t terragrunt-azure-live-example:devcontainer -f .devcontainer/Dockerfile .devcontainer/

azure-pipelines:
	docker build -t terragrunt-azure-live-example:azure-pipelines -f .azure-pipelines/Dockerfile .azure-pipelines/

run:
	docker-compose -f docker-compose.yml run terragrunt-azure-live-example

run-k8s:
	docker-compose -f docker-compose.yml -f src/prd/kubernetes/configuration/docker-compose.override.yml run terragrunt-azure-live-example

run-k8s-datadog:
	docker-compose -f docker-compose.yml -f src/prd/kubernetes/configuration/datadog/docker-compose.override.yml run terragrunt-azure-live-example

down:
	docker-compose -f docker-compose.yml down

fmt:
	terraform fmt -recursive && terragrunt hclfmt -recursive
