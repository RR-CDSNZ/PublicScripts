##########################################################################################################
##########################################################################################################

# CIS Microsoft Windows Server 2022 Benchmark based on https://workbench.cisecurity.org/benchmarks/8932
# Script by Evan Greene from https://github.com/eneerge/CIS-Windows-Server-2022

# HYB - Modified Version - 29/10/24
# v05

#########################################################
# HYB - Defender Exclusions
#########################################################

$DefenderExclusionPaths = @(
    "C:\Windows\assembly\*",
    "C:\Program Files (x86)\IIS Express\*",
    "%USERPROFILE%\.dotnet\*",
    "%USERPROFILE%\.librarymanager\*",
    "%USERPROFILE%\AppData\Local\Microsoft\VisualStudio\*",
    "%USERPROFILE%\AppData\Local\Microsoft\VisualStudio Services\*",
    "%USERPROFILE%\AppData\Local\GitCredentialManager\*",
    "%USERPROFILE%\AppData\Local\GitHubVisualStudio\*",
    "%USERPROFILE%\AppData\Local\Microsoft\dotnet\*",
    "%USERPROFILE%\AppData\Local\Microsoft\VSApplicationInsights\*",
    "%USERPROFILE%\AppData\Local\Microsoft\VSCommon\*",
    "%USERPROFILE%\AppData\Local\Temp\VSFeedbackIntelliCodeLogs\*",
    "%USERPROFILE%\AppData\Roaming\Microsoft\VisualStudio\*",
    "%USERPROFILE%\AppData\Roaming\NuGet\*",
    "%USERPROFILE%\AppData\Roaming\Visual Studio Setup\*",
    "%USERPROFILE%\AppData\Roaming\vstelemetry\*",
    "%USERPROFILE%\AppData\Roaming\HeidiSQL\*",
    "C:\ProgramData\Microsoft\VisualStudio\*",
    "C:\ProgramData\Microsoft\NetFramework\*",
    "C:\ProgramData\Microsoft Visual Studio\*",
    "C:\ProgramData\MySQL\*",
    "C:\Program Files\Microsoft Visual Studio\*",
    "C:\Program Files\dotnet\*",
    "C:\Program Files\Microsoft SDKs\*",
    "C:\Program Files\Microsoft SQL Server\*",
    "C:\Program Files\MySQL\*",
    "C:\Program Files\IIS\*",
    "C:\Program Files\IIS Express\*",
    "C:\Program Files (x86)\Microsoft Visual Studio\*",
    "C:\Program Files (x86)\dotnet\*",
    "C:\Program Files (x86)\Microsoft SDKs\*",
    "C:\Program Files (x86)\Microsoft SQL Server\*",
    "C:\Program Files (x86)\IIS\*",
    "C:\source\repos\*",
    "%USERPROFILE%\Downloads\HeidiSQL_10.1_64_Portable\*",
    "C:\Program Files (x86)\MSBuild\*",
    "C:\Program Files (x86)\Microsoft SDKs\NuGetPackages\*",
    "C:\Program Files (x86)\Microsoft SDKs\TypeScript\*",
    "C:\Program Files (x86)\Entity Framework Tools\*",
    "C:\Program Files (x86)\Microsoft Web Tools\*",
    "C:\Program Files (x86)\Microsoft.NET\*",
    "C:\Program Files (x86)\MySQL\*",
    "C:\Program Files (x86)\NuGet\*",
    "C:\Program Files\Git\*",
    "C:\ProgramData\Git\*",
    "C:\src\*",
    "C:\TFSProjects\*",
    "%USERPROFILE%\.nuget\*",
    "%USERPROFILE%\.vscode\*",
    "%USERPROFILE%\.ssh\*",
    "%USERPROFILE%\.apricotdb\*",
    "%USERPROFILE%\.dbgate\*",
    "%USERPROFILE%\.rest-client\*",
    "C:\Program Files (x86)\WiX Toolset v3.11\bin",
    "C:\Program Files\Cisco\AMP\",
    "C:\Program Files\Cisco\AMP\*",
    "C:\Windows\System32\LogFiles\Firewall\*"
)


