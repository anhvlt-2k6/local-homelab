$themeName = "NEKOWORKSHOP"
$logoPath = "./illustration/banner.jpg"
$illustrationPath = "./illustration/illustration.jpg"

Set-AdfsProperties -EnableIdpInitiatedSignonPage $true

## Create new theme
New-AdfsWebTheme -Name "$themeName" -SourceName "DefaultAdfs2019"

## Set theme
Set-AdfsWebTheme -TargetName $themeName -Illustration @{path="$illustrationPath"}
Set-AdfsWebTheme -TargetName $themeName -Logo @{path="$logoPath"}
Set-AdfsGlobalWebContent -SignInPageDescriptionText "<p>Use your The Neko Workshop credential to sign in~<br>Image background by 佐倉おりこ@単行本発売中</p>"

## Set to current theme
Set-AdfsWebTheme -TargetName "$themeName"
Set-AdfsWebConfig -ActiveThemeName "$themeName"
