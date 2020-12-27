#!/bin/bash
source ../terminal_control.sh

export FABRIC_CFG_PATH=/home/hlfabric/fabric/hyperledger-fabric/config
export ORDERER_CA=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
export CORE_PEER_TLS_ROOTCERT_FILE_ORG1=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG2=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG3=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE_ORG4=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/ca.crt

CHANNEL_NAME="supplychain-channel"
CHAINCODE_NAME="supplychain"
CHAINCODE_VERSION="1.0"
CHAINCODE_PATH="../chaincode/supplychain/go/"
CHAINCODE_LABEL="supplychain_1"

setEnvForIndonesianFarmOrg1() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=IndonesianFarmOrg1MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users/Admin@indonesianfarmorg1.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setEnvForUSClientOrg2() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=USClientOrg2MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/usclientorg2.supplychain.com/users/Admin@usclientorg2.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
}

setEnvForRubberShipperOrg3() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=RubberShipperOrg3MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/rubbershipperorg3.supplychain.com/users/Admin@rubbershipperorg3.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
}

setEnvForGoodsCustomOrg4() {
    export CORE_PEER_TLS_ENABLED=true
    export CORE_PEER_LOCALMSPID=GoodsCustomOrg4MSP
    export CORE_PEER_TLS_ROOTCERT_FILE=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/ca.crt
    export CORE_PEER_MSPCONFIGPATH=/home/hlfabric/fabric/hyperledger-fabric/supplychain-network/organizations/peerOrganizations/goodscustomorg4.supplychain.com/users/Admin@goodscustomorg4.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:13051
}

packageChaincode() {
    rm -rf ${CHAINCODE_NAME}.tar.gz
    setEnvForIndonesianFarmOrg1
    print Green "========== Packaging Chaincode on Peer0 IndonesianFarmOrg1 =========="
    peer lifecycle chaincode package ${CHAINCODE_NAME}.tar.gz --path ${CHAINCODE_PATH} --lang golang --label ${CHAINCODE_LABEL}
    echo ""
    print Green "========== Packaging Chaincode on Peer0 IndonesianFarmOrg1 Successful =========="
    ls
    echo ""
}

installChaincode() {
    setEnvForIndonesianFarmOrg1
    print Green "========== Installing Chaincode on Peer0 IndonesianFarmOrg1 =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on Peer0 IndonesianFarmOrg1 =========="
    echo ""

    setEnvForUSClientOrg2
    print Green "========== Installing Chaincode on Peer0 USClientOrg2 =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on peer0 USClientOrg2 =========="
    echo ""

    setEnvForRubberShipperOrg3
    print Green "========== Installing Chaincode on Peer0 RubberShipperOrg3 =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on Peer0 RubberShipperOrg3 =========="
    echo ""

    setEnvForGoodsCustomOrg4
    print Green "========== Installing Chaincode on Peer0 GoodsCustomOrg4 =========="
    peer lifecycle chaincode install ${CHAINCODE_NAME}.tar.gz --peerAddresses localhost:13051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Installed Chaincode on Peer0 GoodsCustomOrg4 =========="
    echo ""
}

queryInstalledChaincode() {
    setEnvForIndonesianFarmOrg1
    print Green "========== Querying Installed Chaincode on Peer0 IndonesianFarmOrg1=========="
    peer lifecycle chaincode queryinstalled --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE} >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CHAINCODE_LABEL}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    print Yellow "PackageID is ${PACKAGE_ID}"
    print Green "========== Query Installed Chaincode Successful on Peer0 IndonesianFarmOrg1=========="
    echo ""
}

approveChaincodeByIndonesianFarmOrg1() {
    setEnvForIndonesianFarmOrg1
    print Green "========== Approve Installed Chaincode by Peer0 IndonesianFarmOrg1 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 IndonesianFarmOrg1 =========="
    echo ""
}

