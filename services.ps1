$services = "AppVClient,Browser,CscService,DiagTrack,DPS,lfsvc,NetTcpPortSharing,PcaSvc,RemoteAccess,SCardSvr,tzautoupdate,UevAgentService,WdiServiceHost,WdiSystemHost,WSearch,wuauserv,WerSvc,WinRM".split(',')
$services |%{cmd /C " sc stop $_"}
echo "Sleep in 60s before disable them"
sleep -s 60
$services |%{cmd /C "sc config $_ start= disabled"}

cmd /C "sc start WLANSvc"
sleep -s 4
cmd /C "sc config WLANSvc start= auto"

echo "Enabled WLAN"