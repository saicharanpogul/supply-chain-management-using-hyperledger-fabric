'use strict'

const { registerEnroll } = require('./registerEnrollClientUserOrg1')
let express = require('express')
let bodyParser = require('body-parser')

let app = express()
app.use(bodyParser.json())

const { Gateway, Wallets } = require('fabric-network')
const path = require('path')
const fs = require('fs')
const { error } = require('console')

app.get('/', async function (req, res) {
    try {
        console.log("Test Pass!..")
        res.status(200).json({ response: "Test Pass!..."})
    } catch (error) {
        console.log("Test Fail!..")
        process.exit(1)
    }
})

app.post('/api/registerenrolluserorg1/', async function (req, res) {

    try {
        let err = await registerEnroll(req.body.username)
        if (err) {
            throw new Error(err)
            return
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

app.post('/api/generaterubbercert/', async function (req, res) {
    try {
        const username = req.body.username
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org1.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg1')
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
        // GenerateRubberCert transaction - requires 8 arguments 
        // ex: {'GenerateRubberCert' ,'rubber1', 'natural', 'shore 00 soft', '25', 'indonesian farm', '10000', 'us client', '20-12-2020'}
        // rubberBatchNumber string, rubberType string, hardness string, tensileStrength int, rubberCertHolder string, weight int, buyer string, date string

        await contact.submitTransaction(
            'GenerateRubberCert', 
            req.body.rubberBatchNumber,
            req.body.rubberType,
            req.body.hardness,
            req.body.tensileStrength,
            req.body.rubberCertHolder,
            req.body.weight,
            req.body.buyer,
            req.body.date
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

app.get('/api/querygeneratedrubbercert/', async function (req, res) {
    try {
        const username = req.body.username
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org1.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg1')
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
        // QueryGeneratedRubberCert has 1 argument : rubberBatchNumber string
        // ex: {'QueryGeneratedRubberCert', 'rubber1'}
        const result = await contact.evaluateTransaction('QueryGeneratedRubberCert', req.body.rubberBatchNumber)
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

app.put('/api/transferrubbercert/', async function (req, res) {
    try {
        const username = req.body.username

        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org1.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg1')
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
        // TransferRubberCert has 2 argument : rubberBatchNumber string, newRubberCertHolder string
        // ex: {'TransferRubberCert', 'rubber1', 'rubber shipper'}
        const result = await contact.submitTransaction('TransferRubberCert', req.body.rubberBatchNumber, req.body.newRubberCertHolder)
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

app.listen(8081, 'localhost');
console.log('Indonesian Farm Organization 1 running on http://localhost:8081');

