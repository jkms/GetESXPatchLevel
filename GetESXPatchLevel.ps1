# ------------------------------------------------------------------------
# NAME: GetESXPatchLevel.ps1
# AUTHOR: John Stafford
# DATE:04/21/2014
# Version: v0.1
#
# COMMENTS: This script will prompt a user for a VCenter Server
# and then query all of the hosts for their patch level, and dump
# it in a CSV file. Simple.
#
# ------------------------------------------------------------------------

$vcenterserver = Read-Host 'Which vcenter server would you like to query?'
Connect-VIServer $vcenterserver

$outputfolder = "CSV"

$vmhosts = Get-VMHost | Sort Name | Where-Object {$_.State -eq "Connected"}
foreach ($vmhost in $vmhosts){
	$esxcli = Get-ESXCLI -VMHost $vmhost
	$esxcli.software.vib.list() | export-csv "$outputfolder\$vmhost.name.csv"
}
Disconnect-VIServer -confirm:$false