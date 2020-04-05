# Variables
$targetDirName = "$(Split-Path -Path $PSScriptRoot -Leaf)_AppConfig"
Set-Location -Path $PSScriptRoot

# Extensions to be treated as configuration files.
$configExtensions = @("*.xml", "*.json", "*.config")

# Create Target directory
$targetDir = New-Item -Path ".." -Name $targetDirName -ItemType "directory" -Force

Copy-Item -Path ".\*" -Destination $targetDir.FullName  -Recurse -Force

$filesToRemove = $(Get-ChildItem -Path $targetDir.FullName -Exclude $configExtensions -Recurse |
    Where-Object Extension -ne "").FullName

foreach ($file in $filesToRemove) {
    Remove-Item -Path $file
}
