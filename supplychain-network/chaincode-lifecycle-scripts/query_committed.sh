#!/bin/bash
source ../../terminal_control.sh

print Green "========== Query Committed Chaincode =========="
peer lifecycle chaincode querycommitted --channelID supplychain-channel --name supplychain