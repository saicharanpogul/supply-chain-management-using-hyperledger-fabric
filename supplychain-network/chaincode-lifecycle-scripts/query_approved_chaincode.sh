#!/bin/bash
source ../../terminal_control.sh

org=$CORE_PEER_LOCALMSPID
orgName=${org:: -3}

if [[ $orgName == "IndonesianFarmOrg1" ]]
then
PORT=7051
print Purple "ORG: $orgName"
elif [[ $orgName == "USClientOrg2" ]]
then
PORT=9051
print Purple "ORG: $orgName"
elif [[ $orgName == "RubberShipperOrg3" ]]
then
PORT=11051
print Purple "ORG: $orgName"
elif [[ $orgName == "GoodsCustomOrg4" ]]
then
PORT=13051
print Purple "ORG: $orgName"
else
exit 1
fi

print Green "========== Check Commit Readiness of Installed Chaincode on peer $orgName =========="
peer lifecycle chaincode queryapproved -C supplychain-channel -n supplychain --sequence 1 