Write-Host "test if compiled app exists"
if (-not (Test-Path 'c:\result\compiled.app')) { $host.SetShouldExit(1)  }