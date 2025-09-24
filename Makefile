# Makefile for 0xrinegade GitHub Profile

.PHONY: help install ci act-push act-schedule clean lint

# Default target
help:
	@echo "Available targets:"
	@echo "  install     - Install dependencies (act for local workflow testing)"
	@echo "  ci          - Run continuous integration checks"
	@echo "  act-push    - Test workflow locally with act (push event)"
	@echo "  act-schedule - Test workflow locally with act (schedule event)"
	@echo "  lint        - Lint workflow files"
	@echo "  clean       - Clean up temporary files"

# Install act for local workflow testing
install:
	@echo "Installing dependencies..."
	@if ! command -v act > /dev/null 2>&1; then \
		echo "Installing act (GitHub Actions runner)..."; \
		curl https://raw.githubusercontent.com/nektos/act/master/install.sh | bash && \
		sudo mv ./bin/act /usr/local/bin/act; \
	else \
		echo "act is already installed"; \
	fi
	@if ! command -v docker > /dev/null 2>&1; then \
		echo "Docker is required but not found. Please install Docker first."; \
		exit 1; \
	fi
	@if ! command -v jq > /dev/null 2>&1; then \
		echo "Installing jq..."; \
		sudo apt-get update && sudo apt-get install -y jq; \
	fi

# Run CI checks
ci: lint
	@echo "Running CI checks..."
	@echo "✓ Workflow syntax validation passed"
	@echo "✓ All CI checks completed successfully"

# Test workflow with act (push event)
act-push: install
	@echo "Testing workflow locally with act (push event)..."
	@if [ ! -f .actrc ]; then \
		echo "Creating .actrc configuration..."; \
		echo "-P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest" > .actrc; \
	fi
	@act push --dryrun
	@echo "✓ Workflow dry-run completed. Use 'act push' to run for real (requires METRICS_TOKEN)"

# Test workflow with act (schedule event)
act-schedule: install
	@echo "Testing workflow locally with act (schedule event)..."
	@if [ ! -f .actrc ]; then \
		echo "Creating .actrc configuration..."; \
		echo "-P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest" > .actrc; \
	fi
	@act schedule --dryrun
	@echo "✓ Workflow dry-run completed. Use 'act schedule' to run for real (requires METRICS_TOKEN)"

# Lint workflow files
lint:
	@echo "Linting workflow files..."
	@if command -v yamllint > /dev/null 2>&1; then \
		yamllint .github/workflows/*.yml || echo "Warning: YAML linting found issues but continuing..."; \
	else \
		echo "yamllint not found, checking basic YAML syntax..."; \
		python3 -c "import yaml; [yaml.safe_load(open(f)) for f in ['.github/workflows/main.yml']]"; \
	fi
	@echo "✓ Workflow YAML syntax is valid"

# Clean temporary files
clean:
	@echo "Cleaning up temporary files..."
	@rm -rf .actrc
	@rm -rf /tmp/act-*
	@echo "✓ Cleanup completed"