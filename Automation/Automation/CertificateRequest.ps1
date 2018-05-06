############
# This script generates certificate signing request and stores it to the reqPath folder
# Pre-req: 
#		execution policy must be set to allow script execution
#		Request folder must be valid
############

function RequestCert()
{
$infPath = Read-Host "Enter path of the inf file. (Ending with .inf)"
$reqPath = Read-Host "Enter path to store csr file. (Ending with .txt)"
$fqdn = Read-Host "Enter FQDN for certificate"
while(!$infPath){
$infPath = Read-Host "Inf path can not be empty. Please enter the path:"
}
while(!$reqPath){
$reqPath = Read-Host "Req path can not be empty. Please enter the path:"
}
while(!$fqdn){
$fqdn = Read-Host "FQDN can not be empty. Please enter the FQDN:"
}

Set-Content -Path $infPath -Value "
[Version]
Signature=`"`$Windows NT$`"

[NewRequest]
Subject = `"CN=$fqdn`"
KeySpec = 1
KeyLength =  2048
Exportable = TRUE
MachineKeySet = TRUE
SMIME = FALSE
PrivateKeyArchive = FALSE
UserProtected = FALSE
UseExistingKeySet = FALSE
ProviderType =  12
RequestType =  PKCS10
ProviderName = `"Microsoft RSA SChannel Cryptographic Provider`"
KeyUsage =  0xa8

[EnhancedKeyUsageExtension]
OID=1.3.6.1.5.5.7.3.1
" -Force

Invoke-Command{certreq.exe -new $infPath $reqPath}
}
RequestCert