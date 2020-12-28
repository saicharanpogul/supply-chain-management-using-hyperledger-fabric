'use strict'

const FabricCAServices = require('fabric-ca-client')
const { Wallets } = require('fabric-network')
const fs = require('fs')
const path = require('path')

async function main() {
    try {
        // load the network configuration
        const ccpPath = path.resolve(__dirname, 'connection-org4.json')
        const ccp = JSON.parse(fs.readFileSync(ccpPath, 'utf-8'))

        // Create a new CA Client for interacting with the CA.
        const caInfo = ccp.certificateAuthorities['ca.goodscustomorg4.supplychain.com']
        const caTLSCACerts = caInfo.tlsCACerts.pem
        const ca = new FabricCAServices(caInfo.url, { trustedRoots: caTLSCACerts, verify: false }, caInfo.caName)

        // Create a new file system based wallet for managing identities.
        const walletPath = path.join(process.cwd(), 'walletOrg4')
        const wallet = await Wallets.newFileSystemWallet(walletPath)
        console.log(`Wallet path: ${walletPath}`)

        // Check to see if we've already enrolled the admin user.
        const identity = await wallet.get('admin')
        if (identity) {
            console.log('An identity for the admin user "admin" already exists in the wallet')
            return
        }

        // Enroll the admin user, and import the new identity init the wallet.
        const enrollment = await ca.enroll({ enrollmentID: 'admin', enrollmentSecret: 'adminpw' })
        const x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: 'GoodsCustomOrg4MSP',
            type: 'X.509',
        }
        await wallet.put('admin', x509Identity)
        console.log('Successfully enrolled admin user "admin" and imported it into the wallet')
    } catch (error) {
        console.error(`Failed to enroll admin user "admin": ${error}`)
        process.exit(1)
    }
}

main()