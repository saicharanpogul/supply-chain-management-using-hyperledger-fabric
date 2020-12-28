'use strict'

const { Wallets } = require('fabric-network')
const FabricCAServices = require('fabric-ca-client')
const fs = require('fs')
const path = require('path')

async function main() {
    try {
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org4.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new CA Client for interacting with the CA.
        const caURL = ccp.certificateAuthorities['ca.goodscustomorg4.supplychain.com'].url
        const ca =new FabricCAServices(caURL)

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg4')
        const wallet = await Wallets.newFileSystemWallet(walletPath)
        console.log(`Wallet path: ${walletPath}`)

        // CHeck to see if we've already enrolled the user.
        const userIdentity = await wallet.get('user1')
        if (userIdentity) {
            console.log('And identity for the user "user1" already exists in the wallet')
            return
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
            affiliation: 'org4.department1',
            enrollmentID: 'user1',
            role: 'client'
        }, adminUser)
        const enrollment = await ca.enroll({ 
            enrollmentID: 'user1',
            enrollmentSecret: secret
         })
        const x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'GoodsCustomOrg4MSP',
            type: 'X.509',
        }
        await wallet.put('user1', x509Identity)
        console.log('Successfully registered and enrolled user "user1" and imported it into the wallet')
    } catch (error) {
    console.log(`Failed to register user "user1": ${error}`)
    process.exit(1)
    }
}

main()