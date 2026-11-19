# Simple serial monitor: prints received bytes as ASCII text.
# Usage: powershell -ExecutionPolicy Bypass -File serial_monitor.ps1 [COM6] [115200]
param([string]$Port = 'COM6', [int]$Baud = 115200)

$sp = New-Object System.IO.Ports.SerialPort $Port, $Baud, 'None', 8, 'One'
$sp.Open()
Write-Host "Listening on $Port @ $Baud 8N1 - Ctrl+C to stop"
try {
    while ($true) {
        $s = $sp.ReadExisting()
        if ($s) { Write-Host -NoNewline $s }
        Start-Sleep -Milliseconds 100
    }
} finally {
    $sp.Close()
}
