############
# This script copies data from source location to destination location
# Pre-req: 
#		execution policy must be set to allow script execution
#		user must have read access on source location and write access on destination location
############

function CopyFiles(){
$sourceLocation = Read-Host "Enter shared source location"
$destinationLocation = Read-Host "Enter shared destination location"

while(!$sourceLocation){
$sourceLocation = Read-Host "Source location can not be empty. Please enter source location."
}
while(!$destinationLocation){
$destinationLocation = Read-Host "Destination location can not be empty. Please enter destination location."
}

Copy-Item -Recurse -Path $sourceLocation -Destination $destinationLocation
}
CopyFiles