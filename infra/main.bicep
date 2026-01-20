param location string = resourceGroup().location
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'name'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'Subnet-2'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}

// 1. Deploy Central Logging First
module logging './logging.bicep' = {
  name: 'loggingDeploy'
  params: {
    location: location
  }
}

// 1. The Hub
module hub './hub.bicep' = {
  name: 'hubDeploy'
  params: {
    location: location
  }
}

// 2. The Spoke
module spoke './spoke.bicep' = {
  name: 'spokeDeploy'
  params: {
    location: location
    spokeName: 'app-vnet'
    // THIS LINE BELOW CREATES THE CONNECTION IN THE VISUALIZER
    hubId: hub.outputs.hubId 
  }
}
// 3. Deploy Security
module vault './keyvault.bicep' = {
  name: 'vaultDeploy'
  params: { 
    location: location
    kvName: 'kv-prod-001' 
    workspaceId: logging.outputs.workspaceId // LINKING STEP
  }
}

// 4. Deploy the App into the Spoke
module app './appservice.bicep' = {
  name: 'appDeploy'
  params: { 
    location: location
    appName: 'platform-web-app'
    subnetId: spoke.outputs.subnetId
  }
}
