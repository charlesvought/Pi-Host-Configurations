# Set path to log output to users' desktop
$UserPath = "$($env:USERPROFILE)\Desktop\PiHoleDNS-Output.txt"
#Start Transcripting
Start-Transcript -Append -Path $UserPath

Write-Host $PSCommandPath
Write-Host "# Existing DNS Settings..."
Get-DnsClientServerAddress

# Set new Pi-Hole DNS settings
$AllNetAdapters=Get-NetAdapter
foreach ($Adapter in $AllNetAdapters)
{
    Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -Validate -ServerAddresses ("8.8.8.8","8.8.4.4")
}

Write-Host "`r`n# New DNS Settings..."
Get-DnsClientServerAddress

Write-Host "`r`n# Clearing DNS Cache...`r`n"
Clear-DnsClientCache
Write-Host "# All operations completed.`r`n"
Write-Host "# Display IP Configurations"
# Display IP Config Information
ipconfig /all