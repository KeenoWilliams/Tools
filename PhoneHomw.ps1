# Set variables
$ipAddress = "192.168.0.1"
$action = New-ScheduledTaskAction -Execute "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -Command `"Invoke-WebRequest -Uri <http://$ipAddress`>""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 30) -RepetitionDuration ([TimeSpan]::MaxValue)

# Create scheduled task
Register-ScheduledTask -TaskName "Call Home" -Action $action -Trigger $trigger -User "SYSTEM" -RunLevel Highest -Force
