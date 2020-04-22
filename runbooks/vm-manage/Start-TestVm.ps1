workflow Start-TestVm
{
 Param(
  [string]$VM,
  [string]$ResourceGroup
 )
# Ensures that you do not inherit an AzContext in your runbook
Disable-AzContextAutosave –Scope Process

$Conn = Get-AutomationConnection -Name AzureRunAsConnection
Connect-AzAccount -ServicePrincipal -Tenant $Conn.TenantID -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint
Set-AzContext -SubscriptionId "f32205a4-a094-4fd9-8b98-3122eb6b1889"

Start-AzVM -Name $VM -ResourceGroupName $ResourceGroup
}