checkCommitReadynessForIndonesianFarmOrg1() {
    setEnvForIndonesianFarmOrg1
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 IndonesianFarmOrg1 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 IndonesianFarmOrg1 =========="
    echo ""
}

approveChaincodeByUSClientOrg2() {
    setEnvForUSClientOrg2
    print Green "========== Approve Installed Chaincode by Peer0 USClientOrg2 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 USClientOrg2 =========="
    echo ""
}

checkCommitReadynessForUSClientOrg2() {
    setEnvForUSClientOrg2
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 USClientOrg2 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 USClientOrg2 =========="
    echo ""
}

approveChaincodeByRubberShipperOrg3() {
    setEnvForRubberShipperOrg3
    print Green "========== Approve Installed Chaincode by Peer0 RubberShipperOrg3 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 RubberShipperOrg3 =========="
    echo ""
}

checkCommitReadynessForRubberShipperOrg3() {
    setEnvForRubberShipperOrg3
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 RubberShipperOrg3 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 RubberShipperOrg3 =========="
    echo ""
}

approveChaincodeByGoodsCustomOrg4() {
    setEnvForGoodsCustomOrg4
    print Green "========== Approve Installed Chaincode by Peer0 GoodsCustomOrg4 =========="
    peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls --cafile ${ORDERER_CA} --channelID supplychain-channel --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --package-id ${PACKAGE_ID} --sequence 1 --init-required
    print Green "========== Approve Installed Chaincode Successful by Peer0 GoodsCustomOrg4 =========="
    echo ""
}

checkCommitReadynessForGoodsCustomOrg4() {
    setEnvForGoodsCustomOrg4
    print Green "========== Check Commit Readiness of Installed Chaincode on Peer0 GoodsCustomOrg4 =========="
    peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --channelID ${CHANNEL_NAME} --tls --cafile ${ORDERER_CA} --name ${CHAINCODE_NAME} --version ${CHAINCODE_VERSION} --sequence 1 --output json --init-required
    print Green "========== Check Commit Readiness of Installed Chaincode Successful on Peer0 GoodsCustomOrg4 =========="
    echo ""
}

commitChaincode() {
    setEnvForIndonesianFarmOrg1
    print Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME} --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG1} --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG2} --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG3} --peerAddresses localhost:13051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG4} --version ${CHAINCODE_VERSION} --sequence 1 --init-required
    print Green "========== Commit Installed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}

queryCommittedChaincode() {
    setEnvForIndonesianFarmOrg1
    print Green "========== Query Committed Chaincode on ${CHANNEL_NAME} =========="
    peer lifecycle chaincode querycommitted --channelID ${CHANNEL_NAME} --name ${CHAINCODE_NAME}
    print Green "========== Query Committed Chaincode on ${CHANNEL_NAME} Successful =========="
    echo ""
}

getInstalledChaincode() {
    setEnvForIndonesianFarmOrg1
    print Green "========== Get Installed Chaincode from Peer0 IndonesianFarmOrg1 =========="
    peer lifecycle chaincode getinstalledpackage --package-id ${PACKAGE_ID} --output-directory . --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE}
    print Green "========== Get Installed Chaincode from Peer0 IndonesianFarmOrg1 Successful =========="
    echo ""
}

queryApprovedChaincode() {
    setEnvForIndonesianFarmOrg1
    print Green "========== Query Approved of Installed Chaincode on Peer0 IndonesianFarmOrg1 =========="
    peer lifecycle chaincode queryapproved -C s${CHANNEL_NAME} -n ${CHAINCODE_NAME} --sequence 1 
    print Green "========== Query Approved of Installed Chaincode on Peer0 IndonesianFarmOrg1 Successful =========="
    echo ""
}

