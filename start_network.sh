#!/bin/bash
source ./terminal-control.sh

cd ./supplychain-network/docker/

print Green "--------Bringing up the docker containers--------"
echo ""
docker-compose -f docker-compose.yaml up -d