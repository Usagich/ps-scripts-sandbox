param
(
    [string] $subscriptionId,
    [string] $csvPath = "./RmVM.csv"
)

Login-AzureRmAccount 
Set-AzureRmContext -SubscriptionId $subscriptionId

$VirtualMachines = Get-AzureRmVM
$VirtualMachines | Export-Clixml -Path ./vm.xml
