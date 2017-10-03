$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName = 'CleanUp'
$version     = '452'
$fullPackage = $packageName + $version + '.exe'
$url         = 'http://stevengould.org/downloads/cleanup/' + $fullPackage
$url64       = 'http://stevengould.org/downloads/cleanup/' + $fullPackage
$checkSum    = '6ac7576c0b48ddee292f85724c7917e11360927ff8e5c5a8d795577a4241c131'
$checkSum64  = '6ac7576c0b48ddee292f85724c7917e11360927ff8e5c5a8d795577a4241c131'

$WorkSpace = Join-Path $env:TEMP "$packageName-$env:chocolateyPackageVersion"

$WebFileArgs = @{
   packageName  = $packageName
   FileFullPath = Join-Path $WorkSpace $fullPackage
   Url          = $url
   Url64bit     = $url64
   Checksum     = $checkSum
   Checksum64   = $checkSum64
   ChecksumType = 'sha256'
   GetOriginalFileName = $true
}

$PackedInstaller = Get-ChocolateyWebFile @WebFileArgs

# silent install requires AutoIT
#
$autoitExe = 'AutoIt3.exe'
$toolsDir    = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$autoitFile = Join-Path $toolsDir 'cleanup.au3'
$fileFullPath = Join-Path $WorkSpace $fullPackage
Write-Debug "$autoitFile"
Write-Debug "$fileFullPath"
$autoitProc = Start-Process -FilePath $autoitExe -ArgumentList "$autoitFile $fileFullPath" -PassThru
$autoitId = $autoitProc.Id
Write-Debug "$autoitExe start time:`t$($autoitProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID: `t$autoitId"

$InstallArgs = @{
   PackageName    = $packageName
   File           =  Join-Path $WorkSpace $fullPackage
   fileType       = 'exe'
   silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName)-$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1"
   validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @InstallArgs
