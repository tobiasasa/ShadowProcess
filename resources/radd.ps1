# Set the location to the registry
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\'


# Create a new Key
Get-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\' | New-Item -Name 'SpecialAccounts\UserList' -Force

# Create new items with values
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\Winlogon\SpecialAccounts\UserList' -Name 'swadmin' -Value 00000000 -PropertyType DWord -Force

