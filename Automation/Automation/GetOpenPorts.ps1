#
#Test and update comment
# GetOpenPorts.ps1
#
$getProcess = Get-Process
$listeningPorts = @()
$getPorts = netstat -a -n -o
$skipHeadings = 0;

foreach($port in $getPorts){
if($skipHeadings -le 3){ 
#needs check
$skipHeadings++;
continue;
}

$a = $port -split '\s\s*'
$ports = New-Object System.Object;
$ports |Add-Member -MemberType NoteProperty -Name 'Protocol' -Value $a[1]
$ports |Add-Member -MemberType NoteProperty -Name 'Local Address' -Value $a[2]
$ports |Add-Member -MemberType NoteProperty -Name 'Foreign Address' -Value $a[3]

if($a[1] -eq "UDP"){
$ports |Add-Member -MemberType NoteProperty -Name 'State' -Value ""
$ports |Add-Member -MemberType NoteProperty -Name 'PID' -Value $a[4]
}
else{
$ports |Add-Member -MemberType NoteProperty -Name 'State' -Value $a[4]
$ports |Add-Member -MemberType NoteProperty -Name 'PID' -Value $a[5]
}
$b = $ports.PID;
$val = $getProcess | where{$_.Id -eq $b} | SELECT -Property ProcessName -ExpandProperty ProcessName
$ports |Add-Member -MemberType NoteProperty -Name 'ProcessName' -Value $val
$listeningPorts += $ports
}
$listeningPorts

