#!/bin/bash
source ../../terminal_control.sh

org=$CORE_PEER_LOCALMSPID
orgName=${org:: -3}

if [[ $orgName == "IndonesianFarmOrg1" ]]
then
PORT=7051
print Purple "ORG: $orgName"
print Purple "PORT: $PORT"
elif [[ $orgName == "USClientOrg2" ]]
then
PORT=9051
print Purple "ORG: $orgName"
print Purple "PORT: $PORT"
elif [[ $orgName == "RubberShipperOrg3" ]]
then
PORT=11051
print Purple "ORG: $orgName"
print Purple "PORT: $PORT"
elif [[ $orgName == "GoodsCustomOrg4" ]]
then
PORT=13051
print Purple "ORG: $orgName"
print Purple "PORT: $PORT"
else
exit 1
fi

print Green "========== Querying Installed Chaincode on peer $orgName =========="
peer lifecycle chaincode queryinstalled --peerAddresses localhost:$PORT --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE