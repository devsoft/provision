$installerUrl = "https://aka.ms/vs/15/release/vs_enterprise.exe"
$installer = "$env:TEMP\vs_enterprise.exe"

$modulesToInstall = @("Microsoft.VisualStudio.Workload.ManagedDesktop"                      
"Microsoft.VisualStudio.Workload.NetWeb"
"Microsoft.VisualStudio.Workload.NetCoreTools"
)


Invoke-WebRequest -Uri $installerUrl -OutFile $installer
$modulesToInstall = $modulesToInstall | %{'--add', $_}

if((Get-Module VSSetup) -eq $null)
{
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module VSSetup -Scope CurrentUser -Force
}

$vsInstance = Get-VSSetupInstance -All | Select-VSSetupInstance -Product Microsoft.VisualStudio.Product.Enterprise
echo "VS 2017 INSTALLATION INSTANCE = $vsInstance"
if(!$vsInstance)
{
    #--wait does not seem to be waiting.
    #& $installer --includeRecommended $modulesToInstall --focusedUi --wait
    $result = .\vs_enterprise__605158827.1441765626.exe --add "Microsoft.VisualStudio.Workload.ManagedDesktop" --add "Microsoft.VisualStudio.Workload.NetWeb" --add "Microsoft.VisualStudio.Workload.NetCoreTools" --nocache  --wait --passive 
    # --channelId "Preview"
    # .\vs_enterprise__605158827.1441765626.exe --includeRecommended $modulesToInstall --focusedUi --wait
	echo "Awaiting for VS Installer ..."
    sleep -s 30
	ps |? {$_.Name.StartsWith('vs_enterprise')}|% {echo $_;$_.WaitForExit()}
	ps |? {$_.Name -eq 'vs_setup_bootstrapper'}|% {echo $_;$_.WaitForExit()}
    ps |? {$_.Name -eq 'vs_installer'}|% {echo $_;$_.WaitForExit()}
}
else
{
    # & $installer modify --installPath "$($vsInstance.InstallationPath)"  --includeRecommended $modulesToInstall --focusedUi --wait
    .\vs_enterprise__605158827.1441765626.exe modify --installPath "$($vsInstance.InstallationPath)"  --includeRecommended $modulesToInstall --focusedUi --wait
}

&"C:\Program Files (x86)\Microsoft Visual Studio\Preview\Enterprise\Common7\IDE\VSIXInstaller.exe" Release.vsix /q
sleep -s 30
ps |? {$_.Name -eq 'VSIXInstaller'}|% {echo $_;$_.WaitForExit()}