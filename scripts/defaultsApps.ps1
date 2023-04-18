# Setup ICMPv4 Access
New-NetFirewallRule -Name 'AllowICMPv4' -DisplayName 'AllowICMPv4' -Profile 'Any' -Direction 'Inbound' -Action 'Allow' -Protocol 'ICMPv4' -Program 'Any' -LocalAddress 'Any' -RemoteAddress 'Any'


# Install the Datto Agent for Servium
$drive = 'C:\Packages'
$appName = 'Datto'
New-Item -Path $drive -Name $appName  -ItemType Directory -ErrorAction SilentlyContinue
$LocalPath = $drive + '\' + $appName 
set-Location $LocalPath
$URL = 'https://merlot.centrastage.net/csm/profile/downloadAgent/a6b76582-413f-4150-b45d-9813a5341650'
$URLexe = 'DattoAgent.exe'
$outputPath = $LocalPath + '\' + $URLexe
Invoke-WebRequest -Uri $URL -OutFile $outputPath
write-host 'Starting the install of Datto Agent'
Start-Process -FilePath $outputPath -Args "/install /VERYSILENT"
write-host 'Finished the install of Datto Agent'

# Turn off IE Enhanced Security Configuration for Administrators
function Disable-InternetExplorerESC {
    Write-Host "Disabling IE Enhanced Security Configuration (ESC)..."
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 1
    Stop-Process -Name Explorer
}
# Disable ESC
Disable-InternetExplorerESC

# Set GMT as the Timezone
Set-TimeZone -Id "New Zealand Standard Time"

# Set Region/Format
Set-Culture en-NZ