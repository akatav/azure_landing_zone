param location string
param workspaceName string = 'log-platform-prod'

resource logWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: workspaceName
  location: location
  properties: {
    sku: { name: 'PerGB2018' }
    retentionInDays: 30
  }
}

output workspaceId string = logWorkspace.id
