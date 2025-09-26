please subscribe to my soundcloud, im trying to pivot my career into beatmaking 
https://soundcloud.com/rinerd

![Metrics](./github-metrics.svg)

## Development

This repository includes CI/CD infrastructure for local testing and validation.

### Prerequisites

- Docker (required for metrics action and local testing)
- jq (automatically installed by workflow and Makefile)
- act (GitHub Actions runner, automatically installed by Makefile)

### Local Testing

Use the provided Makefile for local development:

```bash
# Run all CI checks (linting, validation)
make ci

# Test workflow locally with act (requires METRICS_TOKEN secret)
make act-push

# Install dependencies for local testing
make install

# Clean up temporary files
make clean
```

### Workflow Dependencies

The metrics workflow automatically installs required dependencies:
- `docker.io` - Container runtime for metrics generation
- `jq` - JSON processor for data manipulation

These dependencies are installed before running the metrics action to prevent runtime failures.
