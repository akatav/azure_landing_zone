param location string
param hubName string = 'hub-vnet'

resource hubVnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: hubName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'GatewaySubnet' // Mandatory name for VPN Gateways
        properties: { addressPrefix: '10.0.1.0/24' }
      }
      {
        name: 'AzureFirewallSubnet' // Mandatory name for Firewalls
        properties: { addressPrefix: '10.0.2.0/24' }
      }
    ]
  }
}

output hubId string = hubVnet.id
