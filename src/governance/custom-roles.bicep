targetScope = 'subscription'

// Helper: generate a unique, deterministic GUID per role name
var roleGuidBase = guid(subscription().id, 'nexgen-role')

// ─────────────────────────────────────────────────────────
// 1. NexGen Platform Engineer (Contributor + no identity)
// ─────────────────────────────────────────────────────────
resource platformEngineer 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(roleGuidBase, 'platform-engineer')
  properties: {
    roleName: 'NexGen Platform Engineer'
    description: 'Everything except role assignments. Equivalent to Contributor plus User Access Admin restrictions.'
    assignableScopes: [ subscription().id ]
    permissions: [
      {
        actions: [ '*' ]
        notActions: [
          'Microsoft.Authorization/*/Delete'
          'Microsoft.Authorization/*/Write'
          'Microsoft.Authorization/elevateAccess/Action'
        ]
        dataActions: []
        notDataActions: []
      }
    ]
  }
}

// ─────────────────────────────────────────────────────────
// 2. NexGen DevOps Engineer (Compute, Network, Storage only)
// ─────────────────────────────────────────────────────────
resource devOpsEngineer 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(roleGuidBase, 'devops-engineer')
  properties: {
    roleName: 'NexGen DevOps Engineer'
    description: 'Manage compute, networking, and storage resources. Cannot manage identity or security settings.'
    assignableScopes: [ subscription().id ]
    permissions: [
      {
        actions: [
          // Core infrastructure resource providers
          'Microsoft.Compute/*'
          'Microsoft.Network/*'
          'Microsoft.Storage/*'

          // Need to create & manage resource groups
          'Microsoft.Resources/subscriptions/resourceGroups/read'
          'Microsoft.Resources/subscriptions/resourceGroups/write'
          'Microsoft.Resources/subscriptions/resourceGroups/delete'

          // Can deploy templates within allowed resource types
          'Microsoft.Resources/deployments/*'

          // Monitoring and diagnostics
          'Microsoft.Insights/*'

          // Recovery and backup for VMs
          'Microsoft.RecoveryServices/*'
        ]
        notActions: [
          // Block identity and access management
          'Microsoft.Authorization/*'
          'Microsoft.AzureActiveDirectory/*'
          'Microsoft.ManagedIdentity/*'
          'Microsoft.KeyVault/*'
        ]
        dataActions: []
        notDataActions: []
      }
    ]
  }
}

// ─────────────────────────────────────────────────────────
// 3. NexGen Developer (Read everything, deploy only to existing, no deletes)
// ─────────────────────────────────────────────────────────
resource developer 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(roleGuidBase, 'developer')
  properties: {
    roleName: 'NexGen Developer'
    description: 'Read-only across all services, with select actions to deploy code to existing compute targets. Cannot create new resources or delete anything.'
    assignableScopes: [ subscription().id ]
    permissions: [
      {
        actions: [
          '*/read'  // read everything

          // Actions needed to deploy code and configure existing services
          'Microsoft.Web/sites/publish/action'
          'Microsoft.Web/sites/extensions/write'
          'Microsoft.Web/sites/deployments/write'
          'Microsoft.Web/sites/config/write'
          'Microsoft.Web/sites/stop/action'
          'Microsoft.Web/sites/start/action'

          'Microsoft.Compute/virtualMachines/restart/action'
          'Microsoft.Compute/virtualMachines/start/action'
          'Microsoft.Compute/virtualMachines/deallocate/action'

          'Microsoft.Storage/storageAccounts/listKeys/action'

          'Microsoft.ContainerRegistry/registries/pull/read'
          'Microsoft.ContainerRegistry/registries/push/write'

          'Microsoft.AppPlatform/Spring/read'  // Azure Spring Apps
        ]
        notActions: [
          // Absolutely no deletes
          '*/delete'

          // Prevent creating new resources via templates
          'Microsoft.Resources/deployments/write'
        ]
        dataActions: []
        notDataActions: []
      }
    ]
  }
}

// ─────────────────────────────────────────────────────────
// 4. NexGen Security Reader
// ─────────────────────────────────────────────────────────
resource securityReader 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(roleGuidBase, 'security-reader')
  properties: {
    roleName: 'NexGen Security Reader'
    description: 'Read-only access to all resources, security center, and policies.'
    assignableScopes: [ subscription().id ]
    permissions: [
      {
        actions: [ '*/read' ]
        notActions: []
        dataActions: []
        notDataActions: []
      }
    ]
  }
}

// ─────────────────────────────────────────────────────────
// 5. NexGen Cost Manager
// ─────────────────────────────────────────────────────────
resource costManager 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  name: guid(roleGuidBase, 'cost-manager')
  properties: {
    roleName: 'NexGen Cost Manager'
    description: 'Read everything plus manage budgets and view cost data.'
    assignableScopes: [ subscription().id ]
    permissions: [
      {
        actions: [
          '*/read'
          'Microsoft.Consumption/*'
          'Microsoft.CostManagement/*'
          'Microsoft.Billing/*/read'
        ]
        notActions: []
        dataActions: []
        notDataActions: []
      }
    ]
  }
}
