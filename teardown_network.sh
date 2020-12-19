#!/bin/bash
source ./terminal-control.sh

cd ./supplychain-network/docker/

print Red "--------Bringing down the Containers and Pruning Volumes--------"
echo ""
docker-compose -f docker-compose.yaml down -v
