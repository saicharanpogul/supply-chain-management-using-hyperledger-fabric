#!/bin/bash
source ./terminal_control.sh

cd ./supplychain-network/docker/

print Red "========== Bringing down the Containers and Pruning Volumes =========="
docker-compose -f docker-compose.yaml down -v

cd ..

print Red "========== Clearing Crypto Material =========="
sudo rm -rf organizations/

print Red "========== Deleting Chaincode Package =========="
sudo rm -rf supplychain.tar.gz