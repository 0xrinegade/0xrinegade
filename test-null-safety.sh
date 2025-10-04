#!/bin/bash

# Test script for null/undefined safety in metrics configuration
# This script validates that the configuration properly handles null/undefined user objects

set -e

echo "🧪 Testing null/undefined safety in metrics configuration..."

# Test 1: Validate that commits_authoring uses safe null-coalescing syntax
echo "📝 Checking commits_authoring null safety..."
if grep -q "(.user // {})" .github/workflows/main.yml; then
    echo "✅ commits_authoring uses null-coalescing operator"
else
    echo "❌ commits_authoring missing null-coalescing operator"
    exit 1
fi

if grep -q "if .login then .login else empty end" .github/workflows/main.yml; then
    echo "✅ commits_authoring has conditional login access"
else
    echo "❌ commits_authoring missing conditional login access"
    exit 1
fi

# Test 2: Validate defensive plugin configurations
echo "📝 Checking plugin defensive configurations..."
if grep -q "plugin_lines_ignored_repositories" .github/workflows/main.yml; then
    echo "✅ lines plugin has ignored_repositories safety config"
else
    echo "❌ lines plugin missing ignored_repositories safety config"
    exit 1
fi

if grep -q "plugin_repositories_ignored" .github/workflows/main.yml; then
    echo "✅ repositories plugin has ignored safety config"
else
    echo "❌ repositories plugin missing ignored safety config"
    exit 1
fi

# Test 3: Validate additional safety configurations
echo "📝 Checking additional safety configurations..."
if grep -q "repositories_forks: false" .github/workflows/main.yml; then
    echo "✅ repositories_forks safety config present"
else
    echo "❌ repositories_forks safety config missing"
    exit 1
fi

if grep -q "repositories_contributed_to: true" .github/workflows/main.yml; then
    echo "✅ repositories_contributed_to safety config present"
else
    echo "❌ repositories_contributed_to safety config missing"
    exit 1
fi

# Test 4: Count the occurrences of the safer commits_authoring pattern
echo "📝 Verifying both metrics actions use safe commits_authoring..."
SAFE_COMMITS_COUNT=$(grep -c "(.user // {})" .github/workflows/main.yml || echo "0")
if [ "$SAFE_COMMITS_COUNT" -eq 6 ]; then
    echo "✅ Both metrics actions use safe commits_authoring pattern (3 fields × 2 actions = 6 occurrences)"
else
    echo "❌ Expected 6 occurrences of safe commits_authoring, found $SAFE_COMMITS_COUNT"
    exit 1
fi

echo "🎉 All null/undefined safety tests passed! Configuration should be resilient to null user objects."