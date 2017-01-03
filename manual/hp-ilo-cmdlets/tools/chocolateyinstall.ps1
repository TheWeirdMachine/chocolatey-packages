$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'hp-ilo-cmdlets'
$url = 'https://downloads.hpe.com/pub/softlib2/software1/pubsw-windows/p1086382174/v123974/HPiLOCmdlets-x86.exe'
$url64 = 'https://downloads.hpe.com/pub/softlib2/software1/pubsw-windows/p2102165468/v123973/HPiLOCmdlets-x64.exe'
$checksum = '3E73A1C4ABF3287030378A71959EACDEA70DFA67E1438883E26E82567C4813C5'
$checksum64 = '5234469C71412E02F8BDCC297D32AE10EBE498A8812451CF4C233C50F7AF9DD1'
$checksumType = 'sha256'
$checksumType64 = 'sha256'
$fileType = 'msi'
$silentArgs = '/quiet'
$dlPkg = "$packageName" + ".exe"
$ValidExitCodes = '0'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if (Get-ProcessorBits 64) {
    $file = "HPILOCmdlets-x64.msi"
} else {
    $file = "HPILOCmdlets-x86.msi"
}

Get-ChocolateyWebFile -PackageName $packageName -FileFullPath "$toolsDir\$dlPkg" -Url $url -Url64 $url64 -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64
Get-ChocolateyUnzip -FileFullPath "$toolsDir\$dlPkg" -Destination $toolsDir 
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs "$toolsDir\$file" -ValidExitCodes $ValidExitCodes
