#!/bin/bash
set -e

docker stop portainer_edge_agent
docker rm portainer_edge_agent

docker pull portainer/agent:latest

docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
    -v /var/lib/docker/volumes:/var/lib/docker/volumes  \
    -v /:/host -v portainer_agent_data:/data \
    --restart always \
    -e EDGE=1 \
    -e EDGE_ID=$PORTAINER_EDGE_ID \
    -e EDGE_KEY=$PORTAINER_EDGE_KEY \
    -e EDGE_INSECURE_POLL=1 \
    --name portainer_edge_agent portainer/agent:latest