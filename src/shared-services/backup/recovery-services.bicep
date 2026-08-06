targetScope = 'resourceGroup'

param location string = 'eastus'

resource rsv 'Microsoft.RecoveryServices/vaults@2023-06-01' = {
  name: 'rsv-nexgen-hub-eastus'
  location: location
  sku: { name: 'RS0', tier: 'Standard' }
  properties: {
    publicNetworkAccess: 'Disabled'          // ready for Private Endpoint
  }
}

resource vmBackupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-06-01' = {
  parent: rsv
  name: 'policy-vm-daily-30days'
  properties: {
    backupManagementType: 'AzureIaasVM'
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: ['2024-01-01T02:00:00Z']   // 2 AM UTC daily
    }
    retentionPolicy: {
      retentionPolicyType: 'LongTermRetentionPolicy'
      dailySchedule: {
        retentionTimes: ['2024-01-01T02:00:00Z']
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
    instantRpRetentionRangeInDays: 2
  }
}

output rsvId string = rsv.id
output rsvName string = rsv.name
output backupPolicyName string = vmBackupPolicy.name
