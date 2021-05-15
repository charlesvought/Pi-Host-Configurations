####Set Global Variables###
# Set path to log output to users' desktop
$UserPath = "$($env:USERPROFILE)\Desktop\PiHoleAlpha-Debug.txt"
#Set Pihole server variables
$piholeIPv4 = "8.8.8.8"
$piholeIPv6 = "8.8.4.4"


#Start Transcripting
Start-Transcript -Append -Path $UserPath
#Display prompt to user to confirm add settings
Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonType = [System.Windows.MessageBoxButton]::YesNoCancel
$MessageIcon = [System.Windows.MessageBoxImage]::Exclamation
$MessageBody = "Would you like to override the DNS settings on all network adapters to PiHole Alpha?

A log file will be created here:
" + $UserPath + "
(do not delete it for debugging purposes)

Created by: Charles Vought (cvought@gmail.com)?"
$MessageTitle = "Pi-Hole Alpha DNS Config"
$msgBoxInput = [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)

switch  ($msgBoxInput) {

	'Yes' {
		Write-Host "##### ADD PIHOLE SERVER ADDRESSES #####"
		Write-Host "# Existing DNS Settings..."
		Get-DnsClientServerAddress

		# Set new Pi-Hole DNS settings
		$AllNetAdapters=Get-NetAdapter
		foreach ($Adapter in $AllNetAdapters) {
    			Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -Validate -ServerAddresses ($piholeIPv4,$piholeIPv6)
			}
		#Display New DNS Configuration
		Write-Host "`r`n# New DNS Settings..."
		Get-DnsClientServerAddress
		#Clear the DNS Cache
		Write-Host "`r`n# Clearing DNS Cache...`r`n"
		Clear-DnsClientCache
		Write-Host "# Display IP Configurations"
		# Display IP Config Information
		ipconfig /all
		Write-Host "# All operations completed.`r`n"
		#Message to user confirming action
		Add-Type -AssemblyName PresentationCore,PresentationFramework
		$ButtonType = [System.Windows.MessageBoxButton]::OK
		$MessageIcon = [System.Windows.MessageBoxImage]::Information
		$MessageBody = "Your DNS settings have been changed to Pi-hole Alpha! It is also recommend you clear your web-browser cache."
 
		[System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
  	}

	'No' {
		Write-Host "##### RESET SERVER ADDRESSES #####"
		Write-Host "# Existing DNS Settings..."
		Get-DnsClientServerAddress

	    #Reset DNS setting back to default
		$AllNetAdapters=Get-NetAdapter
		foreach ($Adapter in $AllNetAdapters) {
    			Set-DnsClientServerAddress -InterfaceIndex $Adapter.ifIndex -ResetServerAddresses
			}
		Write-Host "`r`n# New DNS Settings..."
		Get-DnsClientServerAddress
		#Clear the DNS Cache
		Write-Host "`r`n# Clearing DNS Cache...`r`n"
		Clear-DnsClientCache
		Write-Host "# Display IP Configurations"
		# Display IP Config Information
		ipconfig /all
		Write-Host "# All operations completed.`r`n"
		#Message to user confirming action
		Add-Type -AssemblyName PresentationCore,PresentationFramework
		$ButtonType = [System.Windows.MessageBoxButton]::OK
		$MessageIcon = [System.Windows.MessageBoxImage]::Information
		$MessageBody = "Your DNS settings have been returned to default! Pi-hole DNS have been removed for all network adapters."
 
		[System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
  	}

	'Cancel' {
		Write-Host "##### CANCEL #####"
		#Message to user confirming action
		Add-Type -AssemblyName PresentationCore,PresentationFramework
		$ButtonType = [System.Windows.MessageBoxButton]::OK
		$MessageIcon = [System.Windows.MessageBoxImage]::Information
		$MessageBody = "No Changes have been made to your system."
 
		[System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
	}

}