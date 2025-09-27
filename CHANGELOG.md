# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

### Fixed
- **Metrics workflow**: Added missing runner dependencies (docker, jq) installation step
- **Metrics workflow**: Added comprehensive defensive configurations to prevent EJS template null/undefined errors
- **Metrics workflow**: Fixed TypeError: Cannot read properties of null (reading 'login') in lines plugin
- **Metrics workflow**: Fixed Cannot read properties of undefined (reading 'includes') in EJS templates
- **Metrics workflow**: Added safe array defaults and null checks for repositoriesContributedTo and similar data
- **CI**: Added Makefile with `ci` and `act` commands for local testing and validation
- **Workflow**: Improved YAML formatting and structure for better maintainability

### Added
- Defensive user object access patterns with commits_authoring configuration
- Comprehensive null/undefined safety checks in workflow configuration
- Repository affiliation safety with owner, collaborator, organization_member defaults
- Empty array defaults for repositories_skipped and users_ignored
- Regression test script for metrics configuration validation
- Metrics configuration JSON file with defensive defaults
- Makefile with local testing capabilities using `act` (GitHub Actions runner)
- CI infrastructure with linting and validation
- Support for both `make ci` and `make act-push` commands for development workflow

### Changed
- Workflow YAML structure updated for better readability and compliance
- Plugin configurations made more defensive against null/undefined values
- Line length issues fixed for YAML linting compliance
- Repository affiliations expanded to include owner and collaborator roles