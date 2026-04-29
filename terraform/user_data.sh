#!/bin/bash
# Exit immediately if any command fails
set -e

# Update package list and install Docker
apt-get update -y
apt-get install -y docker.io
systemctl enable --now docker

# Add Buildkite package repository and install agent
curl -fsSL https://keys.openpgp.org/vks/v1/by-fingerprint/32A37959C2FA5C3C99EFBC32A79206696452D198 | gpg --dearmor -o /usr/share/keyrings/buildkite-agent-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/buildkite-agent-archive-keyring.gpg] https://apt.buildkite.com/buildkite-agent stable main" | tee /etc/apt/sources.list.d/buildkite-agent.list
apt-get update -y && apt-get install -y buildkite-agent

# Inject agent token into config
sed -i "s/token=.*/token=${token}/" /etc/buildkite-agent/buildkite-agent.cfg

# Set queue tag so agent connects to the self-hosted queue
sed -i "s/# tags=.*/tags=queue=ec2-instance/" /etc/buildkite-agent/buildkite-agent.cfg

# Give agent access to Docker socket
usermod -aG docker buildkite-agent

# Start agent and register with Buildkite
systemctl enable --now buildkite-agent