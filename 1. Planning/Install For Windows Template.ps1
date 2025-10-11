####
# Install Windows Server as template for deployments
####

# Upgrade to Windows Server Datacenter Core Production
dism /online /Set-Edition:ServerDatacenterCor /ProductKey:WX4NM-KYWYW-QJJR4-XV3QB-6VM33 /AcceptEula

# Upgrade to Windows Server Datacenter GUI Production
dism /online /Set-Edition:ServerDatacenter /ProductKey:WX4NM-KYWYW-QJJR4-XV3QB-6VM33 /AcceptEula

# Set the KMS domain for Windows Activation
slmgr.vbs /skms-domain theflightsims.com

# Activate Windows Server
slmgr.vbs /ato

# Set the NTP server to low latency server. Note please set the time-zone first
w32tm /config /manualpeerlist:"ntp.theflightsims.com,0x8 time.windows.com,0x8" /syncfromflags:all /reliable:yes /update
w32tm /resync

# Deploy using configuration template. Note that use SConfig to update Windows first
# General Functional Core Server
Install-WindowsFeature -ConfigurationFilepath ".\FunctionalCorServer_DeploymentConfigTemplate.xml"
# General Functional GUI Server
Install-WindowsFeature -ConfigurationFilepath ".\FunctionalGUIServer_DeploymentConfigTemplate.xml"

# Scan for Windows image curruption. Note: Reinstall Windows on error or repairable
dism /online /Cleanup-Image /ScanHealth

# Clean-up Windows
dism /online /Cleanup-Image /StartComponentCleanup
Remove-Item -Path "C:\Windows\SoftwareDistribution\*" -Include *.*

# Sysprep for system generalize
C:\Windows\System32\sysprep\sysprep.exe /generalize /shutdown /oobe
