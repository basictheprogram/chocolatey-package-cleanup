$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'CleanUp'
$url         = 'http://stevengould.org/downloads/cleanup/CleanUp452.exe'
$url64       = 'http://stevengould.org/downloads/cleanup/CleanUp452.exe'
$checkSum    = '6ac7576c0b48ddee292f85724c7917e11360927ff8e5c5a8d795577a4241c131'
$checkSum64  = '6ac7576c0b48ddee292f85724c7917e11360927ff8e5c5a8d795577a4241c131'

$WorkSpace = Join-Path $env:TEMP "$packageName.$env:chocolateyPackageVersion"

$WebFileArgs = @{
   packageName  = $packageName
   FileFullPath = Join-Path $WorkSpace "$packageName.exe"
   Url          = $url
   Url64bit     = $url64
   Checksum     = $checkSum
   Checksum64   = $checkSum64
   ChecksumType = 'sha256'
   GetOriginalFileName = $true
}

$PackedInstaller = Get-ChocolateyWebFile @WebFileArgs

$InstallArgs = @{
   PackageName    = $packageName
   File           = Join-Path $WorkSpace "$packageName.exe"
   fileType       = 'exe'
   silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1"
   validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @InstallArgs
