'use strict'

var express = require('express')
var bodyParser = require('body-parser')

var app = express()
app.use(bodyParser.json())

const { Gateway, Wallets } = require('fabric-network')
const path = require('path')
const fs = require('fs')

app.get('/api/getalldocs/:rubberBatchNumber', async function (req, res) {
    try {
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org2.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg2')
        const wallet = await Wallets.newFileSystemWallet(walletPath)
        console.log(`Wallet path: ${walletPath}`)

        // Check to see if we've already enrolled the user.
        const identity = await wallet.get('user1')
        if (!identity) {
            console.log('An identity for the user "user1" does not exist in the wallet')
            console.log('Run the registerUser.js application before retrying')
            return
        }

        // Create a new gateway for connecting to our peer node.
        const gateway = new Gateway()
        await gateway.connect(ccp, { 
            wallet, 
            identity: 'user1', 
            discovery: { 
                enabled: true, 
                asLocalhost: true 
                } 
        })

        // Get the network (channel) our contract is deployed to.
        const network = await gateway.getNetwork('supplychain-channel')

        // Get the contract from the network.
        const contact = network.getContract('supplychain')

        // Evaluate the specified transaction
        // GetAllDocs has 1 argument : rubberBatchNumber string, billNumber string, approvalCertNumber string
        // ex: {'GetAllDocs', 'rubber1', 'bill1', 'approval1'}
        const result = await contact.evaluateTransaction(
            'GetAllDocs', 
            req.params.rubberBatchNumber, 
            req.body.billNumber,
            req.body.approvalCertNumber
            )
        console.log(`Transaction has been evaluated, result is: ${result.toString()}`)
        res.status(200).json({ response: result.toString()})

        //Disconnect from the gateway.
        await gateway.disconnect()
    } catch (error) {
        console.error(`Failed to evaluate transaction: ${error}`)
        process.exit(1)
    }
})

app.listen(8082, 'localhost');
console.log('US Client Organization 2 running on http://localhost:8082');