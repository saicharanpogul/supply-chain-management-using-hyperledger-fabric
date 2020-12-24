#!/bin/bash 
source ../../terminal_control.sh

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=IndonesianFarmOrg1MSP
export CORE_PEER_TLS_ROOTCERT_FILE_ORG1=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG2=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG3=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG4=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/ca.crt

export CORE_PEER_MSPCONFIGPATH=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users/Admin@indonesianfarmorg1.supplychain.com/msp
export CORE_PEER_ADDRESS=localhost:7051
export ORDERER_CA=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

print Purple "$CORE_PEER_TLS_ENABLED"
print Purple "$CORE_PEER_LOCALMSPID"
print Purple "$CORE_PEER_TLS_ROOTCERT_FILE_ORG1"
print Purple "$CORE_PEER_TLS_ROOTCERT_FILE_ORG2"
print Purple "$CORE_PEER_TLS_ROOTCERT_FILE_ORG3"
print Purple "$CORE_PEER_TLS_ROOTCERT_FILE_ORG4"
print Purple "$CORE_PEER_MSPCONFIGPATH"
print Purple "$CORE_PEER_ADDRESS"
print Purple "$ORDERER_CA"