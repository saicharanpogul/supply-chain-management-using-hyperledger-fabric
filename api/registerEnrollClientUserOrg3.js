'use strict'

const { Wallets } = require('fabric-network')
const FabricCAServices = require('fabric-ca-client')
const fs = require('fs')
const path = require('path')

module.exports.registerEnroll = async function registerEnroll(user) {
    try {
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org3.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new CA Client for interacting with the CA.
        const caURL = ccp.certificateAuthorities['ca.rubbershipperorg3.supplychain.com'].url
        const ca = new FabricCAServices(caURL)

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg3')
        const wallet = await Wallets.newFileSystemWallet(walletPath)
        console.log(`Wallet path: ${walletPath}`)

        // Check to see if we've already enrolled the user.
        const userIdentity = await wallet.get(user)
        if (userIdentity) {
            console.log(`And identity for the user "${user}" already exists in the wallet`)
            throw new Error(`And identity for the user ${user.toUpperCase()} already exists in the wallet`) 
        }

        // Check to see if we've already enrolled the admin user.
        const adminIdentity = await wallet.get('admin')
        if (!adminIdentity) {
            console.log('An identity for the admin user "admin" does not exist in the wallet')
            console.log('Run the enrollAdmin.js application before retrying')
            return
        }

        // build a user object for authenticating wit the CA 
        const provider = wallet.getProviderRegistry().getProvider(adminIdentity.type)
        const adminUser = await provider.getUserContext(adminIdentity, 'admin')

        // Register  the user, enroll the user and import the new identity into the wallet.
        const secret = await ca.register({
            affiliation: 'org1.department1',
            enrollmentID: user,
            role: 'client'
        }, adminUser)
        const enrollment = await ca.enroll({ 
            enrollmentID: user,
            enrollmentSecret: secret
         })
        const x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'RubberShipperOrg3MSP',
            type: 'X.509',
        }
        await wallet.put(user, x509Identity)
        console.log(`Successfully registered and enrolled user "${user}" and imported it into the wallet`)
        return null
    } catch (error) {
    console.log(`Failed to register user "${user}": ${error}`)
    return `Failed to register user ${user.toUpperCase()}: ${error}`
    }
}
