#Declaring Variables
#$var1 = "x.x.x.x"
#$var2 = "x.x.x.x"
#$Adapter1 = Get-NetAdapter * | select -expand name

#Assigning primary and secondary DNS servers
#netsh interface ipv4 set dnsservers name=$Adapter1 static $var1 primary
#netsh interface ipv4 add dnsservers name=$Adapter1 $var2 index=2
#Write-Host "The Primary DNS is:" $var1
#Write-Host "The Secondary DNS is:" $var2
#exit

# Ask for elevated permissions if required
#If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
#	Start-Process powershell.exe "-noexit -NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
#}
#Set path to log output to users' desktop
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
#Display IP Config Information
ipconfig /all