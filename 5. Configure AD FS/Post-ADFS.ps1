$themeName = "NEKOWORKSHOP"
$logoPath = "./illustration/banner.jpg"
$illustrationPath = "./illustration/illustration.jpg"

Set-AdfsProperties -EnableIdpInitiatedSignonPage $true

## Create new theme
New-AdfsWebTheme -Name "$themeName" -SourceName "DefaultAdfs2019"

## Set theme
Set-AdfsWebTheme -TargetName $themeName -Illustration @{path="$illustrationPath"}
Set-AdfsWebTheme -TargetName $themeName -Logo @{path="$logoPath"}
Set-AdfsGlobalWebContent -SignInPageDescriptionText "<p>Welcome to the Neko Workshop! Nyan~</p>" # @shiroinekotfs wrote this

## Set to current theme
Set-AdfsWebTheme -TargetName "$themeName"
Set-AdfsWebConfig -ActiveThemeName "$themeName"
