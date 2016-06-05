$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'hp-ilo-cmdlets' # arbitrary name for the package, used in messages
$url = 'http://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1086382174/v116993/HPiLOCmdlets-x86.exe'
$url64 = 'http://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p2102165468/v116992/HPiLOCmdlets-x64.exe'
$fileType = 'msi'
$silentArgs = '/quiet'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\$packageName_Install.exe"

try {
    if (-not (Test-Path $filePath)) {
        New-Item -ItemType directory -Path $filePath
    }

    Get-ChocolateyWebFile $packageName $fileFullPath $url $url64
	
	Add-Type -assembly "system.io.compression.filesystem"
	[io.compression.zipfile]::ExtractToDirectory($fileFullPath, $filePath)

    $processor = Get-WmiObject Win32_Processor
    $is64bit = $processor.AddressWidth -eq 64

	if ($is64bit) {
	$file = "$filePath\HPILOCmdlets-x64.msi"
	} else {
	$file = "$filePath\HPILOCmdlets-x86.msi"
	}
    
    Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file	
	
} catch {
    throw
}

Remove-Item $filePath\* -recurse -force -exclude .exe