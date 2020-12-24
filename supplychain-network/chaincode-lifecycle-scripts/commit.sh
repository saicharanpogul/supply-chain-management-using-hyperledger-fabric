#!/bin/bash
source ../../terminal_control.sh

print Green "========== Commit Installed Chaincode =========="
peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA --channelID supplychain-channel --name supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 --version 1.0 --sequence 1 --init-required