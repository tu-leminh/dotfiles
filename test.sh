#!/bin/bash

set -e

echo "Running tests..."

# Check bash script syntax
echo "Checking bash scripts syntax..."
bash -n run_bootstrap.sh

# Check Ansible playbook syntax
echo "Checking Ansible playbook syntax..."
if command -v ansible-playbook &> /dev/null; then
    ansible-playbook --syntax-check ansible/setup.yml
else
    echo "ansible-playbook not found, skipping syntax check."
    echo "Please install ansible to run full tests."
    exit 1
fi

echo "All tests passed successfully!"
