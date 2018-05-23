#
#Test and update comment
# CreateSharedFolder.ps1
#
GetInputValues
CreateFolder
ShareFolder

function GetInputValues(){
$path = Read-Host "Enter foler path to be shared" 
while(!$path){
Read-Host "Path can not empty. Please enter full folder path."
}
$ReadUsers = @()
do{
Write-Host "Enter users to give read shared access. Press enter after each entry and enter when done."
$input = Read-Host
$ReadUsers += $input
}
until($input -eq '')

$WriteUsers = @()
do{
Write-Host "Enter users to give write shared access. Press enter after each entry and enter when done."
$input = Read-Host
$WriteUsers += $input
}
until($input -eq '')
}
function CreateFolder(){
New-Item $path -type Directory -Force
}
function ShareFolder(){
$folderName = ($path.Split("\"))[$path.Length-1]
foreach($user in $ReadUsers){
New-SmbShare -Name $folderName -Path $path -ReadAccess $user
}
foreach($user in $WriteUsers){
New-SmbShare -Name $folderName -Path $path - $user
}
}
