# Get Windows Activation status
$isWSActivated = $false
$wsStatus = Get-CimInstance SoftwareLicensingProduct -Filter "Name like 'Windows%'" | Where-Object { $_.PartialProductKey } | Select-Object LicenseStatus
if ($wsStatus.LicenseStatus -eq 1) {
    $isWSActivated = $true
    Write-Host "Windows is activated!"
} else {
    Write-Host "Windows is not activated!" -ForegroundColor Red
}

# Get Windows image status
$isImageGood = $false
$wsImage = Repair-WindowsImage -Online -CheckHealth
if ($wsImage.ImageHealthState -eq "Healthy") {
    Write-Host "Windows Image is in good condition!" 
    $isImageGood = $true
} else {
    Write-Host "Windows Image is currupted! You should run diagnostic!" -ForegroundColor Red
}

if ($isImageGood -and $isWSActivated) {
	Write-Host "Installing IIS Roles (without .NET 3.5)"
	Install-WindowsFeature -ConfigurationFilePath ".\WEB_DeploymentConfigTemplate.xml"
}