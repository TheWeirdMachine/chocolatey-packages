#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one
# REMOVE ANYTHING BELOW THAT IS NOT NEEDED
# Auto Uninstaller should be able to detect and handle registry uninstalls (if it is turned on, it is in preview for 0.9.9).

$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'hp-oa-cmdlets'
# registry uninstaller key name is the key that is found at HKLM:\Software\Windows\CurrentVersion\Uninstall\ THE NAME
$registryUninstallerKeyName = '{FEA3D3B6-EF5C-4287-A5F0-4A089970C52F}' #ensure this is the value in the registry
$msiProductCodeGuid = '{FEA3D3B6-EF5C-4287-A5F0-4A089970C52F}'
$shouldUninstall = $true

$local_key     = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
# local key 6432 probably never exists
$local_key6432   = "HKCU:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName" 
$machine_key   = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"
$machine_key6432 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryUninstallerKeyName"

$file = @($local_key, $local_key6432, $machine_key, $machine_key6432) `
    | ?{ Test-Path $_ } `
    | Get-ItemProperty `
    | Select-Object -ExpandProperty UninstallString

if ($file -eq $null -or $file -eq '') {
    Write-Host "$packageName has already been uninstalled by other means."
    $shouldUninstall = $false
}

$installerType = 'MSI' 
$silentArgs = "$msiProductCodeGuid /qn /norestart"
$validExitCodes = @(0, 3010, 1605, 1614, 1641)
$file = ''

if ($shouldUninstall) {
 Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
}