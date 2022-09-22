$path1 = '\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
New-item -Path $path1 -Force
New-ItemProperty -Path $path1 -Name 'swadmin' -Value 00000000 -PropertyType DWord -Force
