param location string
param spokeName string
param hubId string // We pass the Hub ID into this module

resource spokeVnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: spokeName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.1.0.0/16']
    }
  }
}

// This is the "Bridge" connecting Spoke to Hub
resource spokeToHubPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2023-05-01' = {
  parent: spokeVnet
  name: 'spoke-to-hub'
  properties: {
    remoteVirtualNetwork: { id: hubId }
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
  }
}
// This exports the ID of the first subnet so main.bicep can see it
output subnetId string = spokeVnet.properties.subnets[0].id
