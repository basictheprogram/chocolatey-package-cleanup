$ErrorActionPreference = 'Stop'; 

$packageName = 'CleanUp'
$version     = '452'
$fullPackage = $packageName + $version + '.exe'
$url         = 'http://stevengould.org/downloads/cleanup/' + $fullPackage
$checkSum    = '6ac7576c0b48ddee292f85724c7917e11360927ff8e5c5a8d795577a4241c131'
$workSpace   = Join-Path $env:TEMP "$packageName-$env:chocolateyPackageVersion"

# silent install requires AutoIT
#
$autoitExe    = 'AutoIt3.exe'
$toolsDir     = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$autoitFile   = Join-Path $toolsDir 'cleanup.au3'
$fileFullPath = Join-Path $workSpace $fullPackage

$autoitProcess = Start-Process -FilePath $autoitExe -ArgumentList "$autoitFile $fileFullPath" -PassThru

$installArgs = @{
   softwareName   = 'CleanUp*'
   packageName    = $packageName
   file           =  Join-Path $WorkSpace $fullPackage
   url            = $url
   checksum       = $checkSum
   checksumType   = 'sha256'
   fileType       = 'exe'
   silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName)-$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1"
   validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @installArgs
