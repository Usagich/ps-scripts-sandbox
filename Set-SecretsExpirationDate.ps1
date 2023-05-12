param ([string]$SubscriptionId)

Connect-AzAccount -UseDeviceAuthentication
Set-AzContext -Subscription $SubscriptionId

$expires = (Get-Date).AddYears(3).AddMonths(1).AddDays(3).ToUniversalTime() #set your own. I choose 3 years 1 month and 3 days from now
$kvs = $(Get-AzKeyVault).VaultName

foreach ($kv in $kvs) 
{
    $secrets = $(Get-AzKeyVaultSecret -VaultName $kv).Name

    foreach ($secret in $secrets) 
    {
        Set-AzKeyVaultSecretAttribute -VaultName $kv -Name $secret -Expires $expires -PassThru
    }
}
