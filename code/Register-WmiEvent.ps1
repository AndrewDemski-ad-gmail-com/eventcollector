<# Event sink for java-related processes #>
[System.String]$script:strExeName="java%"; # or any other exe, pay attention to $strQuery below
[System.String]$strLogpathDir="C:\logs"
[System.String]$strLogfileName="$script:strExeName.log"
[System.String]$script:strEventConsumerName = "EventConsumer"

[System.Collections.Generic.List[System.String]]$arrParameters = New-Object System.Collections.Generic.List[System.String];
$arrParameters.Add("TargetInstance.ExecutablePath");
$arrParameters.Add("TargetInstance.CommandLine");
$arrParameters.Add("TargetInstance.Name");

function createFolder(){
    if (!(Test-Path $strLogpathDir -PathType Container)) {
        New-Item -ItemType Directory -Force -Path $strLogpathDir | Out-Null
    }
}

$fmtLine0 = "================================ EVENT MESSAGE ========================================="
$fmtLine1 = 'ProcessStarted: (ID={0,5}, Parent={1,5}, Time={2,20}, Name="{3}")'
$fmtLine2 = 'ExecutablePath: {0}'
$fmtLine3 = 'CommandLine: {0}'

function logMessage($strMessage)
{
    createFolder
    $strMessage | Out-File "$strLogpathDir`\$strLogfileName" -Append
}

[System.String]$selection = [System.String]::Join(',',$arrParameters);

[System.String]$strQuery = "SELECT $selection FROM __InstanceCreationEvent WITHIN 1 WHERE TargetInstance ISA `"Win32_Process`" AND TargetInstance.Name LIKE `"$script:strExeName.exe`" ";

# more extensive filtering including commandline
# [System.String]$strQuery = "SELECT $selection FROM __InstanceCreationEvent WITHIN 1 WHERE TargetInstance ISA `"Win32_Process`" AND TargetInstance.Name LIKE `"$script:strExeName.exe`" AND TargetInstance.CommandLine LIKE`"% -jar %`" "

Register-WmiEvent -SourceIdentifier $script:strEventConsumerName -Query $strQuery -Action {
        logMessage $fmtLine0
        $e = $EventArgs.NewEvent.TargetInstance
        # $msg1 = $fmtLine1 -f $e.ProcessId, $e.ParentProcessId, $EventArgs.TimeGenerated, $e.ProcessName
        # Write-host -ForegroundColor Red $msg 
        $e
        logMessage $($fmtLine1 -f $e.ProcessId, $e.ParentProcessId, $e.CreationDate, $e.ProcessName)
        logMessage $($fmtLine2 -f $e.ExecutablePath)
        logMessage $($fmtLine3 -f $e.CommandLine)
    }
Write-Host "Waiting for events"
