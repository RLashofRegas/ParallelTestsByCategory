dotnet build

$VSTestPath = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\Extensions\TestPlatform\vstest.console.exe"
$BuildPath = ".\bin\Debug\netcoreapp3.1"
$AssemblyDllName = "ParallelTests.dll"

$TestsDeployBase = ".\TestDeploy"
$TestThreadDirBase = "Thread"

$NumThreads = 2

$TestArgs = @( )

for ($i = 0; $i -lt $NumThreads; $i++)
{
    $ThreadDir = "$TestThreadDirBase$i"
    $ThreadDirPath = "$TestsDeployBase\$ThreadDir"

    if (Test-Path $ThreadDirPath)
    {
        Remove-Item -LiteralPath $ThreadDirPath -Recurse -Force
    }

    New-Item -Path $TestsDeployBase -Name $ThreadDir -ItemType "directory"
    Copy-Item "$BuildPath\**" $ThreadDirPath -Recurse

    $AppSettingsPath = "$ThreadDirPath\appsettings.json"
    (Get-Content $AppSettingsPath).replace("<category to run>", "category$i") | Set-Content $AppSettingsPath

    $TestArgs += "$ThreadDirPath\$AssemblyDllName"
}

$TestArgs += "/Settings:test.runsettings"
$TestArgs += "/Parallel"

& $VSTestPath $TestArgs
