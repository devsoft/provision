Set-TimeZone -Name "SE Asia Standard Time"

echo Installing .NET 3.5
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All 

echo Turn off powershell restriction
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Unrestricted"

echo Installing choco...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

echo VS 2017
rem choco install visualstudio2017enterprise -y
rem choco install visualstudio2017-workload-netweb --package-parameters "--productId Microsoft.VisualStudio.Product.Enterprise --channelId VisualStudio.15.Preview --includeOptional" -y
rem choco install visualstudio2017-workload-manageddesktop --package-parameters "--productId Microsoft.VisualStudio.Product.Enterprise --channelId VisualStudio.15.Preview --includeOptional" -y
rem choco install visualstudio2017-workload-netcoretools --package-parameters "--productId Microsoft.VisualStudio.Product.Enterprise --channelId VisualStudio.15.Preview --includeOptional" -y
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File vs2017.3.ps1

echo VS CODE
choco install visualstudiocode -y --ignore-checksums -f

echo misc software
choco install vscode-icons -y --ignore-checksums -f
choco install sublimetext3 -y --ignore-checksums -f
choco install bitvise-ssh-client -y --ignore-checksums -f
choco install onenote -y --ignore-checksums -f
choco install googlechrome -y --ignore-checksums -f
choco install nodejs -y --ignore-checksums -f
choco install sql-server-management-studio -y --ignore-checksums -f
choco install ncrunch-vs2017 -y --ignore-checksums -f
choco install git -y --ignore-checksums -f
choco install teamviewer8 -y --ignore-checksums -f
choco install git-credential-manager-for-windows -y --ignore-checksums -f
choco install wget -y --ignore-checksums -f
choco install curl -y --ignore-checksums -f
choco install cmder -y --ignore-checksums -f
choco install 7zip -y --ignore-checksums -f
choco install golang -y --ignore-checksums -f
choco install fiddler4 -y --ignore-checksums -f
choco install thunderbird -y --ignore-checksums -f

echo Installing Softether VPN
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File Softether.ps1

echo Installing SQL Anywhere
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File SqlAnywhere.ps1

echo Installing Valentina Studio 7
powershell ".\vstudio_x64_7_win.exe /silent; ps |? {$_.Name -eq 'vstudio_x64_7_win'}|% {echo $_;$_.WaitForExit()}"

echo Disable Windows Defender
Dism /online /Disable-Feature /FeatureName:Windows-Defender /Remove /NoRestart /quiet
powershell -NoProfile -ExecutionPolicy Unrestricted  add-windowsfeature wireless-networking;Remove-WindowsFeature Windows-Defender, Windows-Defender-GUI

echo Disable Server Manager run at start up 
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile "Disable-ScheduledTask -TaskPath '\Microsoft\Windows\Server Manager' -TaskName 'ServerManager'"

rem netsh advfirewall set allprofiles state off

echo Turn off telemetry services
powershell -NoProfile -ExecutionPolicy Unrestricted -File services.ps1



echo turn on Numlock
rem REG ADD "HKEY_USERS\Default\Control Panel\Keyboard" /v InitialKeyboardIndicators /t REG_DWORD /d 2
powershell "New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS;New-Item 'HKU:\.Default\Control Panel\Keyboard' -Force | New-ItemProperty -Name InitialKeyboardIndicators -Value 2 -Force | Out-Null"
regedit /s settings.reg
