'use strict'

const { registerEnroll } = require('./registerEnrollClientUserOrg3')
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

app.post('/api/registerenrolluserorg3/', async function (req, res) {

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


app.post('/api/generateshippingbill/', async function (req, res) {
    try {
        const username = req.body.username
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org3.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg3')
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
        const contract = network.getContract('supplychain')

        // Submit the specified transaction
        // GenerateShippingBill has 5 arguments :rubberBatchNumber string, billNumber string, shippingCost int, address string, estimatedDeliveryDate string
        // ex: {'GenerateShippingBill' ,'rubber1', 'bill1', '1000', 'NY, USA', '31-12-2020'}

        await contract.submitTransaction(
            'GenerateShippingBill', 
            req.body.rubberBatchNumber,
            req.body.billNumber,
            req.body.shippingCost,
            req.body.address,
            req.body.estimatedDeliveryDate
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
        res.status(400).json({
            result: null,
            error: error.message
        })
    }
})

app.get('/api/querygeneratedshippingbill/', async function (req, res) {
    try {
        const username = req.body.username
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org3.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg3')
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
        const contract = network.getContract('supplychain')

        // Evaluate the specified transaction
        // QueryGeneratedShippingBill has 2 argument : rubberBatchNumber string, billNumber string
        // ex: {'QueryGeneratedShippingBill', 'rubber1', 'bill1'}
        const result = await contract.evaluateTransaction('QueryGeneratedShippingBill', req.body.rubberBatchNumber, req.body.billNumber)
        console.log(`Transaction has been evaluated, result is: ${result.toString()}`)
        res.status(200).json({
            result: JSON.parse(result.toString()),
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

app.put('/api/transferrubbercertandshippingbill/', async function (req, res) {
    try {
        const username = req.body.username
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org3.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg3')
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
        const contract = network.getContract('supplychain')

        // Evaluate the specified transaction
        // TransferRubberCertAndShippingBill has 3 argument : rubberBatchNumber string, billNumber string, newBillHolder string
        // ex: {'TransferRubberCertAndShippingBill', 'rubber1', 'bill1', 'goods custom'}
        const result = await contract.submitTransaction('TransferRubberCertAndShippingBill', req.body.rubberBatchNumber, req.body.billNumber, req.body.newBillHolder)
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

app.listen(8083, 'localhost');
console.log('Rubber Shipper Organization 3 running on http://localhost:8083');