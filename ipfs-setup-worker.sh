#!/bin/bash

# Enable debugging output
set -x

# Get the hostname of the current node
HOSTNAME=$(hostname)

# IP address of the current node
CURRENT_NODE_IP_ADDRESS=$(ip -4 addr show eth0 | grep -oE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' | head -n 1)

# IPFS init
echo "[ipfs-setup] Setup IPFS"
echo "[ipfs-setup] Node hostname: $HOSTNAME"
echo "[ipfs-setup] Node eth0 IP address: $CURRENT_NODE_IP_ADDRESS"
ipfs init

# IPFS id to file
echo "[ipfs-setup] IPFS initialized"

# IPFS config
echo "[ipfs-setup] Setup IPFS config"
bash ./ipfs-update-config.sh $CURRENT_NODE_IP_ADDRESS
echo "[ipfs-setup] IPFS config updated"

# IPFS bootstrap
echo "[ipfs-setup] Manager resources are ready"
echo "[ipfs-setup] Setup IPFS bootstrap"
bash ./ipfs-update-bootstrap.sh
echo "[ipfs-setup] IPFS bootstrap updated"

# IPFS swarm key
echo "[ipfs-setup] Swarm key is ready"
cat ./swarm.key > ~/.ipfs/swarm.key
echo "[ipfs-setup] Swarm key is copied to ~/.ipfs/swarm.key"
cd /

# Disable debugging output
set +x
