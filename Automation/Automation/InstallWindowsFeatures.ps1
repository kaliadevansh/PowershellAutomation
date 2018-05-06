############
# This script installs optional windows features with confirmation for each feature.
# After successful execution, the status of windows features is displayed.
# Pre-req: execution policy must be set to allow script execution
############

foreach ($feature in $a){
$status = $feature | Select-Object -Property InstallState -ExpandProperty InstallState
$featureName = $feature | Select-Object -Property Name -ExpandProperty Name
if($status -eq "Installed"){
    Write-Warning "Feature $featureName is already installed."
}
elseif($status -eq "Available"){
    if($featureName -eq "Web-server"){
        Install-WindowsFeature -Name $featureName -Confirm
    }
}
else{
Write-Warning "Feature $featureName is $status"
}
}

Write-host "##########################################################################################"
Write-host "Final Status"
Get-WindowsFeature 
Write-host "##########################################################################################"
