$themeName = "NEKOWORKSHOP"
$logoPath = "./illustration/banner.jpg"
$illustrationPath = "./illustration/illustration.jpg"

Set-AdfsProperties -EnableIdpInitiatedSignonPage $true

## Create new theme
New-AdfsWebTheme -Name "$themeName" -SourceName "DefaultAdfs2019"

## Set theme
Set-AdfsWebTheme -TargetName $themeName -Illustration @{path="$illustrationPath"}
Set-AdfsWebTheme -TargetName $themeName -Logo @{path="$logoPath"}
Set-AdfsGlobalWebContent -CompanyName "The Neko Workshop Federation Service" `
    -ErrorPageAuthorizationErrorMessage "Unable to authorize your account. Contact administrators for further assistance." `
    -ErrorPageDescriptionText "An error occurred while authenticating" `
    -ErrorPageDeviceAuthenticationErrorMessage "Unable to authorize your device. Contact administrators for further assistance." `
    -ErrorPageGenericErrorMessage "Contact administrators for further assistance." `
    -HelpDeskLink "https://learn.microsoft.com/en-us/windows-server/identity/identity-and-access" `
    -HelpDeskLinkText "Microsoft Identity and Access Help" `
    -PrivacyLink "https://go.microsoft.com/fwlink/?LinkId=521839" `
    -PrivacyLinkText "Microsoft Privacy Link" `
    -SignInPageDescriptionText "<p>Use your The Neko Workshop credential to sign in~<br>Image background by <a href='https://www.pixiv.net/en/users/1616936' targer='_blank'>Oriko Sakura</a>.­</p>"

## Set to current theme
Set-AdfsWebTheme -TargetName "$themeName"
Set-AdfsWebConfig -ActiveThemeName "$themeName"