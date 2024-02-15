# IPFS Worker Node

This repository is for IPFS Worker Node.

## Run

1. Build the image

   ```bash
   docker build . -t ipfs_worker --no-cache
   ```

   if we want to build the image for specific platform (ex: `--platform linux/arm64/v8`).

2. Run the container

   ```bash
   docker run --name ipfs_worker_container_n1 -e MANAGER_IPFS_ID=<manager_ipfs_id> -e MANAGER_IP_ADDRESS=<manager_ip_address> -d ipfs_worker
   ```

   if we want to expose the port, we can add for example `-p 4001:4001 -p 5001:5001 -p 8080:8080` to the command, but on ipfs config we are not exposed the API server (`:5001`) to the public.

3. Exec into the container
   ```bash
   docker exec -it ipfs_worker_container_n1 /bin/sh
   ```
4. Start the ipfs daemon
   ```bash
   touch /run/openrc/softlevel
   rc-update add ipfs default
   rc-service ipfs start --dry-run
   rc-status -a
   ```

## Addition

This project is running well with alphine linux with arm base (`linux/arm64/v8`), if you run this project using different distribution, maybe you should adjust some scripts or service config (ex: `services/ipfs`, etc).

## Notes

- In [preveous](https://github.com/adamcanray/Private-IPFS-Cluster-Data-Replication), manager and worker project is in one code base, we run with docker compose to simplify the automation, since currently the worker project is not on one code base anymore, we should run it in some steps (ex: running worker node manually, then run worker nodes and pointing it to the worker manually), see [Run](/#Run) section above.
- The `swarm.key`is should be confidential.