initChaincode() {
    setEnvForIndonesianFarmOrg1
    print Green "========== Init Chaincode on Peer0 IndonesianFarmOrg1 ========== "
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} -C ${CHANNEL_NAME} -n ${CHAINCODE_NAME} --peerAddresses localhost:7051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG1} --peerAddresses localhost:9051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG2} --peerAddresses localhost:11051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG3} --peerAddresses localhost:13051 --tlsRootCertFiles ${CORE_PEER_TLS_ROOTCERT_FILE_ORG4}  --isInit -c '{"Args":[]}'
    print Green "========== Init Chaincode on Peer0 IndonesianFarmOrg1 Successful ========== "
    echo ""
}

if [[ $1 == "packageChaincode" ]]
then
packageChaincode
elif [[ $1 == "installChaincode" ]]
then
installChaincode
elif [[ $1 == "queryInstalledChaincode" ]]
then
queryInstalledChaincode
elif [[ $1 == "approveChaincodeByIndonesianFarmOrg1" ]]
then
approveChaincodeByIndonesianFarmOrg1
elif [[ $1 == "checkCommitReadynessForIndonesianFarmOrg1" ]]
then
checkCommitReadynessForIndonesianFarmOrg1
elif [[ $1 == "approveChaincodeByUSClientOrg2" ]]
then
approveChaincodeByUSClientOrg2
elif [[ $1 == "checkCommitReadynessForUSClientOrg2" ]]
then
checkCommitReadynessForUSClientOrg2
elif [[ $1 == "approveChaincodeByRubberShipperOrg3" ]]
then
approveChaincodeByRubberShipperOrg3
elif [[ $1 == "checkCommitReadynessForRubberShipperOrg3" ]]
then
checkCommitReadynessForRubberShipperOrg3
elif [[ $1 == "approveChaincodeByGoodsCustomOrg4" ]]
then
approveChaincodeByGoodsCustomOrg4
elif [[ $1 == "checkCommitReadynessForGoodsCustomOrg4" ]]
then
checkCommitReadynessForGoodsCustomOrg4
elif [[ $1 == "commitChaincode" ]]
then
commitChaincode
elif [[ $1 == "queryCommittedChaincode" ]]
then
queryCommittedChaincode
elif [[ $1 == "getInstalledChaincode" ]]
then
getInstalledChaincode
elif [[ $1 == "queryApprovedChaincode" ]]
then
queryApprovedChaincode
elif [[ $1 == "initChaincode" ]]
then
initChaincode
elif [[ $1 == "help" ]]
then
echo "Usage:" 
echo "       source chaincode_lifecycle.sh [option]"
echo "Options Available:"
echo "Follow this options in sequence"
echo "[ packageChaincode | installChaincode | queryInstalledChaincode | approveChaincodeByIndonesianFarmOrg1 ]"
echo "[ checkCommitReadynessForIndonesianFarmOrg1 | approveChaincodeByUSClientOrg2 | checkCommitReadynessForUSClientOrg2 ]"
echo "[ approveChaincodeByRubberShipperOrg3 | checkCommitReadynessForRubberShipperOrg3 | approveChaincodeByGoodsCustomOrg4 ]"
echo "[ checkCommitReadynessForGoodsCustomOrg4 | commitChaincode | queryCommittedChaincode | initChaincode ]"
echo "Other Options:"
echo "[ default(run all options in sequence at once) | getInstalledChaincode | queryApprovedChaincode | help ]"
elif [[ $1 == "default" ]]
then
packageChaincode
installChaincode
queryInstalledChaincode
approveChaincodeByIndonesianFarmOrg1
checkCommitReadynessForIndonesianFarmOrg1
approveChaincodeByUSClientOrg2
checkCommitReadynessForUSClientOrg2
approveChaincodeByRubberShipperOrg3
checkCommitReadynessForRubberShipperOrg3
approveChaincodeByGoodsCustomOrg4
checkCommitReadynessForGoodsCustomOrg4
commitChaincode
queryCommittedChaincode
initChaincode
else
print Red "$1: Invalid option. (try: source chaincode_lifecycle.sh help)"
fi

