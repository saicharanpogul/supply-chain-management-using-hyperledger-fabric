'use strict'

const { registerEnroll } = require('./registerEnrollClientUserOrg4')
let express = require('express')
let bodyParser = require('body-parser')

let app = express()
app.use(bodyParser.json())

const { Gateway, Wallets } = require('fabric-network')
const path = require('path')
const fs = require('fs')

app.get('/', async function (req, res) {
    try {
        console.log("Test Pass!..")
        res.status(200).json({ response: "Test Pass!..."})
    } catch (error) {
        console.log("Test Fail!..")
        process.exit(1)
    }
})

app.post('/api/registerenrolluserorg4/', async function (req, res) {

    try {
        let err = await registerEnroll(req.body.username)
        if (err) {
            throw new Error(err)
        }

        res.status(201).json({ 
                status : "pass",
                message : `Successfully registered and enrolled user ${req.body.username.toUpperCase()} and imported it into the wallet`
            })
    } catch (error) {
        res.status(501).json({
        status : "fail",
        message : error.message
    })
    }
})

app.post('/api/generateapprovalcert/', async function (req, res) {
    try {
        const username = req.body.username
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org4.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg4')
        const wallet = await Wallets.newFileSystemWallet(walletPath)
        console.log(`Wallet path: ${walletPath}`)

        // Check to see if we've already enrolled the user.
        const identity = await wallet.get(username)
        if (!identity) {
            console.log(`An identity for the user "${username}" does not exist in the wallet`)
            console.log('Run the registerUser.js application before retrying')
            throw new Error(`An identity for the user ${username.toUpperCase()} does not exist in the wallet`)
            return
        }

        // Create a new gateway for connecting to our peer node.
        const gateway = new Gateway()
        await gateway.connect(ccp, { 
            wallet, 
            identity: username, 
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
        // ex: {'GenerateApprovalCert' ,'rubber1', 'bill1', 'approval1', 'approve', '1-1-2021', 'goods custom'}

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
        res.status(201).json({
            result: 'Transaction has been submitted',
            error: null
        })

        // Disconnect from the gateway.
        await gateway.disconnect()
    } catch (error) {
        console.log(`Failed to evaluate transaction: ${error}`)
        res.status(400)({
            result : null,
            error : error.message
            })
    }
})

app.get('/api/querygeneratedapprovalcert/', async function (req, res) {
    try {
        const username = req.body.username
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org4.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg4')
        const wallet = await Wallets.newFileSystemWallet(walletPath)
        console.log(`Wallet path: ${walletPath}`)

        // Check to see if we've already enrolled the user.
        const identity = await wallet.get(username)
        if (!identity) {
            console.log(`An identity for the user "${username}" does not exist in the wallet`)
            console.log('Run the registerUser.js application before retrying')
            throw new Error(`An identity for the user ${username.toUpperCase()} does not exist in the wallet`)
            return
        }

        // Create a new gateway for connecting to our peer node.
        const gateway = new Gateway()
        await gateway.connect(ccp, { 
            wallet, 
            identity: username, 
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
        const result = await contact.evaluateTransaction('QueryGeneratedApprovalCert', req.body.rubberBatchNumber, req.body.billNumber, req.body.approvalCertNumber)
        console.log(`Transaction has been evaluated, result is: ${result.toString()}`)
        res.status(200).json({ 
            result: JSON.parse(result.toString()),
            error: null,
            })

        //Disconnect from the gateway.
        await gateway.disconnect()
    } catch (error) {
        console.error(`Failed to evaluate transaction: ${error}`)
        res.status(501).json({ 
            result: null,
            error: error.message
            })
    }
})

app.put('/api/transferrubbercertandshippingbillandapprovalcert/', async function (req, res) {
    try {
        const username = req.body.username
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org4.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg4')
        const wallet = await Wallets.newFileSystemWallet(walletPath)
        console.log(`Wallet path: ${walletPath}`)

        // Check to see if we've already enrolled the user.
        const identity = await wallet.get(username)
        if (!identity) {
            console.log(`An identity for the user ${username} does not exist in the wallet`)
            console.log('Run the registerUser.js application before retrying')
            throw new Error(`An identity for the user ${username.toUpperCase()} does not exist in the wallet`)
            return
        }

        // Create a new gateway for connecting to our peer node.
        const gateway = new Gateway()
        await gateway.connect(ccp, { 
            wallet, 
            identity: username, 
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
        const result = await contact.submitTransaction('TransferRubberCertAndShippingBillAndApprovalCert', req.body.rubberBatchNumber, req.body.billNumber, req.body.approvalCertNumber, req.body.newApprovalHolder)
        console.log('Transaction has been submitted')
        res.status(202).json({
            result: 'Transaction has been submitted',
            error: null
        })

        //Disconnect from the gateway.
        await gateway.disconnect()
    } catch (error) {
        console.error(`Failed to evaluate transaction: ${error}`)
        res.status(501).json({
            result: null,
            error: error.message
        })
    }
})

app.listen(8084, 'localhost');
console.log('Goods Custom Organization 4 running on http://localhost:8084');