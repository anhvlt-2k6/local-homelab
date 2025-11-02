$certThumb = "";

$isADFSInstalled = $false
$getADFSRole = Get-WindowsFeature -Name "ADFS-Federation"
if ($getADFSRole.InstallState -eq "Installed") {
	Write-Host "AD FS Services are installed!"
	$isADFSInstalled = $true
} else {
	Write-Host "AD FS Services are not installed. Try installing..."
	Install-WindowsFeature ADFS-Federation -IncludeManagementTools
}

Import-Module ADFS

Write-Host "Creating new KDS Root Key"
Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))

Write-Host "Promoting new AD FS Farm"
Install-AdfsFarm `
	-CertificateThumbprint:"$certThumb" `
	-FederationServiceDisplayName:"The Neko Workshop Federation Service" `
	-FederationServiceName:"adfs.workshop.neko" `
	-GroupServiceAccountIdentifier:"WORKSHOP\adfssrv`$" `
	-SQLConnectionString:"Data Source=db.workshop.neko;Initial Catalog=ADFSConfiguration;Integrated Security=True;Min Pool Size=20;Encrypt=True"
