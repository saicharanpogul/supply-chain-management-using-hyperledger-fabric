#!/bin/bash
source ./terminal-control.sh

print Red "--------Stopping the Containers--------"
echo ""
cd ./supplychain-network/docker/
docker-compose stop