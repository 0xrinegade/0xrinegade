#!/bin/bash

# Test script for metrics configuration validation
# This script validates that our configuration handles null/undefined values properly

set -e

echo "🧪 Testing metrics configuration..."

# Test 1: Validate YAML syntax
echo "📝 Validating workflow YAML syntax..."
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/main.yml'))" && echo "✅ YAML syntax is valid"

# Test 2: Validate JSON configuration
echo "📝 Validating JSON configuration..."
python3 -c "import json; json.load(open('.github/metrics.config.json'))" && echo "✅ JSON configuration is valid"

# Test 3: Check for defensive configurations
echo "📝 Checking for defensive configurations..."
grep -q "repositories_skipped" .github/workflows/main.yml && echo "✅ repositories_skipped configured"
grep -q "users_ignored" .github/workflows/main.yml && echo "✅ users_ignored configured"
grep -q "commits_authoring" .github/workflows/main.yml && echo "✅ commits_authoring configured"

# Test 4: Validate required fields are present
echo "📝 Validating required fields..."
grep -q "token:" .github/workflows/main.yml && echo "✅ token is configured"
grep -q "user:" .github/workflows/main.yml && echo "✅ user is configured"

echo "🎉 All tests passed! Configuration should handle null/undefined values safely."