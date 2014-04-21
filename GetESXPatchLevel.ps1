Connect-VIServer ld001vcenter01

$vmhosts = Get-VMHost | Sort Name | Where-Object {$_.State -eq "Connected"}
foreach ($vmhost in $vmhosts){
	$esxcli = Get-ESXCLI -VMHost ld001esxprd07.ld.corp.local
	$esxcli.software.vib.list() | export-csv "$vmhost.name.csv"
}