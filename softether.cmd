@setlocal enableextensions
@cd /d "%~dp0"
del /q softether-vpnclient-v4.*.exe
wget http://www.softether-download.com/files/softether/v4.22-9634-beta-2016.11.27-tree/Windows/SoftEther_VPN_Client/softether-vpnclient-v4.22-9634-beta-2016.11.27-windows-x86_x64-intel.exe

softether-vpnclient-v4.22-9634-beta-2016.11.27-windows-x86_x64-intel.exe


SET VPNCMD="C:\Program Files\SoftEther VPN Client\vpncmd.exe"


%VPNCMD%  localhost /CLIENT /CMD NicCreate SONGVPN