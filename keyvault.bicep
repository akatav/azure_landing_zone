param location string
param kvName string
param workspaceId string // Add this new param

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

// Existing Key Vault resource code...

resource kvDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: 'to-central-logs'
  scope: keyVault
  properties: {
    workspaceId: workspaceId
    logs: [
      {
        category: 'AuditEvent'
        enabled: true
      }
    ]
  }
}

output kvId string = keyVault.id
