Invoke-WebRequest -Uri "http://www.softether-download.com/files/softether/v4.22-9634-beta-2016.11.27-tree/Windows/SoftEther_VPN_Client/softether-vpnclient-v4.22-9634-beta-2016.11.27-windows-x86_x64-intel.exe"  -OutFile .\SoftEther_VPN_Client.exe

.\SoftEther_VPN_Client.exe
 ps |? {$_.Name -eq 'SoftEther_VPN_Client'}|% {echo $_;$_.WaitForExit()}