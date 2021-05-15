# Ask for elevated permissions if required
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-noexit -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
}

Write-Host $PSCommandPath
# Set path to log output to users' desktop
$UserPath = "$($env:USERPROFILE)\Desktop\PiHoleDNS-Output.txt"
Start-Transcript -Append -Path $UserPath

Write-Host "# Existing DNS Settings..."
Get-DnsClientServerAddress

Set-DnsClientServerAddress -InterfaceIndex 14 -ResetServerAddresses

Write-Host "`r`n# New DNS Settings..."
Get-DnsClientServerAddress

Write-Host "`r`n# Clearing DNS Cache...`r`n"
Clear-DnsClientCache
Write-Host "# All operations completed.`r`n"
Write-Host "# Display IP Configurations"
# Display IP Config Information
ipconfig /all