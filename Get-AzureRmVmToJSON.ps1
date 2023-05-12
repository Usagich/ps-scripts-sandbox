param
(
    [string] $subscriptionId,
    [string] $csvPath = "./RmVM.csv"
)

Login-AzureRmAccount 
Set-AzureRmContext -SubscriptionId $subscriptionId

####output file
$jsonPath = "./VM.json"

$VirtualMachines = Get-AzureRmVM
$json = ConvertTo-Json -InputObject $VirtualMachines

$json | New-Item $jsonPath
