#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ./ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ./ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=1
P0PORT=7051
CAPORT=7054
PEERPEM=./peerOrganizations/indonesianfarmorg1.supplychain.com/tlsca/tlsca.indonesianfarmorg1.supplychain.com-cert.pem
CAPEM=./peerOrganizations/indonesianfarmorg1.supplychain.com/ca/ca.indonesianfarmorg1.supplychain.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org1.json
#echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org1.yaml

ORG=2
P0PORT=9051
CAPORT=8054
PEERPEM=./peerOrganizations/usclientorg2.supplychain.com/tlsca/tlsca.usclientorg2.supplychain.com-cert.pem
CAPEM=./peerOrganizations/usclientorg2.supplychain.com/ca/ca.usclientorg2.supplychain.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org2.json
#echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org2.yaml

ORG=3
P0PORT=11051
CAPORT=9054
PEERPEM=./peerOrganizations/rubbershipperorg3.supplychain.com/tlsca/tlsca.rubbershipperorg3.supplychain.com-cert.pem
CAPEM=./peerOrganizations/rubbershipperorg3.supplychain.com/ca/ca.rubbershipperorg3.supplychain.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org3.json
#echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org3.yaml

ORG=4
P0PORT=13051
CAPORT=10054
PEERPEM=./peerOrganizations/goodscustomorg4.supplychain.com/tlsca/tlsca.goodscustomorg4.supplychain.com-cert.pem
CAPEM=./peerOrganizations/goodscustomorg4.supplychain.com/ca/ca.goodscustomorg4.supplychain.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org4.json
#echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-org4.yaml