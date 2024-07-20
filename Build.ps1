$ErrorActionPreference = "Stop"

[xml]$xml = Get-Content -Path "$PSScriptRoot\Directory.Build.Props"
$version = $xml.Project.PropertyGroup.Version

foreach ($platform in "ARM64", "x64")
{
    if (Test-Path -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.VivaldiFavorite\bin")
    {
        Remove-Item -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.VivaldiFavorite\bin\*" -Recurse
    }

    dotnet build $PSScriptRoot\Community.PowerToys.Run.Plugin.VivaldiFavorite.sln -c Release /p:Platform=$platform

    Remove-Item -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.VivaldiFavorite\bin\*" -Recurse -Include *.xml, *.pdb, PowerToys.*, Wox.*
    Rename-Item -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.VivaldiFavorite\bin\$platform\Release" -NewName "VivaldiFavorite"

    Compress-Archive -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.VivaldiFavorite\bin\$platform\VivaldiFavorite" -DestinationPath "$PSScriptRoot\VivaldiFavorite-$version-$platform.zip"
}
