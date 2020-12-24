# Chaincode CLI Invocation commands

## Init Smart Contract

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4  --isInit -c '{"Args":[]}' ```

## Invoke GenerateRubberCert

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["GenerateRubberCert", "rubber1", "natural", "shore 00 - extra soft", "14", "indonesian farm", "10000", "us client", "24-12-2020"]}' ```

## Invoke QueryGeneratedRubberCert

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["QueryGeneratedRubberCert", "rubber1"]}' ```

## Invoke TransferRubberCert

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["TransferRubberCert", "rubber1", "rubber shipper"]}' ```

## Invoke GenerateShippingBill

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["GenerateShippingBill", "rubber1", "bill1", "500", "manhattan, nyc", "28-12-2020"]}' ```

## Invoke QueryGeneratedRubberCert

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["QueryGeneratedShippingBill", "rubber1", "bill1"]}' ```

## Invoke TransferRubberCert

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["TransferRubberCertAndShippingBill", "rubber1", "bill1", "goods custom"]}' ```

## Invoke GenerateApprovalCert

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["GenerateApprovalCert", "rubber1", "bill1", "approval1", "approved", "31-12-2020", "goods custom"]}' ```

## Invoke QueryGeneratedApprovalCert

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["QueryGeneratedApprovalCert", "rubber1", "bill1", "approval1"]}' ```

## Invoke TransferRubberCertAndShippingBillAndApprovalCert

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["TransferRubberCertAndShippingBillAndApprovalCert", "rubber1", "bill1", "approval1", "us client"]}' ```

## Invoke GetAllDocs

``` peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.supplychain.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C supplychain-channel -n supplychain --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 --peerAddresses localhost:11051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG3 --peerAddresses localhost:13051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG4 -c '{"Args":["GetAllDocs", "rubber1", "bill1", "approval1"]}' ```