createCertForIndonesianFarmOrg1() {
    echo
    echo "Enroll CA admin of IndonesianFarmOrg1"
    echo
    mkdir -p ../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.indonesianfarmorg1.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-indonesianfarmorg1-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-indonesianfarmorg1-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-indonesianfarmorg1-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-indonesianfarmorg1-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.indonesianfarmorg1"
    echo

    fabric-ca-client register --caname ca.indonesianfarmorg1.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    echo
    echo "Register peer1.indonesianfarmorg1"
    echo

    fabric-ca-client register --caname ca.indonesianfarmorg1.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    echo
    echo "Register user1.indonesianfarmorg1"
    echo

    fabric-ca-client register --caname ca.indonesianfarmorg1.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    echo
    echo "Register admin.indonesianfarmorg1"
    echo

    fabric-ca-client register --caname ca.indonesianfarmorg1.supplychain.com --id.name org1admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.indonesianfarmorg1.supplychain.com -M ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/msp --csr.hosts peer0.indonesianfarmorg1.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.indonesianfarmorg1.supplychain.com -M ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.indonesianfarmorg1.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/tlsca/tlsca.indonesianfarmorg1.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer0.indonesianfarmorg1.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/ca/ca.indonesianfarmorg1.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.indonesianfarmorg1.supplychain.com -M ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/msp --csr.hosts peer1.indonesianfarmorg1.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.indonesianfarmorg1.supplychain.com -M ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.indonesianfarmorg1.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/tlsca/tlsca.indonesianfarmorg1.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/peers/peer1.indonesianfarmorg1.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/ca/ca.indonesianfarmorg1.supplychain.com-cert.pem
    
    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users/User1@indonesianfarmorg1.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.indonesianfarmorg1.supplychain.com -M ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users/User1@indonesianfarmorg1.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users/Admin@indonesianfarmorg1.supplychain.com

    echo
    echo "Generate IndonesianFarmOrg1 Admin MSP"
    echo

    fabric-ca-client enroll -u https://org1admin:adminpw@localhost:7054 --caname ca.indonesianfarmorg1.supplychain.com -M ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users/Admin@indonesianfarmorg1.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/indonesianfarmorg1/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/indonesianfarmorg1.supplychain.com/users/Admin@indonesianfarmorg1.supplychain.com/msp/config.yaml
}

createCertForUSClientOrg2() {
    echo
    echo "Enroll CA admin of USClientOrg2"
    echo
    mkdir -p ../organizations/peerOrganizations/usclientorg2.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.usclientorg2.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-usclientorg2-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-usclientorg2-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-usclientorg2-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-usclientorg2-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.usclientorg2"
    echo

    fabric-ca-client register --caname ca.usclientorg2.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    echo
    echo "Register peer1.usclientorg2"
    echo

    fabric-ca-client register --caname ca.usclientorg2.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    echo
    echo "Register user1.usclientorg2"
    echo

    fabric-ca-client register --caname ca.usclientorg2.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    echo
    echo "Register admin.usclientorg2"
    echo

    fabric-ca-client register --caname ca.usclientorg2.supplychain.com --id.name org2admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/usclientorg2.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.usclientorg2.supplychain.com -M ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/msp --csr.hosts peer0.usclientorg2.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.usclientorg2.supplychain.com -M ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.usclientorg2.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/tlsca/tlsca.usclientorg2.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer0.usclientorg2.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/ca/ca.usclientorg2.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.usclientorg2.supplychain.com -M ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/msp --csr.hosts peer1.usclientorg2.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.usclientorg2.supplychain.com -M ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.usclientorg2.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/tlsca/tlsca.usclientorg2.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/peers/peer1.usclientorg2.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/ca/ca.usclientorg2.supplychain.com-cert.pem
    
    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/usclientorg2.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/usclientorg2.supplychain.com/users/User1@usclientorg2.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.usclientorg2.supplychain.com -M ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/users/User1@usclientorg2.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/usclientorg2.supplychain.com/users/Admin@usclientorg2.supplychain.com

    echo
    echo "Generate USClientOrg2 Admin MSP"
    echo

    fabric-ca-client enroll -u https://org2admin:adminpw@localhost:8054 --caname ca.usclientorg2.supplychain.com -M ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/users/Admin@usclientorg2.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/usclientorg2/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/usclientorg2.supplychain.com/users/Admin@usclientorg2.supplychain.com/msp/config.yaml
}

