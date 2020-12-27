#!/bin/bash
source ../terminal_control.sh

export FABRIC_CFG_PATH=${HOME}/fabric/hyperledger-fabric/config/
export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

export CHANNEL_NAME=supplychain-channel

setEnvForPeer0IndonesianFarmOrg1() {
    export PEER0_ORG1_CA=${PWD}/organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=IndonesianFarmOrg1MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users/Admin@indonesianfarmorg1.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setEnvForPeer1IndonesianFarmOrg1() {
    export PEER1_ORG1_CA=${PWD}/organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=IndonesianFarmOrg1MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users/Admin@indonesianfarmorg1.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:8051
}

setEnvForPeer0USClientOrg2() {
    export PEER0_ORG2_CA=${PWD}/organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=USClientOrg2MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/usclientorg2.supplychain.com/users/Admin@usclientorg2.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setEnvForPeer1USClientOrg2() {
    export PEER1_ORG2_CA=${PWD}/organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=USClientOrg2MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/usclientorg2.supplychain.com/users/Admin@usclientorg2.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:10051
}

setEnvForPeer0RubberShipperOrg3() {
    export PEER0_ORG3_CA=${PWD}/organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=RubberShipperOrg3MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/rubbershipperorg3.supplychain.com/users/Admin@rubbershipperorg3.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
}

setEnvForPeer1RubberShipperOrg3() {
    export PEER1_ORG3_CA=${PWD}/organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=RubberShipperOrg3MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/rubbershipperorg3.supplychain.com/users/Admin@rubbershipperorg3.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:12051
}

setEnvForPeer0GoodsCustomOrg4() {
    export PEER0_ORG4_CA=${PWD}/organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=GoodsCustomOrg4MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/goodscustomorg4.supplychain.com/users/Admin@goodscustomorg4.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:13051
}

setEnvForPeer1GoodsCustomOrg4() {
    export PEER1_ORG4_CA=${PWD}/organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls/ca.crt
    export CORE_PEER_LOCALMSPID=GoodsCustomOrg4MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/goodscustomorg4.supplychain.com/users/Admin@goodscustomorg4.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:14051
}

createChannel() {
    setEnvForPeer0IndonesianFarmOrg1

    print Green "========== Creating Channel =========="
    echo ""
    peer channel create -o localhost:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer.supplychain.com \
    -f ./channel-artifacts/$CHANNEL_NAME.tx --outputBlock \
    ./channel-artifacts/${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA 
    echo ""
}

joinChannel() {
    
    setEnvForPeer0IndonesianFarmOrg1
    print Green "========== Peer0IndonesianFarmOrg1 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1IndonesianFarmOrg1
    print Green "========== Peer1IndonesianFarmOrg1 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0USClientOrg2
    print Green "========== Peer0USClientOrg2 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1USClientOrg2
    print Green "========== Peer1USClientOrg2 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0RubberShipperOrg3
    print Green "========== Peer0RubberShipperOrg3 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1RubberShipperOrg3
    print Green "========== Peer1RubberShipperOrg3 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer0GoodsCustomOrg4
    print Green "========== Peer0GoodsCustomOrg4 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""

    setEnvForPeer1GoodsCustomOrg4
    print Green "========== Peer1GoodsCustomOrg4 Joining Channel '$CHANNEL_NAME' =========="
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    echo ""
}

updateAnchorPeers() {
    setEnvForPeer0IndonesianFarmOrg1
    print Green "========== Updating Anchor Peer of Peer0IndonesianFarmOrg1 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""

    setEnvForPeer0USClientOrg2
    print Green "========== Updating Anchor Peer of Peer0USClientOrg2 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""

    setEnvForPeer0RubberShipperOrg3
    print Green "========== Updating Anchor Peer of Peer0RubberShipperOrg3 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""

    setEnvForPeer0GoodsCustomOrg4
    print Green "========== Updating Anchor Peer of Peer0GoodsCustomOrg4 =========="
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com -c $CHANNEL_NAME -f ./channel-artifacts/${CORE_PEER_LOCALMSPID}Anchor.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    echo ""
}

createChannel
joinChannel
updateAnchorPeers