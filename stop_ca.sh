#!/bin/bash
source ./terminal_control.sh

print Red "========== Stopping the Containers =========="
cd ./supplychain-network/docker/
docker-compose -f docker-compose-ca.yaml stop