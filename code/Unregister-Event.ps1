# if you need to unregister event triggers logging the data to previoulsy selected log file #>

# the only paramater from Register-WmiEvent.ps1 file needed here
[System.String]$script:strEventConsumerName = "EventConsumer";

Unregister-Event -SourceIdentifier $script:strEventConsumerName;

# Once this command is called, logfile ([System.String]$strLogfileName="$script:strExeName.log") in 
# log folder ([System.String]$strLogpathDir="C:\logs") should stop growing.
