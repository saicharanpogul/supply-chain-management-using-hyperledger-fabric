# Supply Chain Management Using Hyperledger Fabric

## Blockchain Use Case Scenario based on "Hyperledger Fabric - v2.2.1"
### Supply Chain Management of Rubber
**Components of Fabric Architecture**

_Organizations: 5_
* Orderer Organization: 1
  * Fabric CA
    * Orderer1
    * Orderer2
    * Orderer3
* Peer Organization: 4
  * Indonesian Farm (Exporter)
    * Fabric CA
      * 2 Peers (peer0 & peer1)
  * Rubber Shipper (Shipper)
    * Fabric CA
      * 2 Peers (peer0 & peer1)
  * Goods Custom (Custom)
    * Fabric CA
      * 2 Peers (peer0 & peer1)
  * US Client (Importer)
    * Fabric CA
      * 2 Peers (peer0 & peer1)

_Before executing script files please provide necessary permissions to the script files_
##### Step 1:
> Download all [Prerequisites](https://hyperledger-fabric.readthedocs.io/en/v2.2.0/prereqs.html) from fabric docs and then [Install Samples, Binaries, and Docker Image](https://hyperledger-fabric.readthedocs.io/en/v2.2.0/install.html) using <br> `curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.1 1.4.9` <br> in `$HOME/fabric/` which downloads all `./fabric-samples` and then export the path of bin directory in fabric-samples `export PATH=$HOME/fabric/fabric-samples/bin` of at it to `.bashrc` file and save the changes by executing `source .bashrc` once the prerequisites and fabric binaries are in place then clone the repo in `/fabric` directory.

#### Step 2:
> Now execute `./start_ca.sh` script file to run the 4 CA containers and bring up the fabric-ca-server of all 5 organizations. <br>
> _All docker-compose files are in docker directory._ It creates a organizations directory `/supplychain-network/organizations/fabric-ca/` containing self-signed root CA and TLSCA certificates, which are then used by fabric-ca-client to generate crypto material for all components (peers, admins, users, and orderers). <br>
> Which is done by going to `./supplychain-network/fabric-ca-server-scripts/` directory where `./create_certs.sh` script file is present and it is responsible to generate all necessary crypto material when executed, in `~/supplychain-network/organizations/fabric-ca/ordererOrganizations/` for 3 orderers and `~/supplychain-network/organizations/fabric-ca/peerOrganizations/` for peers, using fabric-ca-client utility tool present in fabric samples bin directory and all certificates are moves to their respective directories.

#### Step 3:
> Now in `./supplychain-network/` directory execute `./create_artifacts.sh` to create genesis block (supplychain-sys-channel), channel artifact, and anchor peer update artifacts using _configtxgen_ tool present in bin directory of fabric-samples. which takes `./configtx.yaml` as input and generated all respective artifacts in `./channel-artifacts/` directory, which are mapped into docker containers which will be started in next step. <br>
> Now run the `.start_network.sh` script file which brings up all the 8 peers, 3 orderer, and 4 CouchDB containers. <br>
> Once the containers are up and running then again go to `/supplychain-network/` directory and execute `./chaincode-lifecycle.sh` script file which will perform various [Chaincode Lifecycle](https://hyperledger-fabric.readthedocs.io/en/v2.2.0/commands/peerlifecycle.html?highlight=chaincode%20lifecycle) steps. <br>
> After all chaincode lifecycle steps are executed the fabric network and application channel (supplychain-channel) are ready to perform different functions of chaincode which is in `~/fabric/chaincode/supplychain/go/` directory. <br>
> Now 4 more containers (dev-chaincode) are up and running for each organization. <br>

#### Step 4:
> To call chaincode functions go to `./fabric/api/`  directory and by installing node modules `npm instal`, it will download all necessary node modules which are used in fabric-node-client, written using [Hyperledger Fabric SDK for Node.js](https://hyperledger.github.io/fabric-sdk-node/release-2.2/index.html). <br>
> And a Express API application is setup which can be used when the respective Org(\$) `./serverOrg($)` Express APIs are running and listening on ports(8081-4) {execute API functions in this order (registerenrolluser/, generaterubbercer/, querygeneratedrubbercert/, transferrubbercert/, ...) and organizations in (Org1, Org3, Org4, Org2) order} follow the bellow given Postman collection and docs using localhost.
> _The business logic is as follow:_ <br>
> Indonesian Farm(org1) is an exporter who exports rubber to the international clients (in our case US Client(Org2) importer of rubber). Exporter generates some certificates related to rubber. And then that certificate is transferred to shipper(in our case Rubber Shipper(Org3)). <br>
> Once the rubber certificate is transferred to shipper based on different variables the shipper generates the bill for transportation chargers. During transportation process shipper has to deal with different customs but in our case there is a single custom i.e. Goods Custom(Org4). <br>
> Once the rubber certificate and shipping bill is transferred to the custom by the shipper, custom is responsible to validate those 2 documents and approve the shipping and generate a approval certificate and then transfer all 3 documents to the importer(in our case US Client(Org2)).
> Importer can just query and get all 3 documents.
> The API function names and parameters are self explanatory. Refer Postman docs.
> **Note:** Before running Express Apps of 4 organizations, first execute `./enrollAdminOrg($).js` which will enroll node clients in the fabric network and stores the ID related files in respective `./walletOrg($)/` wallets and `./connection-org($)/` connection profiles is used for mapping all crypto material of respective fabric components.

**The Fabric network is also deployed to Azure, APIs can be directly tested in Postman Client(Follow the example input's conventions)**
**A basic CLI based client is given in the repo `./cli-fabric-client/` developed using Go Lang(it is a experimental code and APIs of just Org1 are functional) the program registers and enroll users of org1 and generates rubber certificate and query it and generate a very bad :negative_squared_cross_mark: looking  certificate. It will be improved soon including all organizations APIs.**

## Fabric Client APIs (Node SDK) 
### Postman Collection Link: 
[GetPostman](https://www.getpostman.com/collections/acf21a6bcb49a2c4bcf2)

### Postman Docs Link:
[Postman Docs](https://documenter.getpostman.com/view/5812247/TVsyfRYU)
