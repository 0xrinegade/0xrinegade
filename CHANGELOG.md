# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Fixed
- **Metrics workflow**: Added missing runner dependencies (docker, jq) installation step
- **Metrics workflow**: Added defensive configurations to prevent EJS template null/undefined errors
- **CI**: Added Makefile with `ci` and `act` commands for local testing and validation
- **Workflow**: Improved YAML formatting and structure for better maintainability

### Added
- Makefile with local testing capabilities using `act` (GitHub Actions runner)
- CI infrastructure with linting and validation
- Support for both `make ci` and `make act push` commands for development workflow

### Changed
- Workflow YAML structure updated for better readability and compliance
- Plugin configurations made more defensive against null/undefined values