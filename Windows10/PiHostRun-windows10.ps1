# Set path to log output to users' desktop
$UserPath = "$($env:USERPROFILE)\Desktop\PiHoleDNS-Output.txt"
Start-Transcript -Append -Path $UserPath

Write-Host $PSCommandPath
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