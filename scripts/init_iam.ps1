$githubOrganizationName = 'mygithubuser'
$githubRepositoryName = 'toy-website-auto-review'

$applicationRegistration = New-AzADApplication -DisplayName 'toy-website-auto-review'
New-AzADAppFederatedCredential `
    -Name 'toy-website-auto-review' `
    -ApplicationObjectId $applicationRegistration.Id `
    -Issuer 'https://token.actions.githubusercontent.com' `
    -Audience 'api://AzureADTokenExchange' `
    -Subject "repo:$($githubOrganizationName)/$($githubRepositoryName):pull_request"




New-AzADServicePrincipal -AppId $applicationRegistration.AppId
New-AzRoleAssignment `
    -ApplicationId $applicationRegistration.AppId `
    -RoleDefinitionName Contributor

$azureContext = Get-AzContext
Write-Host "AZURE_CLIENT_ID: $($applicationRegistration.AppId)"
Write-Host "AZURE_TENANT_ID: $($azureContext.Tenant.Id)"
Write-Host "AZURE_SUBSCRIPTION_ID: $($azureContext.Subscription.Id)"