createCertForRubberShipperOrg3() {
    echo
    echo "Enroll CA admin of RubberShipperOrg3"
    echo
    mkdir -p ../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.rubbershipperorg3.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-rubbershipperorg3-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-rubbershipperorg3-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-rubbershipperorg3-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-rubbershipperorg3-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.rubbershipperorg3"
    echo

    fabric-ca-client register --caname ca.rubbershipperorg3.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    echo
    echo "Register peer1.rubbershipperorg3"
    echo

    fabric-ca-client register --caname ca.rubbershipperorg3.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    echo
    echo "Register user1.rubbershipperorg3"
    echo

    fabric-ca-client register --caname ca.rubbershipperorg3.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    echo
    echo "Register admin.rubbershipperorg3"
    echo

    fabric-ca-client register --caname ca.rubbershipperorg3.supplychain.com --id.name org3admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca.rubbershipperorg3.supplychain.com -M ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/msp --csr.hosts peer0.rubbershipperorg3.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca.rubbershipperorg3.supplychain.com -M ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.rubbershipperorg3.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/tlsca/tlsca.rubbershipperorg3.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer0.rubbershipperorg3.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/ca/ca.rubbershipperorg3.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca.rubbershipperorg3.supplychain.com -M ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/msp --csr.hosts peer1.rubbershipperorg3.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca.rubbershipperorg3.supplychain.com -M ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.rubbershipperorg3.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/tlsca/tlsca.rubbershipperorg3.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/peers/peer1.rubbershipperorg3.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/ca/ca.rubbershipperorg3.supplychain.com-cert.pem

    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/users/User1@rubbershipperorg3.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:9054 --caname ca.rubbershipperorg3.supplychain.com -M ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/users/User1@rubbershipperorg3.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/users/Admin@rubbershipperorg3.supplychain.com

    echo
    echo "Generate RubberShipperOrg3 Admin MSP"
    echo

    fabric-ca-client enroll -u https://org3admin:adminpw@localhost:9054 --caname ca.rubbershipperorg3.supplychain.com -M ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/users/Admin@rubbershipperorg3.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/rubbershipperorg3/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/rubbershipperorg3.supplychain.com/users/Admin@rubbershipperorg3.supplychain.com/msp/config.yaml
    
}

