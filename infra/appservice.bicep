param location string
param appName string
param subnetId string // We will link this to our Spoke network

resource appPlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: '${appName}-plan'
  location: location
  sku: { name: 'F1' } // Free tier SKU
}

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appPlan.id
    httpsOnly: true
    virtualNetworkSubnetId: subnetId // Connects the app to the network we built
  }
}

// Add this after your webApp resource
resource scalingRules 'Microsoft.Insights/autoscaleSettings@2022-10-01' = {
  name: '${appName}-autoscale'
  location: location
  properties: {
    targetResourceUri: appPlan.id
    enabled: true
    profiles: [
      {
        name: 'Default'
        capacity: { minimum: '1', maximum: '3', default: '1' }
        rules: [
          // Scaling logic would go here
        ]
      }
    ]
  }
}
