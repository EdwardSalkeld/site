.PHONY: help build serve clean

help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

build: ## Build the Hugo site using Docker
	docker run --rm -v $(PWD)/hugo-site:/src klakegg/hugo:0.111.3-alpine

serve: ## Serve the Hugo site locally on http://localhost:1313 using Docker
	docker run --rm -it -v $(PWD)/hugo-site:/src -p 1313:1313 klakegg/hugo:0.111.3-alpine server --bind 0.0.0.0

serve-original: ## Serve the original HTML site on http://localhost:8000
	@echo "Serving original HTML site at http://localhost:8000"
	@cd html && python3 -m http.server 8000

clean: ## Clean build artifacts
	rm -rf hugo-site/public hugo-site/resources
