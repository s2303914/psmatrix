# --- REPAIRED MATRIX EFFECT ---
Clear-Host
$Width  = $Host.UI.RawUI.WindowSize.Width
$Height = $Host.UI.RawUI.WindowSize.Height
$Columns = @{}

# Pre-fill columns
for ($i = 0; $i -lt $Width; $i += 2) { 
    $Columns[$i] = Get-Random -Minimum 0 -Maximum $Height 
}

# Capture the keys into a fixed array once
$KeyArray = @($Columns.Keys)

while($true) {
    foreach ($col in $KeyArray) {
        
        # 1. Draw the "Lead" character in White
        $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates $col, $Columns[$col]
        $char = [char](Get-Random -Minimum 33 -Maximum 126)
        Write-Host $char -ForegroundColor White -NoNewline
        
        # 2. Add a Green Trail behind the head
        $trailPos = if ($Columns[$col] -eq 0) { $Height - 1 } else { $Columns[$col] - 1 }
        $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates $col, $trailPos
        Write-Host $char -ForegroundColor Green -NoNewline
        
        # 3. Increment position
        $Columns[$col] = ($Columns[$col] + 1) % $Height
        
        # 4. Cleanup/Flicker effect
        if ((Get-Random -Max 10) -gt 8) {
             $clearY = ($Columns[$col] + (Get-Random -Min 2 -Max 10)) % $Height
             $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates $col, $clearY
             Write-Host " " -NoNewline
        }
    }
    # Adjust this for speed (10 is fast, 50 is slow)
    Start-Sleep -Milliseconds 15
}