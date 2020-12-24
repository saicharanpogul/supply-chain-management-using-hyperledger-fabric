#!/bin/bash 
source ../../terminal_control.sh

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=GoodsCustomOrg4MSP
export CORE_PEER_TLS_ROOTCERT_FILE=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/goodscustomorg4.supplychain.com/users/Admin@goodscustomorg4.supplychain.com/msp
export CORE_PEER_ADDRESS=localhost:13051
export ORDERER_CA=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

print Purple "$CORE_PEER_TLS_ENABLED"
print Purple "$CORE_PEER_LOCALMSPID"
print Purple "$CORE_PEER_TLS_ROOTCERT_FILE"
print Purple "$CORE_PEER_MSPCONFIGPATH"
print Purple "$CORE_PEER_ADDRESS"
print Purple "$ORDERER_CA"