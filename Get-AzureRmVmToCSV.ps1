param
(
    [string] $subscriptionId,
    [string] $csvPath = "./RmVM.csv"
)

Login-AzureRmAccount 
Set-AzureRmContext -SubscriptionId $subscriptionId

####output file
$csvPath = "./RmVM.csv"
###will be deleted after data collecting
$tempFile = "./temp.txt"


$VirtualMachines = Get-AzureRmVM
foreach ($VM in $VirtualMachines)
{    
        $tagsVM = $VM.Tags
        $tagKeys = $tagsVM | Select -ExpandProperty Keys 
        $tagValues = $tagsVM | Select -ExpandProperty Values 

        "Name" + "`t" + "Location" + "`t" + "Resource Group" + "`t" + "Size" + "`t" + `
        "Tag Name" + "`t" + "Tag Value" > $tempFile

        for ($i = 0; $i -lt $tagsVM.Count; $i++)
        {
            $VM.Name + "`t" + $VM.Location + "`t" + $VM.ResourceGroupName + "`t" + `
            $VM.HardwareProfile.VmSize + "`t" + $tagKeys[$i] + "`t" + $tagValues[$i] >> $tempFile
        }

        ####importing VM info to CSV-file         
        Import-Csv  $tempFile -Delimiter "`t" | Export-Csv $csvPath -NoTypeInformation -Append
        Remove-Item $tempFile
      
}
