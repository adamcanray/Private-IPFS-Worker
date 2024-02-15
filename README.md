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
   docker run --name <name> -e MANAGER_IPFS_ID=<manager_ipfs_id> -e MANAGER_IP_ADDRESS=<manager_ip_address> -d ipfs_worker
   ```

   > we can get the `MANAGER_IPFS_ID` and `MANAGER_IP_ADDRESS` from the manager node:

   ```bash
   <!-- go to the manager node terminal -->
   docker exec -it <name> /bin/sh

   <!-- below command will show detail in json structure, just copy the `ID` -->
   ipfs id

   <!-- below command will show interface config, copy the ip from eth0 (or other interface) -->
   ifconfig
   ```

   > if we want to expose the port, we can add for example `-p 4001:4001 -p 5001:5001 -p 8080:8080` to the command, but on ipfs config we are not exposed the API server (`:5001`) to the public.

## Addition

### About project

This project is running well with alphine linux with arm base (`linux/arm64/v8`), if you run this project using different distribution, maybe you should adjust some scripts or service config (ex: `services/ipfs`, etc).

### Porject Debugging

If the ipfs daemon is not running, we can start it manually for each node with `rc-service ipfs start` command. First, we should exec into the container

```bash
docker exec -it <name> /bin/sh
```

then start the ipfs daemon.

```bash
rc-status -a
rc-service ipfs start
touch /run/openrc/softlevel
rc-service ipfs restart
rc-update add ipfs default
sleep 1
rc-status -a
```

## Notes

- In [previous](https://github.com/adamcanray/Private-IPFS-Cluster-Data-Replication), manager and worker project is in one code base, we run with docker compose to simplify the automation, since currently the worker project is not on one code base anymore, we should run it in some steps (ex: running worker node manually, then run worker nodes and pointing it to the worker manually), see [Run](/#Run) section above.
- The `swarm.key`is should be confidential (generated once from manager).
- do step 2 on [Run](/#Run) section above for running other worker nodes.