createCertForGoodsCustomOrg4() {
    echo
    echo "Enroll CA admin of GoodsCustomOrg4"
    echo
    mkdir -p ../organizations/peerOrganizations/goodscustomorg4.supplychain.com/
    export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/

    fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.goodscustomorg4.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-goodscustomorg4-supplychain-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-goodscustomorg4-supplychain-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-goodscustomorg4-supplychain-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-goodscustomorg4-supplychain-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/msp/config.yaml

    echo
    echo "Register peer0.goodscustomorg4"
    echo

    fabric-ca-client register --caname ca.goodscustomorg4.supplychain.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    echo
    echo "Register peer1.goodscustomorg4"
    echo

    fabric-ca-client register --caname ca.goodscustomorg4.supplychain.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    echo
    echo "Register user1.goodscustomorg4"
    echo

    fabric-ca-client register --caname ca.goodscustomorg4.supplychain.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    echo
    echo "Register admin.goodscustomorg4"
    echo

    fabric-ca-client register --caname ca.goodscustomorg4.supplychain.com --id.name org4admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers
    
    # -----------------------------------------------------------------------------------
    # Peer0
    mkdir -p ../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com

    echo
    echo "Generate Peer0 MSP"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.goodscustomorg4.supplychain.com -M ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/msp --csr.hosts peer0.goodscustomorg4.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer0 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.goodscustomorg4.supplychain.com -M ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls --enrollment.profile tls --csr.hosts peer0.goodscustomorg4.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/server.key

    mkdir ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/msp/tlscacerts
    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/msp/tlscacerts/ca.crt

    mkdir ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/tlsca
    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/tlsca/tlsca.goodscustomorg4.supplychain.com-cert.pem

    mkdir ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/ca
    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer0.goodscustomorg4.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/ca/ca.goodscustomorg4.supplychain.com-cert.pem

    # -----------------------------------------------------------------------------------
    # Peer1
    mkdir -p ../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com

    echo
    echo "Generate Peer1 MSP"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.goodscustomorg4.supplychain.com -M ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/msp --csr.hosts peer1.goodscustomorg4.supplychain.com --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/msp/config.yaml

    echo
    echo "Generate Peer1 TLS-CERTs"
    echo

    fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.goodscustomorg4.supplychain.com -M ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls --enrollment.profile tls --csr.hosts peer1.goodscustomorg4.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls/ca.crt
    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls/signcerts/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls/server.crt
    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls/server.key

    # mkdir ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/msp/tlscacerts
    # cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls/keystore/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/msp/tlscacerts/ca.crt

    # mkdir ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tlsca
    # cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/tlsca/tlsca.goodscustomorg4.supplychain.com-cert.pem

    # mkdir ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/ca
    # cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/peers/peer1.goodscustomorg4.supplychain.com/msp/cacerts/* ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/ca/ca.goodscustomorg4.supplychain.com-cert.pem

    # ------------------------------------------------------------------------------------------
    mkdir -p ../organizations/peerOrganizations/goodscustomorg4.supplychain.com/users
    mkdir -p ../organizations/peerOrganizations/goodscustomorg4.supplychain.com/users/User1@goodscustomorg4.supplychain.com

    echo
    echo "Generate User1 MSP"
    echo
    fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca.goodscustomorg4.supplychain.com -M ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/users/User1@goodscustomorg4.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    mkdir -p ../organizations/peerOrganizations/goodscustomorg4.supplychain.com/users/Admin@goodscustomorg4.supplychain.com

    echo
    echo "Generate GoodsClientOrg4 Admin MSP"
    echo

    fabric-ca-client enroll -u https://org4admin:adminpw@localhost:10054 --caname ca.goodscustomorg4.supplychain.com -M ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/users/Admin@goodscustomorg4.supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/goodscustomorg4/tls-cert.pem

    cp ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/msp/config.yaml ${PWD}/../organizations/peerOrganizations/goodscustomorg4.supplychain.com/users/Admin@goodscustomorg4.supplychain.com/msp/config.yaml
    
}

createCretificateForOrderer() {
  echo
  echo "Enroll CA admin of Orderer"
  echo
  mkdir -p ../organizations/ordererOrganizations/supplychain.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/../organizations/ordererOrganizations/supplychain.com

  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register the Orderer Admin"
  echo

  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers
  # mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/supplychain.com

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com

  echo
  echo "Generate the Orderer MSP"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp --csr.hosts orderer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/config.yaml

  echo
  echo "Generate the orderer TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls --enrollment.profile tls --csr.hosts orderer.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/ca.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/signcerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/keystore/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.key

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com

  echo
  echo "Generate the Orderer2 MSP"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp --csr.hosts orderer2.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/config.yaml

  echo
  echo "Generate the Orderer2 TLS Certs"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls --enrollment.profile tls --csr.hosts orderer2.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/ca.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/signcerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/keystore/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.key

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com

  echo
  echo "Generate the Orderer3 MSP"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp --csr.hosts orderer3.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/config.yaml

  echo
  echo "Generate the Orderer3 TLS certs"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls --enrollment.profile tls --csr.hosts orderer3.supplychain.com --csr.hosts localhost --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/ca.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/signcerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.crt
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/keystore/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.key

  mkdir ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/tlscacerts
  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/tlscacerts/* ${PWD}/../organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
  # ---------------------------------------------------------------------------

  mkdir -p ../organizations/ordererOrganizations/supplychain.com/users
  mkdir -p ../organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com

  echo
  echo "Generate the Admin MSP Orderer"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:11054 --caname ca-orderer -M ${PWD}/../organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com/msp --tls.certfiles ${PWD}/../organizations/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../organizations/ordererOrganizations/supplychain.com/msp/config.yaml ${PWD}/../organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com/msp/config.yaml

}

createCertForIndonesianFarmOrg1
createCertForUSClientOrg2
createCertForRubberShipperOrg3
createCertForGoodsCustomOrg4
createCretificateForOrderer