# Chaincode Lifecycle Steps

## Package, Install, Query Installed, Approve, Query Approved, Check Commit Readiness  Chaincode using IndonesianFarmOrg1
**chaincode-env-scripts/**  
```source indonesianFarmOrg1Env.sh```

**chaincode-lifecycle-scripts/**  
```./package_chaincode.sh```

```./install_chaincode.sh```

*Copy the chaincode package identifier and:*
**export CHAINCODE_PACKAGE_ID=<new-package-identifier>**  
```./query_installed_chaincode.sh```

```./approve_chaincode.sh```

```./query_approved_chaincode.sh```

```./check_commit_readiness.sh```

## Install, Query Installed, Approve, Query Approved, Check Commit Readiness Chaincode using USClientOrg2
**chaincode-env-scripts/**  
```source usClientOrg2Env.sh```

**chaincode-lifecycle-scripts/**  
```./install_chaincode.sh```

```./query_installed_chaincode.sh```

```./approve_chaincode.sh```

```./query_approved_chaincode.sh```

```./check_commit_readiness.sh```

## Install, Query Installed, Approve, Query Approved, Check Commit Readiness Chaincode using RubberShipperOrg3
**chaincode-env-scripts/**  
```source rubberShipperOrg3Env.sh```

**chaincode-lifecycle-scripts/**  
```./install_chaincode.sh```

```./query_installed_chaincode.sh```

```./approve_chaincode.sh```

```./query_approved_chaincode.sh```

```./check_commit_readiness.sh```

## Install, Query Installed, Approve, Query Approved, Check Commit Readiness Chaincode using GoodsCustomOrg4
**chaincode-env-scripts/**  
```source goodsCustomOrg4Env.sh```

**chaincode-lifecycle-scripts/**  
```./install_chaincode.sh```

```./query_installed_chaincode.sh```

```./approve_chaincode.sh```

```./query_approved_chaincode.sh```

```./check_commit_readiness.sh```

## Commit Chaincode using all organizations ROOTCERT_FILEs
**chaincode-env-scripts/**  
```source all_org_tls_rootcert_file.sh```

**chaincode-lifecycle-scripts/**  
```./commit.sh```

## Query Committed Chaincode using IndonesianFarmOrg1
**chaincode-env-scripts/**  
```source indonesianFarmOrg1Env.sh```

**chaincode-lifecycle-scripts/**  
```./query_committed.sh```

## Query Committed Chaincode using USClientOrg2
**chaincode-env-scripts/**  
```source usClientOrg2Env.sh```

**chaincode-lifecycle-scripts/**  
```./query_committed.sh```

## Query Committed Chaincode using RubberShipperOrg3
**chaincode-env-scripts/**  
```source rubberShipperOrg3Env.sh```

**chaincode-lifecycle-scripts/**  
```./query_committed.sh```

## Query Committed Chaincode using GoodsCustomOrg4
**chaincode-env-scripts/**  
```source goodsCustomOrg4Env.sh```

**chaincode-lifecycle-scripts/**  
```./query_committed.sh```