$DefenderExclusionProcesses = @(
    "ServiceHub.IdentityHost.exe",
    "ServiceHub.VSDetouredHost.exe",
    "ServiceHub.Host.CLR.x86.exe",
    "Microsoft.ServiceHub.Controller.exe",
    "PerfWatson2.exe",
    "sqlwriter.exe",
    "devenv.exe",
    "dotnet.exe",
    "mysqld.exe",
    "msbuild.exe",
    "node.exe",
    "git.exe",
    "heidisql.exe",
    "node.js",
    "ServiceHub.Host.Node.x86.exe",
    "vbcscompiler.exe",
    "testhost.exe",
    "datacollector.exe",
    "IntelliTrace.exe",
    "CodeCoverage.exe",
    "code.exe",
    "ServiceHub.DataWarehouseHost.exe",
    "ServiceHub.Host.CLR.exe",
    "ServiceHub.Host.CLR.x64.exe",
    "ServiceHub.IndexingService.exe",
    "ServiceHub.RoslynCodeAnalysisService.exe",
    "ServiceHub.SettingsHost.exe",
    "ServiceHub.TestWindowStoreHost.exe",
    "ServiceHub.ThreadedWaitDialog.exe",
    "vstest.console.exe",
    "Microsoft.VisualStudio.Web.Host.exe",
    "Microsoft.WebTools.Languages.LanguageServer.Host.exe",
    "sqlservr.exe",
    "com.docker.service.exe",
    "Code.exe",
    "gpg-agent.exe",
    "gpg-connect-agent.exe",
    "ssh-agent.exe",
    "vsls-agent.exe",
    "iisexpress.exe",
    "nvm.exe",
    "wsl.exe",
    "MSBuild.exe",
    "ServiceHub.Host.AnyCPU.exe",
    "VBCSCompiler.exe",
    "light.exe",
    "C:\Program Files\Cisco\AMP\sfc.exe",
    "sfc.exe"
)

$DefenderExclusionExtensions = @(
    "idb",
    "lib",
    "obj",
    "pdb",
    "sbr",
    "cs"
)



#########################################################
# Policy Configuration
# Comment out any policy you do not wish to implement.
# Note that the "Compatibility Assurance" section you configured above above may override your wishes to ensure software your software works.
#########################################################
$ExecutionList = @(
  
    ##########################################################
    # HYB - Additional Settings deployment functions
    "AddDefenderExclusions",                                            # HYB - Add Defender Exclusions
    "EnableSecurityAuditing"                                            # HYB - Enable Security Event auditing
)


# End configuration
#=========================================================================================================

##########################################################################################################
# DO NOT CHANGE CODE BELLOW THIS LINE IF YOU ARE NOT 100% SURE ABOUT WHAT YOU ARE DOING!
##########################################################################################################
##########################################################################################################
##########################################################################################################

$global:valueChanges = @()

$fc = $host.UI.RawUI.ForegroundColor
$host.UI.RawUI.ForegroundColor = "White"

function Write-Info($text) {
    Write-Host $text -ForegroundColor Yellow
}

function Write-Before($text) {
    Write-Host $text -ForegroundColor Cyan
}

function Write-After($text) {
    Write-Host $text -ForegroundColor Green
}

function Write-Red($text) {
    Write-Host $text -ForegroundColor Red
}

function CheckError([bool] $result, [string] $message) {
  # Checks the specified result value and terminates the
  # the script after printing the specified error message 
  # if the specified result is false.
    if ($result -eq $false) {
        Write-Host $message -ForegroundColor Red
        throw $message
    }
}

function RegKeyExists([string] $path) {
  # Checks whether the specified registry key exists
  $result = Get-Item $path -ErrorAction SilentlyContinue
  $?
}

function SetRegistry([string] $path, [string] $key, [string] $value, [string] $keytype) {
  # Sets the specified registry value at the specified registry path to the specified value.
  # First the original value is read and print to the console.
  # If the original value does not exist, it is additionally checked
  # whether the according registry key is missing too.
  # If it is missing, the key is also created otherwise the 
  # Set-ItemProperty call would fail.
  #
  # The original implementation used try-catch to handle the errors
  # of Get-ItemProperty for missing values. However, Set-ItemProperty
  # is not throwing any exceptions. The error handling has to be done
  # by overwriting the -ErrorAction of the CmdLet and check the
  # $? variable afterwards.
  #
  # See: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters?view=powershell-7
  # See: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables?view=powershell-7

  $before = Get-ItemProperty -Path $path -Name $key -ErrorAction SilentlyContinue
  
  if ($?) {
    Write-Before "Was: $($before.$key)"
  }
  else {
    Write-Before "Was: Not Defined!"
    $keyExists = RegKeyExists $path
    
    if ($keyExists -eq $false) {
      Write-Info "Creating registry key '$($path)'."
      New-Item $path -Force -ErrorAction SilentlyContinue
      CheckError $? "Creating registry key '$($path)' failed."
    }
  }

    Set-ItemProperty -Path $path -Name $key -Value $value -Type $keytype -ErrorAction SilentlyContinue

    CheckError $? "Creating registry value '$($path):$($value)' failed."
    
    $after = Get-ItemProperty -Path $path -Name $key -ErrorAction SilentlyContinue
    Write-After "Now: $($after.$key)"

    if ($before.$key -ne $after.$key) {
        Write-Red "Value changed."
        $global:valueChanges += "$path => $($before.$key) to $($after.$key)"
    }
}

