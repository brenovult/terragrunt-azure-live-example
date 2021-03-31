build:
	docker-compose -f docker-compose.yaml build

devcontainer:
	docker build -t terragrunt-azure-live-example:devcontainer -f .devcontainer/Dockerfile .devcontainer/

azure-pipelines:
	docker build -t terragrunt-azure-live-example:azure-pipelines -f .azure-pipelines/Dockerfile .azure-pipelines/

run:
	docker-compose -f docker-compose.yaml run terragrunt-azure-live-example

run-k8s:
	docker-compose -f docker-compose.yaml -f src/prd/kubernetes/configuration/docker-compose.override.yaml run terragrunt-azure-live-example

run-k8s-datadog:
	docker-compose -f docker-compose.yaml -f src/prd/kubernetes/configuration/datadog/docker-compose.override.yaml run terragrunt-azure-live-example

down:
	docker-compose -f docker-compose.yaml down

fmt:
	terraform fmt -recursive && terragrunt hclfmt -recursive
