'use strict'

var express = require('express')
var bodyParser = require('body-parser')

var app = express()
app.use(bodyParser.json())

const { Gateway, Wallets } = require('fabric-network')
const path = require('path')
const fs = require('fs')

app.put('/api/generateapprovalcert/', async function (req, res) {
    try {
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org4.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg4')
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

        // Submit the specified transaction
        // GenerateApprovalCert has 6 arguments : rubberBatchNumber string, billNumber string, approvalCertNumber string, status string, date string, approvalCertHolder string
        // ex: {'GenerateApprovalCert' ,'rubber1', 'approval1', 'approve', '1-1-2021', 'us client'}

        await contact.submitTransaction(
            'GenerateApprovalCert', 
            req.body.rubberBatchNumber,
            req.body.billNumber,
            req.body.approvalCertNumber,
            req.body.status,
            req.body.date,
            req.body.approvalCertHolder
        )
        console.log('Transaction has been submitted')
        res.send('Transaction has been submitted')

        // Disconnect from the gateway.
        await gateway.disconnect()
    } catch (error) {
        console.log(`Failed to evaluate transaction: ${error}`)
        process.exit(1)
    }
})

app.get('/api/querygeneratedapprovalcert/:rubberBatchNumber', async function (req, res) {
    try {
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org4.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg4')
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
        // QueryGeneratedApprovalCert has 3 argument : rubberBatchNumber string, billNumber string, approvalCertNumber string
        // ex: {'QueryGeneratedApprovalCert', 'rubber1', 'bill1', 'approval1'}
        const result = await contact.evaluateTransaction('QueryGeneratedApprovalCert', req.params.rubberBatchNumber, req.body.billNumber, req.body.approvalCertNumber)
        console.log(`Transaction has been evaluated, result is: ${result.toString()}`)
        res.status(200).json({ response: result.toString()})

        //Disconnect from the gateway.
        await gateway.disconnect()
    } catch (error) {
        console.error(`Failed to evaluate transaction: ${error}`)
        process.exit(1)
    }
})

app.get('/api/transferrubbercertandshippingbillandapprovalcert/:rubberBatchNumber', async function (req, res) {
    try {
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org4.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg4')
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
        // TransferRubberCertAndShippingBillAndApprovalCert has 4 argument : rubberBatchNumber string, billNumber string, approvalCertNumber string, newApprovalHolder string
        // ex: {'TransferRubberCertAndShippingBillAndApprovalCert', 'rubber1', 'bill1', 'approval1', 'us client'}
        const result = await contact.evaluateTransaction('TransferRubberCertAndShippingBillAndApprovalCert', req.params.id, req.body.newRubberCertHolder)
        console.log('Transaction has been submitted')
        res.send('Transaction has been submitted')

        //Disconnect from the gateway.
        await gateway.disconnect()
    } catch (error) {
        console.error(`Failed to evaluate transaction: ${error}`)
        process.exit(1)
    }
})

app.listen(8084, 'localhost');
console.log('Goods Custom Organization 4 running on http://localhost:8084');