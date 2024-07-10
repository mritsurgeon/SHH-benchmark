$username = "root"
$hostname = "Hostname"
$password = "Veeam123"
$commandToRun = "ls /home"
$iterations = 5
$totalTime = 0
$minTime = [System.Double]::MaxValue
$maxTime = 0

$results = @()

for ($i = 1; $i -le $iterations; $i++) {
    $startTime = Get-Date
    try {
        & 'C:\Program Files\PuTTY\plink.exe' -ssh -l $username -pw $password -batch -noagent $hostname "$commandToRun; exit" | Out-Null
        $commandStatus = if ($LASTEXITCODE -eq 0) { "Command executed successfully" } else { "Command failed" }
    }
    catch {
        $commandStatus = "Error: $_"
    }
    $endTime = Get-Date

    $duration_ms = ($endTime - $startTime).TotalMilliseconds
    $duration_seconds = $duration_ms / 1000
    $duration_minutes = $duration_seconds / 60

    $totalTime += $duration_ms
    if ($duration_ms -lt $minTime) { $minTime = $duration_ms }
    if ($duration_ms -gt $maxTime) { $maxTime = $duration_ms }

    $resultObject = [PSCustomObject]@{
        Attempt = $i
        Duration_ms = [math]::Round($duration_ms, 2)
        Duration_seconds = [math]::Round($duration_seconds, 2)
        Duration_minutes = [math]::Round($duration_minutes, 4)
        Status = $commandStatus
    }

    $results += $resultObject

    Write-Output ("Attempt {0}: {1:N2} ms" -f $i, $duration_ms)
}

$averageTime_ms = $totalTime / $iterations
$averageTime_seconds = $averageTime_ms / 1000
$averageTime_minutes = $averageTime_seconds / 60

# Output results in a structured format
Write-Host "SSH Connection Test Results" -ForegroundColor Yellow
if ($results.Count -gt 0) {
    $results | Format-Table -AutoSize
} else {
    Write-Host "No results found." -ForegroundColor Yellow
}

Write-Host ("Average time: {0:N2} ms ({1:N2} seconds, {2:N4} minutes)" -f $averageTime_ms, $averageTime_seconds, $averageTime_minutes) -ForegroundColor Green
Write-Host ("Minimum time: {0:N2} ms ({1:N2} seconds, {2:N4} minutes)" -f $minTime, ($minTime/1000), ($minTime/60000)) -ForegroundColor Green
Write-Host ("Maximum time: {0:N2} ms ({1:N2} seconds, {2:N4} minutes)" -f $maxTime, ($maxTime/1000), ($maxTime/60000)) -ForegroundColor Green