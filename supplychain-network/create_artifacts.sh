#!/bin/bash 
source ../terminal-control.sh
print Green "----------Genetating Channel Artifacts----------"
echo ""

export FABRIC_CFG_PATH=${PWD}/configtx/

# Generate crypto material using cryptogen tool
print Green "=======Generating Crypto Material======="
echo ""

../../fabric-samples/bin/cryptogen generate --config=./crypto-config.yaml --output="organizations"

echo ""
print Green "=======Crypto Material Generated======="
echo ""

SYS_CHANNEL=supplychain-sys-channel
print Yellow "System Channel Name: "$SYS_CHANNEL
echo ""

CHANNEL_NAME=supplychain-channel
print Yellow "Application Channel Name: "$CHANNEL_NAME
echo ""

# Generate System Genesis Block using configtxgen tool
print Green "=======Generating System Genesis Block======="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsOrdererGenesis -channelID $SYS_CHANNEL -outputBlock ./channel-artifacts/genesis.block

echo ""
print Green "=======System Genesis Block Generated======="
echo ""

print Green "=======Generating Channel Configuration Block======="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputCreateChannelTx ./channel-artifacts/supplychain-channel.tx -channelID $CHANNEL_NAME 

echo ""
print Green "=======Channel Configuration Block Generated======="
echo ""

print Green "=======Generating Anchor Peer Update For Org1MSP======="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/IndonesianFarmOrg1MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg IndonesianFarmOrg1MSP

echo ""
print Green "=======Anchor Peer Update For Org1MSP Generated======="
echo ""

print Green "=======Generating Anchor Peer Update For Org2MSP======="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/USClientOrg2MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg USClientOrg2MSP

echo ""
print Green "=======Anchor Peer Update For Org2MSP Generated======="
echo ""

print Green "=======Generating Anchor Peer Update For Org3MSP======="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/RubberShipperOrg3MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg RubberShipperOrg3MSP

echo ""
print Green "=======Anchor Peer Update For Org3MSP Generated======="
echo ""

print Green "=======Generating Anchor Peer Update For Org4MSP======="
echo ""

../../fabric-samples/bin/configtxgen -profile FourOrgsChannel -configPath ./configtx/ -outputAnchorPeersUpdate ./channel-artifacts/GoodsCustomOrg4MSPAnchor.tx -channelID $CHANNEL_NAME -asOrg GoodsCustomOrg4MSP

echo ""
print Green "=======Anchor Peer Update For Org4MSP Generated======="
echo ""

print Green "----------Channel Artifacts Generated----------"
echo ""