param location string
param kvName string

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: kvName
  location: location
  properties: {
    sku: { family: 'A', name: 'standard' }
    tenantId: subscription().tenantId
    enableRbacAuthorization: true // This is the modern "Platform" way to do it
    enabledForDeployment: true
    enabledForTemplateDeployment: true
  }
}

output kvId string = keyVault.id
