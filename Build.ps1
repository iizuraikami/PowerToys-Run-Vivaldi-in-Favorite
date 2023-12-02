$ErrorActionPreference = "Stop"

[xml]$xml = Get-Content -Path "$PSScriptRoot\Directory.Build.Props"
$version = $xml.Project.PropertyGroup.Version

foreach ($platform in "ARM64", "x64")
{
    if (Test-Path -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.ChromeFavorite\bin")
    {
        Remove-Item -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.ChromeFavorite\bin\*" -Recurse
    }

    dotnet build $PSScriptRoot\Community.PowerToys.Run.Plugin.ChromeFavorite.sln -c Release /p:Platform=$platform

    Remove-Item -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.ChromeFavorite\bin\*" -Recurse -Include *.xml, *.pdb, PowerToys.*, Wox.*
    Rename-Item -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.ChromeFavorite\bin\$platform\Release" -NewName "ChromeFavorite"

    Compress-Archive -Path "$PSScriptRoot\Community.PowerToys.Run.Plugin.ChromeFavorite\bin\$platform\ChromeFavorite" -DestinationPath "$PSScriptRoot\ChromeFavorite-$version-$platform.zip"
}
