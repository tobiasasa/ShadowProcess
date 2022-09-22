$path1 = 'HKLM:\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\Winlogon\SpecialAccounts\UserList'
New-item -Path $path1
New-ItemProperty -Path $path1 -Name 'swadmin' -Value 00000000 -PropertyType DWord