function DeleteRegistryValue([string] $path, [string] $key) {
  $before = Get-ItemProperty -Path $path -Name $key -ErrorAction SilentlyContinue
  if ($?) {
    Write-Before "Was: $($before.$key)"
  }
  else {
    Write-Before "Was: Not Defined!"
  }

  Remove-ItemProperty -Path $path -Name $key -ErrorAction SilentlyContinue

  $after = Get-ItemProperty -Path $path -Name $key -ErrorAction SilentlyContinue

  if ($?) {
    Write-After "Now: $($after.$key)"
  }
  else {
    Write-After "Now: Not Defined!"
  }

  if ($before.$key -ne $after.$key) {
    Write-Red "Value changed."
    $global:valueChanges += "$path => $($before.$key) to $($after.$key)"
  }
}


# ----------------------------------
# HYB - Add Defender Exclusions
function AddDefenderExclusions {
    Write-Info "HYB - Starting Defender Exclusions Setup"
    #Clear current exclusions
    Write-Info "Clearing existing Exclusions"
    $currentExclusionPaths = (Get-MpPreference).ExclusionPath
    foreach ($e in $currentExclusionPaths) {
        Remove-MpPreference -ExclusionPath $e
    }
    $currentExclusionProcesses = (Get-MpPreference).ExclusionProcess
    foreach ($e in $currentExclusionProcesses) {
        Remove-MpPreference -ExclusionProcess $e
    }
    $currentExclusionExtensions = (Get-MpPreference).ExclusionExtension
    foreach ($e in $currentExclusionExtensions) {
        Remove-MpPreference -ExclusionExtension $e
    }

    # Create the Defender Exclusions
    Write-Info "Creating new Defender Exclusions - Paths"
    foreach ($e in $DefenderExclusionPaths) {
        #Write-Info "Excluding: " $e
        Add-MpPreference -ExclusionPath $e
    }
    Write-Info "Creating new Defender Exclusions - Processes"
    foreach ($e in $DefenderExclusionProcesses) {
       #Write-Info "Excluding: " $e
        Add-MpPreference -ExclusionProcess $e
    }
    Write-Info "Creating new Defender Exclusions - Extensions"
    foreach ($e in $DefenderExclusionExtensions) {
        #Write-Info "Excluding: " $e
        Add-MpPreference -ExclusionExtension $e
    }
}



# ----------------------------------
# HYB - Windows Defender Auto Signature updates
function ConfigureDefenderSignatureUpdates {
    # Check for signature updates every day, every 4 hours
    Set-MpPreference -SignatureScheduleDay 0 -SignatureUpdateInterval 4
    # Limit Defender CPU usage to 25%
    Set-MpPreference -ScanAvgCPULoadFactor 25
}



# ----------------------------------------------------------------------
# Function Calls

if ([Environment]::Is64BitProcess -ne [Environment]::Is64BitOperatingSystem)
{
    Write-Error "You must execute this script on a x64 shell"
    Write-Error "Aborted."
    return 1;
}

if(([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator") -eq $false) {
    Write-Error "You must execute this script with administrator privileges!"
    Write-Error "Aborted."
    return 1;
}



$location = Get-Location
    
secedit /export /cfg "$location\secedit_original.cfg"  | out-null
    
Start-Transcript -Path "$location\PolicyResults.txt"
$ExecutionList | ForEach-Object { ( Invoke-Expression $_) } | Out-File $location\CommandsReport.txt
Stop-Transcript
    
"The following policies were defined in the ExecutionList: " | Out-File $location\PoliciesApplied.txt
$ExecutionList | Out-File $location\PoliciesApplied.txt -Append

Write-Host ""

Start-Transcript -Path "$location\PolicyChangesMade.txt"
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
Write-After "Changes Made"
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
Write-Red ($global:valueChanges -join "`n")
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
Stop-Transcript 

secedit /export /cfg $location\secedit_final.cfg | out-null

Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
Write-After "Completed. Logs written to: $location"
    

$host.UI.RawUI.ForegroundColor = $fc
