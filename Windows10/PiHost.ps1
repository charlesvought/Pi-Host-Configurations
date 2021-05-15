If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -windowstyle hidden -Verb RunAs
} else {
    Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/charlesvought/Pi-Host-Configurations/main/Windows10/PiHostRun-windows10.ps1'))
}
