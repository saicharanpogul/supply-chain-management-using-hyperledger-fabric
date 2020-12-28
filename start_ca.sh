#!/bin/bash
source ./terminal_control.sh

cd ./supplychain-network/docker/

print Green "========== Bringing up the CA docker containers =========="
docker-compose -f docker-compose-ca.yaml up -d