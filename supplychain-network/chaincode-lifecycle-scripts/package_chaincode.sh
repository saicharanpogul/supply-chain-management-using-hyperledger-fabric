#!/bin/bash 
source ../../terminal_control.sh

print Green "========== Packaging Chaincode =========="
peer lifecycle chaincode package supplychain.tar.gz --path ../../chaincode/supplychain/go/ --lang golang --label supplychain_1

ls