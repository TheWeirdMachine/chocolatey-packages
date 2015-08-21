#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one
# REMOVE ANYTHING BELOW THAT IS NOT NEEDED

$ErrorActionPreference = 'Stop'; # stop on all errors


$packageName = 'enpass' # arbitrary name for the package, used in messages
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'http://dl.sinew.in/windows/setup/EnpassSetup-4.6.1.exe' # download url
$url64 = $url # 64bit URL here or remove - if installer is both, use $url

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' #only one of these: exe, msi, msu
  url           = $url
  url64bit      = $url64
  silentArgs    = "/S"
  validExitCodes= @(0)
  # optional
  registryUninstallerKey = 'enpass' #ensure this is the value in the registry
}

Install-ChocolateyPackage @packageArgs