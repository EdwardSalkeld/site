.PHONY: help docker-build build serve clean

IMAGE_NAME=site-hugo
IMAGE_TAG=latest

help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

docker-build: ## Build the Hugo Docker image
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .

build: docker-build ## Build the Hugo site using Docker
	docker run --rm -v $(PWD)/hugo-site:/src $(IMAGE_NAME):$(IMAGE_TAG) hugo

serve: docker-build ## Serve the Hugo site locally on http://localhost:1313 using Docker
	docker run --rm -it -v $(PWD)/hugo-site:/src -p 1313:1313 $(IMAGE_NAME):$(IMAGE_TAG) hugo server --bind 0.0.0.0

clean: ## Clean build artifacts
	rm -rf hugo-site/public hugo-site/resources

clean-all: clean ## Clean build artifacts and Docker image
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG) 2>/dev/null || true
