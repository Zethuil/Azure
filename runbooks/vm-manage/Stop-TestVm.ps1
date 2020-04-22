workflow Stop-TestVm
{
 Param(
  [string]$VM,
  [string]$ResourceGroup,
  
  [Parameter (Mandatory = $false)]
  [object] $WebhookData
 )
# Ensures that you do not inherit an AzContext in your runbook
Disable-AzContextAutosave –Scope Process

$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
Set-AzContext -SubscriptionId "f32205a4-a094-4fd9-8b98-3122eb6b1889"

if ($WebhookData) 
{
 Stop-AzVM -Name (ConvertFrom-Json -InputObject $WebhookData.RequestBody).VM -ResourceGroupName (ConvertFrom-Json -InputObject $WebhookData.RequestBody).ResourceGroup
}
else
{
 Stop-AzVM -Name $VM -ResourceGroupName $ResourceGroup
}

}
