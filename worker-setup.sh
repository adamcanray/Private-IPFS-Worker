#!/bin/bash

echo "[worker-setup] Setup Worker"

# Exrtact from environment variables
export MANAGER_IPFS_ID=$MANAGER_IPFS_ID
export MANAGER_IP_ADDRESS=$MANAGER_IP_ADDRESS

# Setup ipfs
bash ./ipfs-setup-worker.sh

# Keep the script running
tail -f /dev/null
